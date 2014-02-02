//
//  EKSongCell.h
//  JustApp
//
//  Created by Evgeny Karkan on 01.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKSongCell : UITableViewCell

@property (nonatomic, strong) UILabel        *songLabel;


@property (nonatomic, strong) UIButton       *playButton;
@property (nonatomic, strong) UIButton       *pauseButton;
@property (nonatomic, strong) UIButton       *stopButton;

@end
