//
//  EKLayoutUtil.m
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKLayoutUtil.h"


@implementation EKLayoutUtil;

+ (CGFloat)tableViewHeight
{
	CGFloat result = 0.0f;
    
	if ([self isSystemVersionLessThan7]) {
		result = 360.0f;
	}
	else {
		result = 424.f;
	}
    
	return result;
}

+ (BOOL)isSystemVersionLessThan7
{
	return ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending);
}

+ (CGFloat)verticalOffset
{
    CGFloat result = 0.0f;
    
    if ([self isSystemVersionLessThan7]) {
        result = 0.0f;
    }
    else {
        result = 64.0f;
    }
    
    return result;
}

#pragma mark - Private API

+ (BOOL)isIPhone5
{
	return (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568.0f) < DBL_EPSILON);
}

+ (BOOL)isIPad
{
	BOOL result = NO;
    
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		result = YES;
	}
	else {
		result = NO;
	}
    
	return result;
}

@end
