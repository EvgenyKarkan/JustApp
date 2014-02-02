//
//  EKSongCell.m
//  JustApp
//
//  Created by Evgeny Karkan on 01.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKSongCell.h"
#import "EKFontsUtil.h"

@interface EKSongCell ()

@property (nonatomic, strong) UIImageView *mp3Icon;

@end

@implementation EKSongCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BACKGROUND_COLOR;
        
        self.songLabel = [[UILabel alloc] init];
        self.songLabel.backgroundColor = [UIColor clearColor];
        self.songLabel.textColor = [UIColor whiteColor];
        self.songLabel.textAlignment = NSTextAlignmentLeft;
		self.songLabel.font = [UIFont fontWithName:[EKFontsUtil fontName]
                                               size:[EKFontsUtil fontSizeForLabel]];
        [self addSubview:self.songLabel];
        
        self.mp3Icon = [[UIImageView alloc] init];
        self.mp3Icon.image = [UIImage imageNamed:@"MP3"];
        [self addSubview:self.mp3Icon];
                
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.playButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
        [self addSubview:self.playButton];
        
        self.pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.pauseButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
        [self addSubview:self.pauseButton];
        
        self.stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.stopButton setImage:[UIImage imageNamed:@"Stop"] forState:UIControlStateNormal];
        [self addSubview:self.stopButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.songLabel.frame = CGRectMake(65.0f, 10.0f, self.frame.size.width - 20.0f, self.frame.size.height / 3.0f);
    self.mp3Icon.frame = CGRectMake(30.0f, 12.0f, 25.0f, 25.0f);
        // self.progressView.frame = CGRectMake(10.0f, self.frame.size.height / 2.0f, self.frame.size.width - 20.0f, 10.0f);
    
    CGFloat buttonSide = 35.0f;
	self.playButton.frame = CGRectMake(self.center.x - buttonSide / 2.0f, 50.0f, buttonSide, buttonSide);
    
    CGFloat quadro = self.frame.size.width / 4.0f;
    
//    self.pauseButton.frame = CGRectMake(self.playButton.frame.origin.x - buttonSide * 3.0f, 50.0f, buttonSide, buttonSide);
//	self.stopButton.frame = CGRectMake(self.playButton.frame.origin.x + buttonSide * 3.0f, 50.0f, buttonSide, buttonSide);
    
    self.pauseButton.frame = CGRectMake(self.playButton.frame.origin.x - quadro, 50.0f, buttonSide, buttonSide);
	self.stopButton.frame = CGRectMake(self.playButton.frame.origin.x + quadro, 50.0f, buttonSide, buttonSide);
}

@end
