//
//  EKCameraOverlayView.h
//  JustApp
//
//  Created by Evgeny Karkan on 30.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


@interface EKCameraOverlayView : UIView

@property (nonatomic, strong) DDExpandableButton *torchButton;
@property (nonatomic, strong) DDExpandableButton *frontBackButton;
@property (nonatomic, strong) DDExpandableButton *typeButton;
@property (nonatomic, strong) DDExpandableButton *cancelButton;
@property (nonatomic, strong) DDExpandableButton *previewButton;
@property (nonatomic, strong) UIButton *shotButton;
@property (nonatomic, strong) UIView *visibleFrameView;

@end
