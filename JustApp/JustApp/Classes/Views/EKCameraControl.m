//
//  EKMediaTypeControl.m
//  JustApp
//
//  Created by Evgeny Karkan on 29.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKCameraControl.h"

@interface EKCameraControl ()

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation EKCameraControl;

#pragma mark - Designated initializer

- (instancetype)initWithImage:(UIImage *)givenImage
{
    NSParameterAssert(givenImage != nil);
    
	self = [super init];
    
	if (self) {
		self.imageView = [[UIImageView alloc] init];
		self.imageView.image = givenImage;
		[self addSubview:self.imageView];
	}
	return self;
}

#pragma mark - UIView class overriden API

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	CGFloat width = self.frame.size.width;
	CGFloat height = self.frame.size.height;
	self.imageView.frame = CGRectMake(0.0f, 0.0f, width, height);
}

#pragma mark - UIControl overriden APIs

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	self.imageView.image = [UIImage imageNamed:kEKCameraPressedAsset];
    
	return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	self.imageView.image = [UIImage imageNamed:kEKCameraAsset];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
	self.imageView.image = [UIImage imageNamed:kEKCameraAsset];
}

@end
