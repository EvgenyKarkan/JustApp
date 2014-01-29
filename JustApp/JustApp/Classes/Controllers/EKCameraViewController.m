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
#import "EKFontsUtil.h"

    // Transform values for full screen support:
#define CAMERA_TRANSFORM_X 1
    //#define CAMERA_TRANSFORM_Y 1.12412 // this was for iOS 3.x
#define CAMERA_TRANSFORM_Y 1.24299 // this works for iOS 4.x

@interface EKCameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) EKCameraView *cameraView;
@property (nonatomic, strong) EKAppDelegate *appDelegate;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

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
                                                                     UITextAttributeFont:[UIFont fontWithName:[EKFontsUtil fontName] size:kEKNavBarFontSize]};
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self setupLeftMenuButton];
    
    [self.cameraView.photoControl addTarget:self
                                     action:@selector(showImagePickerController)
                           forControlEvents:UIControlEventTouchUpInside];
#ifdef __i386__
	NSLog(@"No camera in simulator, sorry bro :(");
#else
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
	[self setUpImagePickerController];
#endif
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

#pragma mark - Setup imagePickerController

- (void)setUpImagePickerController
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.showsCameraControls = YES;
    self.imagePickerController.navigationBarHidden = NO;
    
        //Create camera overlay
    CGRect f = self.imagePickerController.view.bounds;
    f.size.height -= self.imagePickerController.navigationBar.bounds.size.height;
    UIGraphicsBeginImageContext(f.size);
    [[UIColor colorWithWhite:0 alpha:.5] set];
    UIRectFillUsingBlendMode(CGRectMake(0, 0, f.size.width, 124.0), kCGBlendModeNormal);
    UIRectFillUsingBlendMode(CGRectMake(0, 444, f.size.width, 52), kCGBlendModeNormal);
    UIImage *overlayImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *overlayIV = [[UIImageView alloc] initWithFrame:f];
    overlayIV.image = overlayImage;
    overlayIV.alpha = 0.7f;
    [self.imagePickerController setCameraOverlayView:overlayIV];
}

#pragma mark - Show imagePickerController

- (void)showImagePickerController
{
#ifdef __i386__
	NSLog(@"No camera in simulator, sorry bro :(");
#else
	[self presentViewController:self.imagePickerController animated:YES completion:nil];
#endif
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UIView * previewView = [[[[[[[[[[
                                     self.imagePickerController.view // UILayoutContainerView
                                     subviews] objectAtIndex:0] // UINavigationTransitionView
                                   subviews] objectAtIndex:0] // UIViewControllerWrapperView
                                 subviews] objectAtIndex:0] // UIView
                               subviews] objectAtIndex:0] // PLCameraView
                             subviews] objectAtIndex:0]; // PLPreviewView
    [previewView touchesBegan:touches withEvent:event];
}


@end
