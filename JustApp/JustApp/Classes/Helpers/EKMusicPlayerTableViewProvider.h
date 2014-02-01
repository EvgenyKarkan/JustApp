//
//  EKMusicPlayerTableViewProvider.h
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


@interface EKMusicPlayerTableViewProvider : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithData:(NSArray *)dataSource;

@end
