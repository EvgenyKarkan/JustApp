//
//  EKAutofocusFrame.h
//  JustApp
//
//  Created by Evgeny Karkan on 30.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


#define ANIMATION_SCALE .7f

@interface EKFocusFrameView : UIView

- (void)moveToPoint:(CGPoint)destinationPoint whithScale:(CGFloat)scale;

@end
