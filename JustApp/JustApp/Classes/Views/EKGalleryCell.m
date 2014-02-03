//
//  EKCell.m
//  JustApp
//
//  Created by Evgeny Karkan on 03.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKGalleryCell.h"


@implementation EKGalleryCell;

//Just override inherited API

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	CGFloat selfHeight = self.frame.size.height;
    
	self.icon.frame  = CGRectMake(selfHeight / 5.0f, 0.0f, selfHeight, selfHeight);
	self.title.frame = CGRectMake(selfHeight * 1.25, self.frame.size.height / 2.0f - self.frame.size.height / 4.0f, self.frame.size.width, 60.0f);
}

@end
