//
//  EKMenuView.m
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMenuView.h"
#import "EKLayoutUtil.h"


@implementation EKMenuView;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
    
	if (self) {
		self.tableView = [[UITableView alloc] init];
		self.tableView.bounces = NO;
		self.tableView.backgroundColor = BACKGROUND_COLOR;
		self.tableView.separatorColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3f];
		[self addSubview:self.tableView];
        
		if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
			[self.tableView setSeparatorInset:UIEdgeInsetsZero];
		}
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.tableView.frame = CGRectMake(0.0f, 0.0f, 245.0f, [EKLayoutUtil tableViewHeight]);
}

@end
