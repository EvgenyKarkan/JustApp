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

@property (nonatomic, strong) NSMutableArray      *lastNames;
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
    
    [self prepeareIndexedDataSourceFromData:self.data];
    
    return self;
}

#pragma mark - Prepare data

- (void)prepeareIndexedDataSourceFromData:(NSMutableArray *)datasource
{
    BOOL found = NO;
    self.sections = [[NSMutableDictionary alloc] init];
    
    for (EKPerson *person in datasource) {
        NSParameterAssert(person != nil);
        if ([person.lastName isEqualToString:@""]) {
            person.lastName = @"Skywalker";
        }
        NSString *firstLetter = [person.lastName substringToIndex:1];
        found = NO;
        
        NSArray *allKeysArray = [self.sections allKeys];
        
        for (NSString *key in allKeysArray) {
            NSParameterAssert(key != nil);
            NSParameterAssert(![key isEqualToString:@""]);
            NSParameterAssert(![key isEqualToString:@" "]);
            if ([key isEqualToString:firstLetter]) {
                found = YES;
            }
        }
        
        if (!found) {
            NSMutableArray *valueArray = [@[] mutableCopy];
            [self.sections setValue:valueArray
                             forKey:firstLetter];
        }
    }
    
    for (EKPerson *human in datasource) {
        [[self.sections objectForKey:[human.lastName substringToIndex:1]] addObject:human];
    }
    
    NSArray *allKeysArray = [self.sections allKeys];
    
    for (NSString *key in allKeysArray) {
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
        
        EKPerson *buddy = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]]         objectAtIndex:indexPath.row];
        cell.title.text = [NSString stringWithFormat:@"%@ %@", buddy.firstName, buddy.lastName];
        cell.icon.image = buddy.avatar;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kEKHeightForRow;
}

#pragma mark - Indexed stuff APIs

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
