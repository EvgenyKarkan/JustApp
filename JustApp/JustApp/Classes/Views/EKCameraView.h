//
//  EKCameraView.h
//  JustApp
//
//  Created by Evgeny Karkan on 29.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKCameraControl.h"

@interface EKCameraView : UIView

@property (nonatomic, strong) UIImageView     *centerImage;
@property (nonatomic, strong) EKCameraControl *photoControl;

@end
