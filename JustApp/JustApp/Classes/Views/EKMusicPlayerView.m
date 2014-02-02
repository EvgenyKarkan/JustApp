//
//  EKMusicPlayerView.m
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMusicPlayerView.h"
#import "EKLayoutUtil.h"
#import "EKFontsUtil.h"

@interface EKMusicPlayerView ()

@property (nonatomic, strong) UIImageView *soundIcon;

@end


@implementation EKMusicPlayerView;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
    
	if (self) {
		self.tableView = [[UITableView alloc] init];
		self.tableView.bounces = YES;
		self.tableView.backgroundColor = BACKGROUND_COLOR;
		self.tableView.separatorColor = [NAV_BAR_BACKGROUND_COLOR colorWithAlphaComponent:0.5f];
		[self addSubview:self.tableView];
        
		if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
			[self.tableView setSeparatorInset:UIEdgeInsetsZero];
		}
        
		self.bottomView = [[UIView alloc] init];
		self.bottomView.backgroundColor = NAV_BAR_BACKGROUND_COLOR;
		[self addSubview:self.bottomView];
        
		self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
		self.progressView.progress = 0.0f;
		self.progressView.progressTintColor = BACKGROUND_COLOR;
		[self.bottomView addSubview:self.progressView];
        
        self.soundIcon = [[UIImageView alloc] init];
        self.soundIcon.image = [UIImage imageNamed:@"SoundPlaying"];
        [self.bottomView addSubview:self.soundIcon];
        
        self.songLabel = [[UILabel alloc] init];
        self.songLabel.backgroundColor = [UIColor clearColor];
        self.songLabel.textColor = [UIColor whiteColor];
        self.songLabel.textAlignment = NSTextAlignmentLeft;
		self.songLabel.font = [UIFont fontWithName:[EKFontsUtil fontName]
                                              size:[EKFontsUtil fontSizeForMusicLabel]];
        [self.bottomView addSubview:self.songLabel];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
    CGFloat height = 44.0f;
	self.tableView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height - height);
    self.bottomView.frame = CGRectMake(0.0f, self.frame.size.height - height, self.frame.size.width, height);
    self.progressView.frame = CGRectMake(20.0f, 25.0f, self.frame.size.width - 40.0f, 10.0f);
    self.soundIcon.frame = CGRectMake(20.0f, 5.0f, height / 3.0f, height / 3.0f);
    self.songLabel.frame = CGRectMake(50.0f, 0.0f, self.frame.size.width - 70.0f, 25.0f);
}

@end
