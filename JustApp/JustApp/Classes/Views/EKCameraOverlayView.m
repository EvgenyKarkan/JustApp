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
        [self addSubview:self.topBar];
        
        self.bottomBar = [[UIView alloc] init];
        self.bottomBar.backgroundColor = BACKGROUND_COLOR;
        [self addSubview:self.bottomBar];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat barHeight = 64.0f;
    
    self.topBar.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, barHeight);
    self.bottomBar.frame = CGRectMake(0.0f, self.frame.size.height - barHeight, self.frame.size.width, barHeight);
}

@end
