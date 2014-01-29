//
//  EKAppDelegate.h
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


@interface EKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MMDrawerController *drawerController;
@property (nonatomic, strong) UINavigationController *navigationViewControllerCenter;

@end
