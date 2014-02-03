//
//  EKDashboardView.m
//  JustApp
//
//  Created by Evgeny Karkan on 31.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKDashboardView.h"
#import "EKFontsUtil.h"


@interface EKDashboardView ()

@property (nonatomic, strong) UIImageView *speedIcon;
@property (nonatomic, strong) UIImageView *distanceIcon;
@property (nonatomic, strong) UIImageView *timeIcon;

@end


@implementation EKDashboardView;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
    
	if (self) {
		self.backgroundColor = BACKGROUND_COLOR;
        self.layer.borderColor = NAV_BAR_BACKGROUND_COLOR.CGColor;
		self.layer.borderWidth = 2.0f;

		self.speedIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Speed"]];
		[self addSubview:self.speedIcon];
        
		self.distanceIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Distance"]];
		[self addSubview:self.distanceIcon];
        
		self.timeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Time"]];
		[self addSubview:self.timeIcon];
        
		self.speedLabel = [[UILabel alloc] init];
		self.speedLabel.textColor = [UIColor whiteColor];
        
        self.speedLabel.font = [UIFont fontWithName:[EKFontsUtil fontName] size:[EKFontsUtil fontSizeForLabel]];
		self.speedLabel.backgroundColor = [UIColor clearColor];
		self.speedLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:self.speedLabel];
        
		self.distanceLabel = [[UILabel alloc] init];
		self.distanceLabel.textColor = [UIColor whiteColor];
        
        self.distanceLabel.font = [UIFont fontWithName:[EKFontsUtil fontName] size:[EKFontsUtil fontSizeForLabel]];
		self.distanceLabel.backgroundColor = [UIColor clearColor];
		self.distanceLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:self.distanceLabel];
        
		self.timeLabel = [[UILabel alloc] init];
		self.timeLabel.textColor = [UIColor whiteColor];
        
        self.timeLabel.font = [UIFont fontWithName:[EKFontsUtil fontName] size:[EKFontsUtil fontSizeForLabel]];
		self.timeLabel.backgroundColor = [UIColor clearColor];
		self.timeLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:self.timeLabel];
        
        [self setUpInitialStateForLabels];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
    CGFloat iconSide         = self.frame.size.height / 3.0f;
    CGFloat halfSide         = iconSide / 2.0f;
    
    self.speedIcon.frame     = CGRectMake(halfSide / 2.0f, halfSide / 2.0f, halfSide, halfSide);
    self.distanceIcon.frame  = CGRectMake(halfSide / 2.0f, iconSide + halfSide / 2.0f, halfSide, halfSide);
    self.timeIcon.frame      = CGRectMake(halfSide / 2.0f, (iconSide * 2.0f) + halfSide / 2.f, halfSide, halfSide);

    self.speedLabel.frame    = CGRectMake(halfSide, 0.0f, self.frame.size.width - halfSide, iconSide);
    self.distanceLabel.frame = CGRectMake(halfSide, iconSide, self.frame.size.width - halfSide, iconSide);
    self.timeLabel.frame     = CGRectMake(halfSide, iconSide * 2.0f, self.frame.size.width - halfSide, iconSide);
}

- (void)setUpInitialStateForLabels
{
    self.speedLabel.text    = @"0 mph";
    self.distanceLabel.text = @"0 km";
    self.timeLabel.text     = @"00:00:00";
}

@end
