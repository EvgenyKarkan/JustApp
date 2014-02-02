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
static CGFloat    const kEKHeightForRow    = 92.0f;

@interface EKMusicPlayerTableViewProvider () 

@property (nonatomic, copy) NSArray *data;

@end


@implementation EKMusicPlayerTableViewProvider;

#pragma mark - Designated initializer

- (instancetype)initWithData:(NSArray *)dataSource delegate:(id <EKMusicPlayerTableViewProviderDelegate>)delegate
{
    NSParameterAssert(dataSource != nil);
    NSParameterAssert([dataSource count] > 0);
    
	self = [super init];
	if (self) {
		self.data = dataSource;
        self.delegate = delegate;
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
        
		cell.playButton.tag = indexPath.row;
		cell.pauseButton.tag = indexPath.row;
		cell.stopButton.tag = indexPath.row;
        
		[cell.playButton addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[cell.pauseButton addTarget:self action:@selector(pauseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[cell.stopButton addTarget:self action:@selector(stopButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	}
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kEKHeightForRow;
}

#pragma mark - Cell buttons actions

- (void)playButtonPressed:(UIButton *)sender
{
	[self.delegate playDidPressedWithTag:sender.tag];
}

- (void)pauseButtonPressed:(UIButton *)sender
{
	[self.delegate pauseDidPressedWithTag:sender.tag];
}

- (void)stopButtonPressed:(UIButton *)sender
{
	[self.delegate stopDidPressedWithTag:sender.tag];
}

@end
