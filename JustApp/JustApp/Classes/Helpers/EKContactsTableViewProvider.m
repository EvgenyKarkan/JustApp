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

@property (nonatomic, strong) NSMutableArray *lastNames;
@property (nonatomic, strong) NSMutableDictionary *sections;

@end


@implementation EKContactsTableViewProvider;

#pragma mark - Designated initializer

- (instancetype)initWithData:(NSMutableArray *)dataSource
{
	NSParameterAssert(dataSource != nil);
	NSParameterAssert([dataSource count] > 0);
    
	self = [super init];
	if (self) {
		self.data = dataSource;
		self.searchData = [@[] mutableCopy];
	}
	[self prepareData];
    
	return self;
}

#pragma mark - Prepare data

- (void)prepareData
{
	BOOL found = NO;
	self.sections = [[NSMutableDictionary alloc] init];
    
	for (EKPerson *person in self.data) {
		if ([person.lastName isEqualToString:@""]) {
			person.lastName = @"Skywalker";
		}
		NSString *firstLetter = [person.lastName substringToIndex:1];
		found = NO;
        
		for (NSString *str in[self.sections allKeys]) {
			if ([str isEqualToString:firstLetter]) {
				found = YES;
			}
		}
        
		if (!found) {
			NSMutableArray *valueArray = [@[] mutableCopy];
            
			[self.sections setValue:valueArray
			                 forKey:firstLetter];
		}
	}
    
	for (EKPerson *human in self.data) {
		[[self.sections objectForKey:[human.lastName substringToIndex:1]] addObject:human];
	}
    
	for (NSString *key in[self.sections allKeys]) {
		[[self.sections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES]]];
	}
}

#pragma mark - Tableview delegate & datasourse APIs

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	EKContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:kSUReuseIdentifier];
	if (cell == nil) {
		cell = [[EKContactsCell alloc] init];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
		if (!self.searching) {
			EKPerson *book = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
			cell.title.text = [NSString stringWithFormat:@"%@ %@", book.firstName, book.lastName];
			cell.icon.image = book.avatar;
		}
        
            //TODO: finish live search
        
            //		else {
            //                NSLog(@"Section %d", indexPath.section);
            //                NSLog(@"Path %d", indexPath.row);
            //
            //			if (indexPath.section < [self.searchData count]) {
            //				if (indexPath.row <= indexPath.section) {
            //                    //EKPerson *homoSapiens = self.searchData[indexPath.row];
            //
            //					EKPerson *homoSapiens = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]                 objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
            //
            //					NSParameterAssert(homoSapiens != nil);
            //					cell.title.text = [NSString stringWithFormat:@"%@ %@", homoSapiens.firstName, homoSapiens.lastName];
            //					cell.icon.image = homoSapiens.avatar;
            //				}
            //			}
            //		}
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kEKHeightForRow;
}

#pragma mark - Indexed stuff

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[self.sections allKeys] count];
}

@end
