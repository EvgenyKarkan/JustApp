//
//  EKAutofocusFrame.m
//  JustApp
//
//  Created by Evgeny Karkan on 30.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


#import "EKFocusFrameView.h"

static CGFloat const kEKAnimationScale = 0.7f;
static CGFloat const kEKFrameSide      = 120.0f;
static CGFloat const kEKPathWidth      = 2.0f;
static CGFloat const kEKLimbLenght     = 25.0f;


@implementation EKFocusFrameView;

- (id)init
{
	self = [super initWithFrame:CGRectMake(0.0f, 0.0f, kEKFrameSide, kEKFrameSide)];
    
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
                         self.transform = CGAffineTransformMakeScale(kEKAnimationScale * scale, kEKAnimationScale * scale);
                     }
	                 completion: ^(BOOL finished) {
                         [self setAlpha:0.0f];
                         [self setNeedsDisplay];
                     }];
}

- (void)moveToPoint:(CGPoint)destinationPoint whithScale:(CGFloat)scale
{
    NSParameterAssert(!CGPointEqualToPoint(destinationPoint, CGPointZero));
    
	[self setCenter:destinationPoint];
	[self animateWhithScale:scale];
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
	CGContextSetLineWidth(context, kEKPathWidth);
	CGPathRef path = CGPathCreateWithRect(CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height), nil);
    
	CGContextMoveToPoint(context, self.bounds.size.width / 2.0f, 0.0f);
	CGContextAddLineToPoint(context, self.bounds.size.width / 2.0f, kEKLimbLenght);
    
	CGContextMoveToPoint(context, self.bounds.size.width, self.bounds.size.height / 2.0f);
	CGContextAddLineToPoint(context, self.bounds.size.width - kEKLimbLenght, self.bounds.size.height / 2.0f);
    
	CGContextMoveToPoint(context, self.bounds.size.width / 2.0f, self.bounds.size.height);
	CGContextAddLineToPoint(context, self.bounds.size.width / 2.0f, self.bounds.size.height - kEKLimbLenght);
    
	CGContextMoveToPoint(context, 0.0f, self.bounds.size.height / 2.0f);
	CGContextAddLineToPoint(context, kEKLimbLenght, self.bounds.size.height / 2.0f);
    
	CGContextAddPath(context, path);
    
	CGContextStrokePath(context);
	CGPathRelease(path);
}

@end
