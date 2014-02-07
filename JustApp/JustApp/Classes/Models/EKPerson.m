//
//  EKPerson.m
//  JustApp
//
//  Created by Evgeny Karkan on 03.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKPerson.h"


@implementation EKPerson;

#pragma mark - Designated initializer

- (instancetype)initWithName:(NSString *)name
                    lastName:(NSString *)lastNAme
                      avatar:(UIImage *)avatar
{
    NSParameterAssert(name != nil);
    NSParameterAssert(lastNAme != nil);
    NSParameterAssert(avatar != nil);
    
	self = [super init];
    
    if (self) {
        self.firstName = name;
        self.lastName = lastNAme;
        self.avatar = avatar;
    }
    return self;
}

@end
