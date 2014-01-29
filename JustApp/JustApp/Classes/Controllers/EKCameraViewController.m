//
//  EKCameraViewController.m
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKCameraViewController.h"
#import "EKCameraView.h"
#import "EKAppDelegate.h"
#import "EKLayoutUtil.h"

    // Transform values for full screen support:
#define CAMERA_TRANSFORM_X 1
    //#define CAMERA_TRANSFORM_Y 1.12412 // this was for iOS 3.x
#define CAMERA_TRANSFORM_Y 1.24299 // this works for iOS 4.x

@interface EKCameraViewController ()

@property (nonatomic, strong) EKCameraView *cameraView;
@property (nonatomic, strong) EKAppDelegate *appDelegate;

@end


@implementation EKCameraViewController;

#pragma mark - Life cycle

- (void)loadView
{
	EKCameraView *view = [[EKCameraView alloc] init];
	self.view = view;
	self.cameraView = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"JustCamera", @"JustCamera");
    self.navigationController.navigationBar.titleTextAttributes = @{ UITextAttributeTextColor:[UIColor whiteColor],
                                                                     UITextAttributeFont:[UIFont systemFontOfSize:17.0f]};
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self setupLeftMenuButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//        // Create a new image picker instance:
//	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//	
//        // Set the image picker source:
//	picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//	
//        // Hide the controls:
//	picker.showsCameraControls = YES;
//	picker.navigationBarHidden = NO;
//	
//        // Make camera view full screen:
//	picker.wantsFullScreenLayout = YES;
//	picker.cameraViewTransform = CGAffineTransformScale(picker.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
//	
//        // Insert the overlay:
//        //picker.cameraOverlayView = overlay;
//	
//        // Show the picker:
//    
//    [self presentViewController:picker animated:YES completion:nil];


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
