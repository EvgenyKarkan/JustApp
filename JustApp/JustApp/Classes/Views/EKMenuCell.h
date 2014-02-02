//
//  EKMenuCell.h
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


@interface EKMenuCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel     *title;

- (instancetype)initWithIndexPath:(NSIndexPath *)path;

@end
