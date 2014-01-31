//
//  EKLocation.h
//  JustApp
//
//  Created by Evgeny Karkan on 31.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


@interface EKLocation : NSObject <MKAnnotation>

@property (nonatomic, copy)   NSString               *title;
@property (nonatomic, copy)   NSString               *subtitle;
@property (nonatomic, strong) UIImage                *imageForPin;
@property (nonatomic, assign) CLLocationCoordinate2D  coordinate;

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                        image:(UIImage *)pinImage
                   coordinate:(CLLocationCoordinate2D)coordinate;

@end
