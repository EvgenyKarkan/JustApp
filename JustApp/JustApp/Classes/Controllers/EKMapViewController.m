//
//  EKMapViewController.m
//  JustApp
//
//  Created by Evgeny Karkan on 31.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMapViewController.h"
#import "EKLayoutUtil.h"
#import "EKFontsUtil.h"
#import "EKAppDelegate.h"

@interface EKMapViewController ()

@property (nonatomic, strong) EKAppDelegate *appDelegate;

@end


@implementation EKMapViewController;


- (void)viewDidLoad
{
	[super viewDidLoad];
    
	self.appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = BACKGROUND_COLOR;
	self.title = NSLocalizedString(@"JustMap", @"JustMap");
    
    [self setupLeftMenuButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Side-menu button with handler

- (void)setupLeftMenuButton
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
}

- (void)leftDrawerButtonPress:(id)sender
{
    NSParameterAssert(sender != nil);
    
    self.appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
	[self.appDelegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
