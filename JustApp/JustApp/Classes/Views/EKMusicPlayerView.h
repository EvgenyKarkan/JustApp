//
//  EKMusicPlayerView.h
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


@interface EKMusicPlayerView : UIView

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) UIView         *bottomView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel        *songLabel;


@end
