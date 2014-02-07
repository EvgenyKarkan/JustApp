//
//  EKContactsCell.m
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKContactsCell.h"
#import "EKFontsUtil.h"


static CGFloat const kEKTitleFontSize = 20.0f;


@implementation EKContactsCell;

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = BACKGROUND_COLOR;
        self.icon = [[UIImageView alloc] init];
        [self addSubview:self.icon];
        
        self.title = [[UILabel alloc] init];
        self.title.backgroundColor = BACKGROUND_COLOR;
        self.title.textColor = [UIColor whiteColor];
        self.title.font = [UIFont fontWithName:[EKFontsUtil fontName] size:kEKTitleFontSize];
        self.title.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.title];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat selfHeight = self.frame.size.height;
    self.icon.frame  = CGRectMake(selfHeight / 3.0f, selfHeight / 6.0f, selfHeight / 1.5f, selfHeight / 1.5f);
    self.title.frame = CGRectMake(65.0f, 0.0f, self.frame.size.width, 60.0f);
}

@end
