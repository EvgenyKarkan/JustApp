//
//  EKMusicPlayerView.m
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMusicPlayerView.h"
#import "EKLayoutUtil.h"


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
		self.progressView.hidden = NO;
		self.progressView.progressTintColor = BACKGROUND_COLOR;
		[self.bottomView addSubview:self.progressView];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
    CGFloat height = 44.0f;
    
	self.tableView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height - height);
    self.bottomView.frame = CGRectMake(0.0f, self.frame.size.height - height, self.frame.size.width, height);
    
    self.progressView.frame = CGRectMake(20.0f, 30.0f, self.frame.size.width - 40.0f, 10.0f);
}

@end
