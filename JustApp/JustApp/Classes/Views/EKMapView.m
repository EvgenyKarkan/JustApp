//
//  EKMapView.m
//  JustApp
//
//  Created by Evgeny Karkan on 31.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMapView.h"


@implementation EKMapView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.map = [[MKMapView alloc] init];
        self.map.showsUserLocation = YES;
        [self addSubview:self.map];
    }
    return self;
}

- (void)layoutSubviews
{
    self.map.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
}

@end
