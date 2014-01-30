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
#import "EKImagePickerController.h"
#import "EKImageProcessingUtil.h"

@interface EKCameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) EKCameraView *cameraView;
@property (nonatomic, strong) EKAppDelegate *appDelegate;
@property (nonatomic, strong) EKImagePickerController *imagePickerController;

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
    
    self.imagePickerController = [[EKImagePickerController alloc] init];
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
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [SVProgressHUD showErrorWithStatus:@"App is running on iPod, no camera, sorry :("];
	}
	else {
		[self presentViewController:self.imagePickerController animated:YES completion:nil];
	}
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

#pragma mark - UIImagePickerControllerDelegate API

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    CGFloat squareSide = self.cameraView.centerImage.frame.size.width;
    UIImage *squareImage = [EKImageProcessingUtil squareImageWithImage:info[UIImagePickerControllerOriginalImage]
                                                          scaledToSize:CGSizeMake(squareSide, squareSide)];
    
    self.cameraView.centerImage.image = squareImage;
}

@end
