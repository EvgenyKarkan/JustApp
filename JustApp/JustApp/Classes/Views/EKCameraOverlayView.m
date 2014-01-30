//
//  EKCameraOverlayView.m
//  JustApp
//
//  Created by Evgeny Karkan on 30.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKCameraOverlayView.h"

@interface EKCameraOverlayView ()

@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIView *bottomBar;

@end


@implementation EKCameraOverlayView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.topBar = [[UIView alloc] init];
        self.topBar.backgroundColor = BACKGROUND_COLOR;
        self.topBar.alpha = 0.8f;
        [self addSubview:self.topBar];
        
        self.bottomBar = [[UIView alloc] init];
        self.bottomBar.backgroundColor = BACKGROUND_COLOR;
        self.bottomBar.alpha = 0.8f;
        [self addSubview:self.bottomBar];
        
        self.torchButton = [[DDExpandableButton alloc] initWithPoint:CGPointMake(20.0f, 18.0f)
                                                           leftTitle:[UIImage imageNamed:@"Flash"]
                                                             buttons:@[@"Auto", @"On", @"Off"]];
        [self.torchButton setVerticalPadding:6.0f];
        [self.torchButton updateDisplay];
        [self.torchButton setSelectedItem:0];
        [self.topBar addSubview:self.torchButton];
        
		self.frontBackButton = [[DDExpandableButton alloc] initWithPoint:CGPointZero
		                                                       leftTitle:nil
		                                                         buttons:@[@"Back", @"Front"]];
        [self.frontBackButton setToggleMode:YES];
        [self.frontBackButton setInnerBorderWidth:0];
		[self.frontBackButton setHorizontalPadding:6.0f];
        [self.frontBackButton updateDisplay];
		[self.topBar addSubview:self.frontBackButton];
        
		self.typeButton = [[DDExpandableButton alloc] initWithPoint:CGPointMake(20.0, 16.5f)
		                                                  leftTitle:[UIImage imageNamed:@"FrontBackCam"]
		                                                    buttons:@[@"Photo", @"Video"]];
        [self.typeButton setInnerBorderWidth:0];
        [self.typeButton setHorizontalPadding:6.0f];
        [self.typeButton setUnSelectedLabelFont:[UIFont systemFontOfSize:self.typeButton.labelFont.pointSize]];
        [self.typeButton updateDisplay];
        [self.typeButton setSelectedItem:0];
        [self.bottomBar addSubview:self.typeButton];
        
        self.cancelButton = [[DDExpandableButton alloc] initWithPoint:CGPointZero
		                                                       leftTitle:nil
		                                                         buttons:@[@"Cancel"]];
        [self.cancelButton setToggleMode:YES];
        [self.cancelButton setInnerBorderWidth:0];
		[self.cancelButton setHorizontalPadding:6.0f];
        [self.cancelButton updateDisplay];
		[self.bottomBar addSubview:self.cancelButton];
        
        self.previewButton = [[DDExpandableButton alloc] initWithPoint:CGPointZero
                                                            leftTitle:nil
                                                              buttons:@[@"View"]];
        [self.previewButton setToggleMode:YES];
        [self.previewButton setInnerBorderWidth:0];
		[self.previewButton setHorizontalPadding:6.0f];
        [self.previewButton updateDisplay];
        [self.bottomBar addSubview:self.previewButton];
        
        self.shotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shotButton setImage:[UIImage imageNamed:@"ShotOverlay"]
                         forState:UIControlStateNormal];
        [self.shotButton setImage:[UIImage imageNamed:@"ShotOverlayPressed"]
                         forState:UIControlStateHighlighted];
        [self.bottomBar addSubview:self.shotButton];
        
        self.visibleFrameView = [[UIView alloc] init];
        [self addSubview:self.visibleFrameView];
    }
    return self;
}

#pragma mark - UIView class overriden API

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat barHeight = 64.0f;
    self.topBar.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, barHeight);
    self.bottomBar.frame = CGRectMake(0.0f, self.frame.size.height - barHeight, self.frame.size.width, barHeight);
    
    self.frontBackButton.frame = CGRectMake(self.topBar.frame.size.width - 80.0f, 18.0f, 60.0f, 31.0f);
    self.cancelButton.frame = CGRectMake(self.topBar.frame.size.width - 92.0f, 18.0f, 72.0f, 31.0f);
    self.previewButton.frame = CGRectMake(self.cancelButton.frame.origin.x - 68.0f, 18.0f, 58.0f, 31.0f);
    
    CGFloat side = 60.0f;
    self.shotButton.frame = CGRectMake(self.bottomBar.frame.size.width / 2.0f - side / 2.0f, 2.0f, side, side);
    
    self.visibleFrameView.frame = CGRectMake(0.0f, barHeight, self.frame.size.width, self.frame.size.height - barHeight * 2.0f);
}

@end