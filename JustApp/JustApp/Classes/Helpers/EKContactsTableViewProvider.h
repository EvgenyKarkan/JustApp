//
//  EKContactsTableViewProvider.h
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


@interface EKContactsTableViewProvider : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithData:(NSMutableArray *)dataSource;

@property (nonatomic, assign) BOOL searching;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *searchData;

@end
