//
//  EKCameraView.m
//  JustApp
//
//  Created by Evgeny Karkan on 29.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKCameraView.h"
#import "EKLayoutUtil.h"
#import "EKFontsUtil.h"

@interface EKCameraView ()

@property (nonatomic, strong) UILabel *helloLabel;

@end


@implementation EKCameraView;

#pragma mark - Initializer

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
    
	if (self) {
		self.photoControl = [[EKCameraControl alloc] initWithImage:[UIImage imageNamed:kEKCameraAsset]];
		[self addSubview:self.photoControl];
        
		self.centerImage = [[UIImageView alloc] init];
		self.centerImage.image = [UIImage imageNamed:kEKFaceAsset];
		self.centerImage.layer.borderColor = NAV_BAR_BACKGROUND_COLOR.CGColor;
		self.centerImage.layer.borderWidth = 5.0f;
		[self addSubview:self.centerImage];
        
		self.helloLabel = [[UILabel alloc] init];
		self.helloLabel.backgroundColor = [UIColor clearColor];
		self.helloLabel.textAlignment = NSTextAlignmentCenter;
		self.helloLabel.font = [UIFont fontWithName:[EKFontsUtil fontName]
                                               size:[EKFontsUtil fontSizeForLabel]];
		self.helloLabel.text = NSLocalizedString(@"HELLO_TEXT", @"");
		self.helloLabel.textColor = NAV_BAR_BACKGROUND_COLOR;
		[self addSubview:self.helloLabel];
	}
	return self;
}

#pragma mark - UIView class overriden API

- (void)layoutSubviews
{
	[super layoutSubviews];
    
    CGFloat imageSide       = self.frame.size.width / 1.25f;
    CGFloat halfSelfWidth   = self.frame.size.width / 2.0f;
    self.centerImage.frame  = CGRectMake(halfSelfWidth - imageSide / 2.0f, self.frame.origin.y + imageSide / 6.0f + [EKLayoutUtil verticalOffset], imageSide, imageSide);

    CGFloat controlSide     = 50.0f;
    self.photoControl.frame = CGRectMake(halfSelfWidth - controlSide / 2.0f, self.frame.size.height - controlSide * 1.5f, controlSide, controlSide);
    self.helloLabel.frame   = CGRectMake(0.0f, self.centerImage.frame.origin.y + imageSide, self.frame.size.width, 60.0f);
}

@end
