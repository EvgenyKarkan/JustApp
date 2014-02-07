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
#import "EKMusicPlayerViewController.h"
#import "EKContactsViewController.h"
#import "EKGalleryViewController.h"
#import "EKSettingsViewController.h"

@interface EKMenuViewController () <EKMenuTableViewProviderDelegate>

@property (nonatomic, strong) EKMenuView                  *menuView;
@property (nonatomic, strong) EKMenuTableViewProvider     *tableViewProvider;
@property (nonatomic, strong) EKAppDelegate               *appDelegate;
@property (nonatomic, strong) EKMapViewController         *mapViewController;
@property (nonatomic, strong) EKMusicPlayerViewController *musicPlayerViewController;
@property (nonatomic, strong) EKContactsViewController    *contactsViewController;
@property (nonatomic, strong) EKGalleryViewController     *galleryViewController;
@property (nonatomic, strong) EKSettingsViewController    *settingsViewController;

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
    [self.navigationController.navigationBar setTranslucent:NO];
    self.title = NSLocalizedString(@"JustMenu", @"JustMenu");
    
    self.tableViewProvider = [[EKMenuTableViewProvider alloc] initWithDelegate:self];
    self.menuView.tableView.delegate = self.tableViewProvider;
    self.menuView.tableView.dataSource = self.tableViewProvider;
    
    self.mapViewController = [[EKMapViewController alloc] init];
    self.musicPlayerViewController = [[EKMusicPlayerViewController alloc] init];
    self.contactsViewController = [[EKContactsViewController alloc] init];
    self.galleryViewController = [[EKGalleryViewController alloc] init];
    self.settingsViewController = [[EKSettingsViewController alloc] init];
}

#pragma mark - Show controllers

- (void)showCameraViewController
{
    [self.appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    if ([((UINavigationController *)self.appDelegate.drawerController.centerViewController).topViewController isKindOfClass :[EKCameraViewController class]]) {
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

- (void)showViewController:(UIViewController *)controller
{
    [self.appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    UINavigationController *foo = [[UINavigationController alloc] initWithRootViewController:controller];
    
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
            [self showViewController:self.mapViewController];
            break;
            
        case 2:
            [self showViewController:self.musicPlayerViewController];
            break;
            
        case 3:
            [self showViewController:self.contactsViewController];
            break;
            
        case 4:
            [self showViewController:self.galleryViewController];
            break;
            
        case 5:
            [self showViewController:self.settingsViewController];
            break;
            
        default:
            break;
    }
}

@end
