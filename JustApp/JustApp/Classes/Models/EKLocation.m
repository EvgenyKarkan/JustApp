//
//  EKLocation.m
//  JustApp
//
//  Created by Evgeny Karkan on 31.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKLocation.h"


@implementation EKLocation;

#pragma mark - Designated initializer

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                        image:(UIImage *)pinImage
                   coordinate:(CLLocationCoordinate2D)coordinate
{
    NSParameterAssert(title != nil);
    NSParameterAssert(subTitle != nil);
    NSParameterAssert(pinImage != nil);
    NSParameterAssert(CLLocationCoordinate2DIsValid(coordinate));
    
    self = [super init];
    
    if (self) {
        self.title = title;
        self.subTitle = subTitle;
        self.imageForPin = pinImage;
        self.coordinate = coordinate;
    }
    return self;
}

@end
