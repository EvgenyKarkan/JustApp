//
//  EKMenuCell.m
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMenuCell.h"
#import "EKFontsUtil.h"


static NSString * const kEKCameraIcon       = @"Camera menu icon";
static NSString * const kEKCameraTitle      = @"Camera";

static NSString * const kEKMapIcon          = @"Map menu icon";
static NSString * const kEKMapTitle         = @"Map";

static NSString * const kEKMusicIcon        = @"Music menu icon";
static NSString * const kEKMusicTitle       = @"Music player";

static NSString * const kEKContactsIcon     = @"Contacts menu icon";
static NSString * const kEKContactsTitle    = @"Contacts";

static NSString * const kEKPhotoGalleryIcon = @"Photo gallery menu icon";
static NSString * const kEKPhotoGalleyTitle = @"Photo gallery";

static NSString * const kEKSettingsIcon     = @"Settings menu icon";
static NSString * const kEKSettingsTitle    = @"Settings";

static CGFloat    const kEKTitleFontSize    = 20.0f;


@implementation EKMenuCell;

#pragma mark - Designated initializer

- (instancetype)initWithIndexPath:(NSIndexPath *)path
{
    NSParameterAssert(path != nil);
    
	self = [super init];
    
	if (self) {
        self.backgroundColor = BACKGROUND_COLOR;
		self.icon = [[UIImageView alloc] init];
		[self addSubview:self.icon];
        
		self.title = [[UILabel alloc] init];
        self.title.backgroundColor = BACKGROUND_COLOR;
        self.title.textColor = [UIColor whiteColor];
		self.title.font = [UIFont fontWithName:[EKFontsUtil fontName] size:kEKTitleFontSize];
		self.title.textAlignment = NSTextAlignmentLeft;
		[self addSubview:self.title];
        
        [self setUpSelfForRow:path.row];
	}
	return self;
}

#pragma mark - UIView class overriden API

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.icon.frame  = CGRectMake(30.0f, 20.0f, 20.0f, 20.0f);
	self.title.frame = CGRectMake(65.0f, 0.0f, self.frame.size.width, 60.0f);
}

#pragma mark - Private API

- (void)setUpSelfForRow:(NSUInteger)row
{
	NSParameterAssert(row >= 0);
    
	switch (row) {
		case 0:
			self.icon.image = [UIImage imageNamed:kEKCameraIcon];
			self.title.text = kEKCameraTitle;
			break;
            
		case 1:
			self.icon.image = [UIImage imageNamed:kEKMapIcon];
			self.title.text = kEKMapTitle;
			break;
            
		case 2:
			self.icon.image = [UIImage imageNamed:kEKMusicIcon];
			self.title.text = kEKMusicTitle;
			break;
            
		case 3:
			self.icon.image = [UIImage imageNamed:kEKContactsIcon];
			self.title.text = kEKContactsTitle;
			break;
            
		case 4:
			self.icon.image = [UIImage imageNamed:kEKPhotoGalleryIcon];
			self.title.text = kEKPhotoGalleyTitle;
			break;
            
		case 5:
			self.icon.image = [UIImage imageNamed:kEKSettingsIcon];
			self.title.text = kEKSettingsTitle;
			break;
            
		default:
			break;
	}
}

#pragma mark - "selected" property setter

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected) {
        self.title.textColor = NAV_BAR_BACKGROUND_COLOR;
    }
    else {
        self.title.textColor = [UIColor whiteColor];
    }
}

@end
