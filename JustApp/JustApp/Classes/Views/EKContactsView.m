//
//  EKContactsView.m
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKContactsView.h"


@implementation EKContactsView;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = BACKGROUND_COLOR;
        
		self.tableView = [[UITableView alloc] init];
		self.tableView.bounces = YES;
		self.tableView.backgroundColor = BACKGROUND_COLOR;
		self.tableView.separatorColor = [NAV_BAR_BACKGROUND_COLOR colorWithAlphaComponent:0.5f];
		[self addSubview:self.tableView];
        
		self.searchBar = [[UISearchBar alloc] init];
		self.searchBar.placeholder = @"Search...";
		if ([self.searchBar respondsToSelector:@selector(barTintColor)]) {
			self.searchBar.barTintColor = BACKGROUND_COLOR;
		}
		else {
			self.searchBar.tintColor = BACKGROUND_COLOR;
		}
        
		[self addSubview:self.searchBar];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.searchBar.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 44.0f);
	self.tableView.frame = CGRectMake(0.0f, 44.0f, self.frame.size.width, self.frame.size.height - 44.0f);
}

@end
