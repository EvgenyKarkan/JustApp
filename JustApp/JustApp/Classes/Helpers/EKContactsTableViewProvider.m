//
//  EKContactsTableViewProvider.m
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKContactsTableViewProvider.h"
#import "EKContactsCell.h"
#import "EKPerson.h"

static NSString * const kSUReuseIdentifier = @"defaultCell";
static CGFloat    const kEKHeightForRow    = 52.0f;

@interface EKContactsTableViewProvider ()

@property (nonatomic, copy) NSArray *data;

@end


@implementation EKContactsTableViewProvider;

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
	EKContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:kSUReuseIdentifier];
	if (cell == nil) {
		cell = [[EKContactsCell alloc] init];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        EKPerson *homoSapiens = self.data[indexPath.row];
        cell.title.text = [NSString stringWithFormat:@"%@ %@", homoSapiens.firstName, homoSapiens.lastName];
        cell.icon.image = homoSapiens.avatar;
    }
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kEKHeightForRow;
}

@end
