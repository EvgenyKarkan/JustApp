//
//  EKMenuTableViewProvider.h
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

@protocol EKMenuTableViewProviderDelegate <NSObject>

- (void)cellDidPressWithIndex:(NSUInteger)index;

@end


@interface EKMenuTableViewProvider : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <EKMenuTableViewProviderDelegate> delegate;

- (instancetype)initWithDelegate:(id <EKMenuTableViewProviderDelegate> )delegate;

@end
