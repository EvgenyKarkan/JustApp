//
//  EKConstants.h
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#ifndef JustApp_Constants_h
#define JustApp_Constants_h

#define NAV_BAR_BACKGROUND_COLOR  [UIColor colorWithRed:0.000000f green:0.443137f blue:0.615686f alpha:1.0f]
#define BACKGROUND_COLOR          [UIColor colorWithRed:0.278431f green:0.686275f blue:0.803922f alpha:1.0f]

static NSString * const kEKFont               = @"HelveticaNeue-UltraLight";
static NSString * const kEKFont2              = @"Helvetica";
static NSString * const kEKFont3              = @"HelveticaNeue-Light";

static NSString * const kEKCameraAsset        = @"Shot";
static NSString * const kEKCameraPressedAsset = @"ShotPressed";
static NSString * const kEKFaceAsset          = @"Face";

static NSString * const kEKException          = @"Deprecated method";
static NSString * const kEKExceptionReason    = @"Class instance is singleton. It's not possible to call +new method directly. Use +sharedInstance instead";

//static NSString * const kEKSavedWithSuccess   = @"Saved";
//static NSString * const kEKErrorOnSaving      = @"Error occured";
//
//static NSString * const kEKSuccessHUDIcon     = @"success";
//static NSString * const kEKErrorHUDIcon       = @"error";

static NSString * const kEKClearedWithSuccess = @"Cleared";
static NSString * const kEKErrorOnClear       = @"No data to clear";

#endif