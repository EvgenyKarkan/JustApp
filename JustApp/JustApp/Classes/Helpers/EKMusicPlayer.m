//
//  EKMusicPlayer.m
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMusicPlayer.h"


@interface EKMusicPlayer ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end


@implementation EKMusicPlayer;

#pragma mark Singleton stuff

static id _sharedInstance;

+ (EKMusicPlayer *)sharedInstance //public API
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[EKMusicPlayer alloc] init];
    });
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = nil;
        _sharedInstance = [super allocWithZone:zone];
    });
    return _sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (id)new
{
    NSException *exception = [[NSException alloc] initWithName:kEKException
                                                        reason:kEKExceptionReason
                                                      userInfo:nil];
    [exception raise];
    
    return nil;
}

#pragma mark - Public APIs

- (void)playMusicFile:(NSData *)file
{
    NSParameterAssert(file != nil);
    
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithData:file
                                                error:&error];
    NSParameterAssert(error == nil);
    
    [self.player prepareToPlay];
    [self.player play];
}

- (NSTimeInterval)currentTime
{
    return self.player.currentTime;
}

- (NSTimeInterval)duration
{
    return self.player.duration;
}

- (void)pause
{
    [self.player pause];
}

- (void)play
{
    [self.player play];
}

- (void)stop
{
    [self.player stop];
    self.player.currentTime = 0.0f;
}

@end
