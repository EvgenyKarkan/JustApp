//
//  EKMusicPlayerTableViewProvider.m
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMusicPlayerTableViewProvider.h"
#import "EKSongCell.h"

static NSString * const kSUReuseIdentifier = @"defaultCell";
static CGFloat    const kEKHeightForRow    = 100.0f;

@interface EKMusicPlayerTableViewProvider () 

@property (nonatomic, copy) NSArray *data;

@end


@implementation EKMusicPlayerTableViewProvider;

#pragma mark - Designated initializer

- (instancetype)initWithData:(NSArray *)dataSource
{
    NSParameterAssert(dataSource != nil);
    NSParameterAssert([dataSource count] > 0);
    
	self = [super init];
	if (self) {
		self.data = dataSource;
	}
    
	return self;
}

#pragma mark - Tableview delegate & datasourse APIs

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
	return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	EKSongCell *cell = [tableView dequeueReusableCellWithIdentifier:kSUReuseIdentifier];
	if (cell == nil) {
        cell = [[EKSongCell alloc] init];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.songLabel.text = [self.data[indexPath.row] allKeys][0];
	}
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kEKHeightForRow;
}

@end
