//
//  EKContactsViewController.m
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKContactsViewController.h"
#import "EKContactsView.h"
#import "EKContactsTableViewProvider.h"
#import "EKLayoutUtil.h"
#import "EKAppDelegate.h"
#import "EKAddressBookUtil.h"
#import "EKPerson.h"


@interface EKContactsViewController () <UISearchBarDelegate>

@property (nonatomic, strong) EKContactsView              *contactsView;
@property (nonatomic, strong) EKAppDelegate               *appDelegate;
@property (nonatomic, strong) EKContactsTableViewProvider *tableViewProvider;

@end


@implementation EKContactsViewController

#pragma mark - Life cycle

- (void)loadView
{
	EKContactsView *view = [[EKContactsView alloc] init];
	self.view = view;
	self.contactsView = view;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    
	[self setupUI];
	[self handleAccessToAdressBookForCurrentAccesType:[EKAddressBookUtil currentAccessType]];
    
    self.contactsView.searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(onKeyboardHide:)
	                                             name:UIKeyboardWillHideNotification
	                                           object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - AddressBook access stuff

- (void)handleAccessToAdressBookForCurrentAccesType:(EKAddressBookAccessType)currentAccessType
{
	switch (currentAccessType) {
		case EKAddressBookAccessTypeDeniedInitially:
			[SVProgressHUD showErrorWithStatus:@"No acces to AddressBook. Go to settings and turn it on."];
			break;
            
		case EKAddressBookAccessTypeGrantedInitially:
			[self loadAddressBookDataAndPassItToTableViewProvider];
			break;
            
		case EKAddressBookAccessTypeDeniedPreviously:
			[SVProgressHUD showErrorWithStatus:@"No acces to AddressBook. Go to settings and turn it on."];
			break;
            
		case EKAddressBookAccessTypeGrantedPreviously:
			[self loadAddressBookDataAndPassItToTableViewProvider];
			break;
            
		default:
			break;
	}
}

- (void)loadAddressBookDataAndPassItToTableViewProvider
{
	NSMutableArray *data = [EKAddressBookUtil persons];
    
	if ([data count] > 0 && data != nil) {
		self.tableViewProvider = [[EKContactsTableViewProvider alloc] initWithData:data];
		self.contactsView.tableView.delegate = self.tableViewProvider;
		self.contactsView.tableView.dataSource = self.tableViewProvider;
	}
	else {
		[SVProgressHUD showErrorWithStatus:@"AddressBook is empty. Sorry"];
	}
}

#pragma mark - UI

- (void)setupUI
{
	MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self
	                                                                                 action:@selector(leftDrawerButtonPress:)];
	leftDrawerButton.tintColor = [UIColor whiteColor];
    
	if ([EKLayoutUtil isSystemVersionLessThan7]) {
		UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
		                                                                        target:nil
		                                                                        action:nil];
		spacer.width = 12.0f;
		[self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:spacer, leftDrawerButton, nil]
		                                  animated:NO];
	}
	else {
		[self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
	}
    
	[self.navigationController.navigationBar setTranslucent:NO];
	self.title = NSLocalizedString(@"JustContacts", @"JustContacts");
    
    if (![EKLayoutUtil isSystemVersionLessThan7]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)sender
{
	NSParameterAssert(sender != nil);
    
	self.appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
	[self.appDelegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - UISearchBarDelegate stuff

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	self.contactsView.searchBar.showsCancelButton = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if ([self.tableViewProvider.searchData count] > 0) {
		[self.tableViewProvider.searchData removeAllObjects];
	}
    
	if ([searchText length] > 0) {
		self.tableViewProvider.searching = YES;
		for (NSUInteger i = 0; i < [self.tableViewProvider.data count]; i++) {
			NSParameterAssert(self.tableViewProvider.data[i] != nil);
            
			NSString *name = ((EKPerson *)self.tableViewProvider.data[i]).firstName;
			NSString *lastName = ((EKPerson *)self.tableViewProvider.data[i]).lastName;
			NSString *fullName = [NSString stringWithFormat:@"%@%@", name, lastName];
            
			NSRange titleResultsRange = [fullName rangeOfString:searchText options:NSCaseInsensitiveSearch];
			if (titleResultsRange.length > 0) {
				[self.tableViewProvider.searchData addObject:[self.tableViewProvider.data objectAtIndex:i]];
			}
		}
	}
	else {
		self.tableViewProvider.searching = NO;
	}
    
    [SVProgressHUD showErrorWithStatus:@"Search is unfinished"];
	[self.contactsView.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[[searchBar valueForKey:@"_searchField"] resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	self.contactsView.searchBar.text = @"";
	[self.contactsView.searchBar resignFirstResponder];
	self.contactsView.searchBar.showsCancelButton = NO;
    
	[self.tableViewProvider.searchData removeAllObjects];
	self.tableViewProvider.searching = NO;
    
	[self.contactsView.tableView reloadData];
}

#pragma mark - Listening to UIKeybord notification

- (void)onKeyboardHide:(NSNotification *)notification
{
	self.contactsView.searchBar.showsCancelButton = NO;
}

@end
