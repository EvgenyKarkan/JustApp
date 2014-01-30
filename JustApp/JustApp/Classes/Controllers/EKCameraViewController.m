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
#import "EKCameraOverlayView.h"
#import "EKFocusFrameView.h"

@interface EKCameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) EKCameraView *cameraView;
@property (nonatomic, strong) EKAppDelegate *appDelegate;
@property (nonatomic, strong) EKCameraOverlayView *overlayView;
@property (nonatomic, strong) EKFocusFrameView *focusFrame;

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
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Show imagePickerController

- (void)showImagePickerController
{
#ifdef __i386__
	NSLog(@"No camera in simulator, sorry bro :(");
#else
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.showsCameraControls = NO;
    
    self.overlayView = [[EKCameraOverlayView alloc] init];
    self.overlayView.frame = self.imagePickerController.cameraOverlayView.frame;
    self.imagePickerController.cameraOverlayView = self.overlayView;
    
    self.focusFrame = [[EKFocusFrameView alloc] init];
    [self.overlayView addSubview:self.focusFrame];
    
    UITapGestureRecognizer *tapGestureForVideoView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [tapGestureForVideoView setDelegate:self];
    [self.imagePickerController.cameraOverlayView addGestureRecognizer:tapGestureForVideoView];
    
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

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"%d %s",__LINE__, __PRETTY_FUNCTION__);
    NSParameterAssert(recognizer != nil);
    
	CGPoint gesturePoint = [recognizer locationInView:self.imagePickerController.view];
    NSLog(@"point %f", gesturePoint.x);
        NSLog(@"point %f", gesturePoint.y);
	[self.focusFrame moveToPoint:gesturePoint whithScale:1 / [self cameraViewScale]];
}

- (float)cameraViewScale
{
    return sqrtf(self.imagePickerController.cameraOverlayView.transform.a * self.imagePickerController.cameraOverlayView.transform.a +
                 self.imagePickerController.cameraOverlayView.transform.c * self.imagePickerController.cameraOverlayView.transform.c);
}

@end
