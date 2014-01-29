//
//  EKCameraView.h
//  JustApp
//
//  Created by Evgeny Karkan on 29.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMediaTypeControl.h"

@interface EKCameraView : UIView

@property (nonatomic, strong) UIImageView *centerImage;
@property (nonatomic, strong) EKMediaTypeControl *photoControl;

@end
