//
//  EKSettingsViewController.m
//  JustApp
//
//  Created by Evgeny Karkan on 03.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKSettingsViewController.h"
#import "EKFontsUtil.h"
#import "EKLayoutUtil.h"
#import "EKAppDelegate.h"

@interface EKSettingsViewController ()

@property (nonatomic, strong) EKAppDelegate *appDelegate;
@property (nonatomic, strong) UIImageView   *centerImage;

@end


@implementation EKSettingsViewController;

#pragma mark - Life cycle

- (void)viewDidLoad
{
	[super viewDidLoad];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

#pragma mark - Action

- (void)buttonPressed:(id)sender
{
	SDImageCache *imageCache = [SDImageCache sharedImageCache];
	[imageCache clearMemory];
	[imageCache clearDisk];
	[imageCache cleanDisk];
    
    [SVProgressHUD showSuccessWithStatus:@"Cache cleared!"];
}

- (void)setUpUI
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
	self.title = NSLocalizedString(@"JustSettings", @"JustSettings");
    
    if (![EKLayoutUtil isSystemVersionLessThan7]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = BACKGROUND_COLOR;
	UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
	clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
	clearButton.frame = CGRectMake(self.view.frame.size.width / 2.0f - 80.0f, 380.0f, 160.0f, 32.0f);

	clearButton.showsTouchWhenHighlighted = YES;
    
	[clearButton setTitle:NSLocalizedString(@"Clear cache", @"")
	             forState:UIControlStateNormal];
	[clearButton.titleLabel setFont:[UIFont fontWithName:[EKFontsUtil fontName]
	                                                size:15.0f]];
	[clearButton addTarget:self
	                action:@selector(buttonPressed:)
	      forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:clearButton];
    
    self.centerImage = [[UIImageView alloc] init];
    self.centerImage.image = [UIImage imageNamed:kEKFaceAsset];
    self.centerImage.layer.borderColor = NAV_BAR_BACKGROUND_COLOR.CGColor;
    self.centerImage.layer.borderWidth = 5.0f;
    CGFloat imageSide       = self.view.frame.size.width / 1.25f;
    CGFloat halfSelfWidth   = self.view.frame.size.width / 2.0f;
    self.centerImage.frame  = CGRectMake(halfSelfWidth - imageSide / 2.0f, 45.0f, imageSide, imageSide);
    [self.view addSubview:self.centerImage];
    
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
