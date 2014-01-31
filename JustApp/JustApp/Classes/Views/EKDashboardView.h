//
//  EKDashboardView.h
//  JustApp
//
//  Created by Evgeny Karkan on 31.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//



@interface EKDashboardView : UIView

@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *timeLabel;

- (void)setUpInitialStateForLabels;

@end
