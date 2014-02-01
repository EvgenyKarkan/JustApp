//
//  EKMenuTableViewProvider.m
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMenuTableViewProvider.h"
#import "EKMenuCell.h"

static NSString * const kSUReuseIdentifier = @"defaultCell";
static NSInteger  const kEKRowsNumber      = 6;
static CGFloat    const kEKHeightForRow    = 60.0f;


@implementation EKMenuTableViewProvider;

#pragma mark - Designated initializer

- (instancetype)initWithDelegate:(id <EKMenuTableViewProviderDelegate> )delegate
{
    NSParameterAssert(delegate != nil);
    
	self = [super init];
	if (self) {
		self.delegate = delegate;
	}
    
	return self;
}

#pragma mark - Tableview delegate & datasourse APIs

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return kEKRowsNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSUReuseIdentifier];
	if (cell == nil) {
        cell = [[EKMenuCell alloc] initWithIndexPath:indexPath];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kEKHeightForRow;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.delegate cellDidPressWithIndex:indexPath.row];
}

@end
