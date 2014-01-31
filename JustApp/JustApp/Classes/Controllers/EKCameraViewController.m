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
@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;

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
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self setupLeftMenuButton];
    
    [self.cameraView.photoControl addTarget:self
                                     action:@selector(showImagePickerController)
                           forControlEvents:UIControlEventTouchUpInside];
    
    self.imagePickerController = [[EKImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
}

#pragma mark - Show imagePickerController

- (void)showImagePickerController
{
#ifdef __i386__
	NSLog(@"No camera in simulator, sorry bro :(");
#else
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[SVProgressHUD showErrorWithStatus:NSLocalizedString(@"NO_CAMERA", @"No camera on your device, sorry :(")];
	}
	else {
		__weak typeof(EKCameraViewController) * weakSelf = self;
        
		[self presentViewController:self.imagePickerController animated:YES completion: ^{
		    if (weakSelf.moviePlayerController != nil) {
		        [weakSelf.moviePlayerController.view removeFromSuperview];
			}
		}];
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
	NSString *mediaType = info[UIImagePickerControllerMediaType];
    
	if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
		CGFloat squareSide = self.cameraView.centerImage.frame.size.width;
		UIImage *squareImage = [EKImageProcessingUtil squareImageWithImage:info[UIImagePickerControllerOriginalImage]
		                                                      scaledToSize:CGSizeMake(squareSide, squareSide)];
		self.cameraView.centerImage.image = squareImage;
	}
	else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self setUpMediaPlayerWithURL:info[UIImagePickerControllerMediaURL]];
	}
}

#pragma mark - Media player stuff

- (void)setUpMediaPlayerWithURL:(NSURL *)videoURL
{
    NSParameterAssert(videoURL != nil);
    
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    self.moviePlayerController.view.frame = self.cameraView.centerImage.frame;
    [self.cameraView addSubview:self.moviePlayerController.view];
    [self.moviePlayerController play];
}

@end
