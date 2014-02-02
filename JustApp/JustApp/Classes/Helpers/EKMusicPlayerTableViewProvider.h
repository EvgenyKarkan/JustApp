//
//  EKMusicPlayerTableViewProvider.h
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

@protocol EKMusicPlayerTableViewProviderDelegate <NSObject>

- (void)playDidPressedWithTag:(NSUInteger)tag;
- (void)pauseDidPressedWithTag:(NSUInteger)tag;
- (void)stopDidPressedWithTag:(NSUInteger)tag;

@end


@interface EKMusicPlayerTableViewProvider : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <EKMusicPlayerTableViewProviderDelegate> delegate;

- (instancetype)initWithData:(NSArray *)dataSource
                    delegate:(id <EKMusicPlayerTableViewProviderDelegate>)delegate;

@end
