//
//  EKAutofocusFrame.m
//  JustApp
//
//  Created by Evgeny Karkan on 30.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


#import "EKFocusFrameView.h"


#define FRAME_WIDTH 120
#define FRAME_HEIGHT 120
#define PATH_WIDTH  2
#define LIMB_LENGTH 12

@implementation EKFocusFrameView

- (id)init
{
	self = [super initWithFrame:CGRectMake(0, 0, FRAME_WIDTH, FRAME_HEIGHT)];
	if (self) {
		[self setBackgroundColor:[UIColor clearColor]];
		[self setUserInteractionEnabled:NO];
		[self setAlpha:0.0f];
	}
	return self;
}

- (void)animateWhithScale:(CGFloat)scale
{
	[self setAlpha:1.0f];
	self.transform = CGAffineTransformMakeScale(scale, scale);
	[UIView animateWithDuration:0.3f
	                      delay:0.0f
	                    options:UIViewAnimationOptionCurveEaseInOut
	                 animations: ^{
                         self.transform = CGAffineTransformMakeScale(ANIMATION_SCALE * scale, ANIMATION_SCALE * scale);
                     }
	                 completion: ^(BOOL finished) {
                         [self setAlpha:0.0f];
                         [self setNeedsDisplay];
                     }];
}

- (void)moveToPoint:(CGPoint)destinationPoint whithScale:(CGFloat)scale
{
    [self setCenter:destinationPoint];
    [self animateWhithScale:scale];
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
	CGContextSetLineWidth(context, PATH_WIDTH);
	CGPathRef path = CGPathCreateWithRect(CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height), nil);
    
	CGContextMoveToPoint(context, self.bounds.size.width / 2, 0);
	CGContextAddLineToPoint(context, self.bounds.size.width / 2, LIMB_LENGTH);
    
	CGContextMoveToPoint(context, self.bounds.size.width, self.bounds.size.height / 2);
	CGContextAddLineToPoint(context, self.bounds.size.width - LIMB_LENGTH, self.bounds.size.height / 2);
    
	CGContextMoveToPoint(context, self.bounds.size.width / 2, self.bounds.size.height);
	CGContextAddLineToPoint(context, self.bounds.size.width / 2, self.bounds.size.height - LIMB_LENGTH);
    
	CGContextMoveToPoint(context, 0, self.bounds.size.height / 2);
	CGContextAddLineToPoint(context, LIMB_LENGTH, self.bounds.size.height / 2);
    
    
	CGContextAddPath(context, path);
    
	CGContextStrokePath(context);
	CGPathRelease(path);
}

@end
