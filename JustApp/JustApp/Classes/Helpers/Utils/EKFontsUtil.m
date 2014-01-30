//
//  EKFontsUtil.m
//  JustApp
//
//  Created by Evgeny Karkan on 29.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKFontsUtil.h"
#import "EKLayoutUtil.h"

static NSString * const kEKFont     = @"Helvetica";
static NSString * const kEKFont2    = @"HelveticaNeue-Light";


@implementation EKFontsUtil;

+ (NSString *)fontName
{
	NSString *fontName = nil;
    
	if ([EKLayoutUtil isSystemVersionLessThan7]) {
		fontName = kEKFont;
	}
	else {
		fontName = kEKFont2;
	}
    
	return fontName;
}

+ (CGFloat)fontSizeForLabel
{
	CGFloat result = 0.0f;
    
	if ([EKLayoutUtil isIPad]) {
		result = 40.0f;
	}
	else {
		result = 20.0f;
	}
    
	return result;
}

@end
