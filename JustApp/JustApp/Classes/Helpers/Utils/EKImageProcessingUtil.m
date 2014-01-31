//
//  EKImageProcessingUtil.m
//  JustApp
//
//  Created by Evgeny Karkan on 30.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKImageProcessingUtil.h"


@implementation EKImageProcessingUtil;

#pragma mark - Square cropping helper

+ (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    NSParameterAssert(image != nil);
    NSParameterAssert(!CGSizeEqualToSize(newSize, CGSizeZero));

	double ratio = 0.0f;
	double delta = 0.0f;
	CGPoint offset = CGPointZero;
    
	CGSize size = CGSizeMake(newSize.width, newSize.width);
    
	if (image.size.width > image.size.height) {
		ratio = newSize.width / image.size.width;
		delta = (ratio * image.size.width - ratio * image.size.height);
		offset = CGPointMake(delta / 2, 0);
	}
	else {
		ratio = newSize.width / image.size.height;
		delta = (ratio * image.size.height - ratio * image.size.width);
		offset = CGPointMake(0, delta / 2);
	}
    
	CGRect clipRect = CGRectMake(-offset.x, -offset.y,
	                             (ratio * image.size.width) + delta,
	                             (ratio * image.size.height) + delta);
    
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
	}
	else {
		UIGraphicsBeginImageContext(size);
	}
    
	UIRectClip(clipRect);
	[image drawInRect:clipRect];
    
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return newImage;
}

@end
