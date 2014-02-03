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


@interface EKContactsViewController () <UISearchBarDelegate>

@property (nonatomic, strong) EKContactsView              *contactsView;
@property (nonatomic, strong) EKAppDelegate               *appDelegate;
@property (nonatomic, strong) EKContactsTableViewProvider *tableViewProvider;

@end


@implementation EKContactsViewController

#pragma mark - Live cycle

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
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
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
	NSArray *data = [EKAddressBookUtil persons];
    
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

@end
