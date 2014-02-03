//
//  EKAddressBookUtil.m
//  JustApp
//
//  Created by Evgeny Karkan on 03.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKAddressBookUtil.h"
#import "EKPerson.h"


@implementation EKAddressBookUtil;

+ (NSMutableArray *)persons
{
	NSMutableArray *result = [@[] mutableCopy];
    
	ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
	if (addressBook != nil) {
		NSArray *allPeople = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        
		if ([allPeople count] > 0) {
			for (NSUInteger i = 0; i < [allPeople count]; i++) {
				ABRecordRef person = (__bridge ABRecordRef)allPeople[i];
				NSParameterAssert(person != nil);
                
				NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
				NSString *lastName  = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
				UIImage *image      = [UIImage imageWithData:(__bridge_transfer NSData *)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail)];
                
				if (firstName == nil) {
					firstName = @"";
				}
                
				if (lastName == nil) {
					lastName = @"";
				}
                
				if (image == nil) {
					image = [UIImage imageNamed:@"FaceThumb"];
				}
                
				if (!([firstName isEqualToString:@""] && [lastName isEqualToString:@""])) {
					EKPerson *human = [[EKPerson alloc] initWithName:firstName lastName:lastName avatar:image];
					NSParameterAssert(human != nil);
					[result addObject:human];
				}
			}
			CFRelease(addressBook);
			NSParameterAssert([result count] > 0);
		}
		else {
			NSLog(@"AddressBook is empty");
			return nil;
		}
	}
	else {
		NSLog(@"No AddressBook founded");
		return nil;
	}
    
	return result;
}

+ (EKAddressBookAccessType)currentAccessType
{
	__block EKAddressBookAccessType type = EKAddressBookAccessTypeDeniedInitially;
    
	ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
	if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
		ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
		    if (granted) {
		        type = EKAddressBookAccessTypeGrantedInitially;
			}
		    else {
		        type = EKAddressBookAccessTypeDeniedInitially;
			}
		});
	}
	else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
		type = EKAddressBookAccessTypeGrantedPreviously;
	}
	else {
		type = EKAddressBookAccessTypeDeniedPreviously;
	}
    
	return type;
}

@end
