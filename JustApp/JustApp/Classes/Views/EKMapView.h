//
//  EKMapView.h
//  JustApp
//
//  Created by Evgeny Karkan on 31.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKDashboardView.h"


@interface EKMapView : UIView

@property (nonatomic, strong) MKMapView       *map;
@property (nonatomic, strong) EKDashboardView *dashboardView;

@end
