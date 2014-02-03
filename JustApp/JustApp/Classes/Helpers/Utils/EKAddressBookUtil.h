//
//  EKAddressBookUtil.h
//  JustApp
//
//  Created by Evgeny Karkan on 03.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

typedef NS_ENUM (NSInteger, EKAddressBookAccessType) {
	EKAddressBookAccessTypeDeniedInitially   = 0,
	EKAddressBookAccessTypeGrantedInitially  = 1,
	EKAddressBookAccessTypeDeniedPreviously  = 3,
	EKAddressBookAccessTypeGrantedPreviously = 4
};

@interface EKAddressBookUtil : NSObject

+ (NSMutableArray *)persons;
+ (EKAddressBookAccessType)currentAccessType;

@end
