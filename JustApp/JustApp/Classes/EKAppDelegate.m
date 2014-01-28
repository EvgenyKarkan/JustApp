//
//  EKAppDelegate.m
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKAppDelegate.h"
#import "EKMenuViewController.h"
#import "EKCameraViewController.h"
#import "MMDrawerVisualStateManager.h"

static NSString * const kEKRestorationID  = @"MMDrawer";
static CGFloat    const kEKTitleFontSize  = 18.0f;
static CGFloat    const kEKDrawerSize     = 260.0f;

@interface EKAppDelegate ()

@property (nonatomic, strong) EKCameraViewController *cameraViewController;
@property (nonatomic, strong) UINavigationController *navigationViewControllerCenter;

@end


@implementation EKAppDelegate;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    EKMenuViewController *menuViewController = [[EKMenuViewController alloc] init];
    self.cameraViewController = [[EKCameraViewController alloc] init];
    
    UINavigationController *navigationViewControllerLeft = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    
    self.navigationViewControllerCenter = [[UINavigationController alloc] initWithRootViewController:self.cameraViewController];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:self.navigationViewControllerCenter
	                                                        leftDrawerViewController:navigationViewControllerLeft];
    
    [self.drawerController setRestorationIdentifier:kEKRestorationID];
	[self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
	[self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
	[self.drawerController setMaximumLeftDrawerWidth:kEKDrawerSize];
	[self.drawerController setShowsShadow:YES];
	self.drawerController.shouldStretchDrawer = NO;
    
	[[MMDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeParallax];
    
	[self.drawerController setDrawerVisualStateBlock: ^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
	    MMDrawerControllerDrawerVisualStateBlock block;
	    block = [[MMDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
	    if (block) {
	        block(drawerController, drawerSide, percentVisible);
		}
	}];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[self.window setRootViewController:self.drawerController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
