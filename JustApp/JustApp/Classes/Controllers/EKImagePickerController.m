//
//  EKImagePickerViewController.m
//  JustApp
//
//  Created by Evgeny Karkan on 30.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKImagePickerController.h"
#import "EKCameraOverlayView.h"
#import "EKFocusFrameView.h"

@interface EKImagePickerController ()

@property (nonatomic, strong) EKCameraOverlayView *overlayView;
@property (nonatomic, strong) EKFocusFrameView    *focusFrame;
@property (nonatomic, assign) BOOL                 isVideoCapturing;

@end


@implementation EKImagePickerController;

#pragma mark - Life cycle

- (void)viewDidLoad
{
	self.sourceType = UIImagePickerControllerSourceTypeCamera;
	self.modalPresentationStyle = UIModalPresentationCurrentContext;
	self.showsCameraControls = NO;
	self.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
	self.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
    
	self.overlayView = [[EKCameraOverlayView alloc] initWithFrame:self.view.frame];
	self.overlayView.frame = self.cameraOverlayView.frame;
	self.cameraOverlayView = self.overlayView;
    
	self.focusFrame = [[EKFocusFrameView alloc] init];
	[self.overlayView addSubview:self.focusFrame];
    
	[self addActionsToButtonsOnOverlay];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    
	self.overlayView.torchButton.selectedItem = 0;
	self.overlayView.typeButton.selectedItem = 0;
	self.overlayView.frontBackButton.selectedItem = 0;
}

#pragma mark - UIResponder's overriden API

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint point = [[touches allObjects][0] locationInView:self.view];
	CGFloat barHeight = self.overlayView.barHeight;
    
	if (point.y > barHeight && point.y < self.view.frame.size.height - barHeight) {
		[self.focusFrame moveToPoint:point whithScale:1.0f / [self cameraViewScale]];
	}
}

#pragma mark - Focus frame helper

- (CGFloat)cameraViewScale
{
	return sqrtf(self.cameraOverlayView.transform.a * self.cameraOverlayView.transform.a +
	             self.cameraOverlayView.transform.c * self.cameraOverlayView.transform.c);
}

#pragma mark - Actions

- (void)addActionsToButtonsOnOverlay
{
	[self.overlayView.torchButton addTarget:self
	                                 action:@selector(toggleFlashlight:)
	                       forControlEvents:UIControlEventValueChanged | UIControlEventTouchUpInside];
    
	[self.overlayView.frontBackButton addTarget:self
	                                     action:@selector(toggleCameras:)
	                           forControlEvents:UIControlEventValueChanged];
    
	[self.overlayView.typeButton addTarget:self
	                                action:@selector(toggleMediaType:)
	                      forControlEvents:UIControlEventValueChanged];
    
	[self.overlayView.cancelButton addTarget:self
	                                  action:@selector(cancelPressed:)
	                        forControlEvents:UIControlEventTouchUpInside];
    
	[self.overlayView.shotButton addTarget:self
	                                action:@selector(takePictureOrVideo:)
	                      forControlEvents:UIControlEventTouchUpInside];
}

- (void)toggleFlashlight:(DDExpandableButton *)sender
{
	NSParameterAssert(sender != nil);
    
	if (![UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear]) {
		[SVProgressHUD showErrorWithStatus:NSLocalizedString(@"NO_FLASH", @"")];
		return;
	}
    
	switch (sender.selectedItem) {
		case 0:
			self.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
			break;
            
		case 1:
			self.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
			break;
            
		case 2:
			self.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
			break;
            
		default:
			break;
	}
}

- (void)toggleCameras:(DDExpandableButton *)sender
{
	NSParameterAssert(sender != nil);
    
	switch (sender.selectedItem) {
		case 0:
			self.cameraDevice = UIImagePickerControllerCameraDeviceRear;
			break;
            
		case 1:
			if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
				[SVProgressHUD showErrorWithStatus:NSLocalizedString(@"NO_FRONT_CAMERA", @"")];
			}
			else {
				self.cameraDevice = UIImagePickerControllerCameraDeviceFront;
			}
			break;
            
		default:
			break;
	}
}

- (void)toggleMediaType:(DDExpandableButton *)sender
{
	NSParameterAssert(sender != nil);
    
	switch (sender.selectedItem) {
		case 0:
			self.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
			break;
            
		case 1:
			self.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
			break;
            
		default:
			break;
	}
}

- (void)takePictureOrVideo:(id)sender
{
	NSParameterAssert(sender != nil);
    
	if (self.cameraCaptureMode == UIImagePickerControllerCameraCaptureModePhoto) {
		[self takePicture];
	}
	else {
		self.isVideoCapturing = !self.isVideoCapturing;
		[self startVideoCapture];
        
		if (!self.isVideoCapturing) {
			[self stopVideoCapture];
		}
	}
}

- (void)cancelPressed:(DDExpandableButton *)sender
{
	NSParameterAssert(sender != nil);
    
	if (!self.isVideoCapturing) {
		[self stopVideoCapture];
	}
    
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - "isVideoCapture" setter

- (void)setIsVideoCapturing:(BOOL)isVideoCapturing
{
	_isVideoCapturing = isVideoCapturing;
    
	if (_isVideoCapturing) {
		self.overlayView.videoIndicator.backgroundColor = [UIColor redColor];
		self.overlayView.torchButton.userInteractionEnabled = NO;
		self.overlayView.frontBackButton.userInteractionEnabled = NO;
		self.overlayView.typeButton.userInteractionEnabled = NO;
		self.overlayView.cancelButton.userInteractionEnabled = NO;
	}
	else {
		self.overlayView.videoIndicator.backgroundColor = [UIColor clearColor];
		self.overlayView.torchButton.userInteractionEnabled = YES;
		self.overlayView.frontBackButton.userInteractionEnabled = YES;
		self.overlayView.typeButton.userInteractionEnabled = YES;
		self.overlayView.cancelButton.userInteractionEnabled = YES;
	}
}

@end
