//
//  EKMenuViewController.m
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMenuViewController.h"
#import "EKMenuView.h"
#import "EKMenuTableViewProvider.h"
#import "EKAppDelegate.h"
#import "EKCameraViewController.h"
#import "EKFontsUtil.h"
#import "EKMapViewController.h"

@interface EKMenuViewController () <EKMenuTableViewProviderDelegate>

@property (nonatomic, strong) EKMenuView              *menuView;
@property (nonatomic, strong) EKMenuTableViewProvider *tableViewProvider;
@property (nonatomic, strong) EKAppDelegate           *appDelegate;
@property (nonatomic, strong) EKMapViewController     *mapViewController;

@end


@implementation EKMenuViewController;

#pragma mark - Life cycle

- (void)loadView
{
    EKMenuView *view = [[EKMenuView alloc] init];
	self.view = view;
	self.menuView = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.title = NSLocalizedString(@"JustMenu", @"JustMenu");
    
    self.tableViewProvider = [[EKMenuTableViewProvider alloc] initWithDelegate:self];
    self.menuView.tableView.delegate = self.tableViewProvider;
	self.menuView.tableView.dataSource = self.tableViewProvider;
    
    self.mapViewController = [[EKMapViewController alloc] init];
}

#pragma mark - Show controllers

- (void)showCameraViewController
{
	[self.appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
	if ([((UINavigationController *)self.appDelegate.drawerController.centerViewController).topViewController isKindOfClass:[EKCameraViewController class]]) {
		[self.appDelegate.drawerController toggleDrawerSide:MMDrawerSideLeft
                                                   animated:YES
                                                 completion:nil];
	}
	else {
		[self.appDelegate.drawerController setCenterViewController:self.appDelegate.navigationViewControllerCenter
		                                        withCloseAnimation:YES
		                                                completion:nil];
	}
}

- (void)showMapViewController
{
    [self.appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
	UINavigationController *foo = [[UINavigationController alloc] initWithRootViewController:self.mapViewController];
    
	[self.appDelegate.drawerController setCenterViewController:foo
	                                        withCloseAnimation:YES
	                                                completion:nil];
}

#pragma mark - EKMenuTableViewProviderDelegate

- (void)cellDidPressWithIndex:(NSUInteger)index
{
	NSParameterAssert(index >= 0);
    
	switch (index) {
		case 0:
            [self showCameraViewController];
			break;
            
		case 1:
            [self showMapViewController];
			break;
            
		case 2:

			break;
            
		case 3:

			break;
            
		case 4:

			break;
            
		case 5:

			break;
            
		default:
			break;
	}
}

@end
