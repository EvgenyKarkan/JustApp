//
//  EKMusicPlayerViewController.m
//  JustApp
//
//  Created by Evgeny Karkan on 02.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMusicPlayerViewController.h"
#import "EKLayoutUtil.h"
#import "EKAppDelegate.h"
#import "EKMusicPlayerView.h"
#import "EKMusicPlayerTableViewProvider.h"
#import "EKFileSystemUtil.h"
#import "EKMusicPlayer.h"

@interface EKMusicPlayerViewController () <EKMusicPlayerTableViewProviderDelegate>

@property (nonatomic, strong) EKAppDelegate                  *appDelegate;
@property (nonatomic, strong) EKMusicPlayerView              *musicPlayerView;
@property (nonatomic, strong) EKMusicPlayerTableViewProvider *tableViewProvider;
@property (nonatomic, strong) NSTimer                        *timer;
@property (nonatomic, assign) BOOL                            paused;
@property (nonatomic, assign) NSUInteger                     lastPressedButtonTag;

@end


@implementation EKMusicPlayerViewController;

#pragma mark - Life cycle

- (void)loadView
{
	EKMusicPlayerView *view = [[EKMusicPlayerView alloc] init];
	self.view = view;
	self.musicPlayerView = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Create new folder "Music" in Documents directory
    [EKFileSystemUtil createNewFolderInDocumentsWithName:@"Music"];
    
    //Copy music files from bundle to "Music" folder
    [EKFileSystemUtil copyFile:@"LMFAO - Sexy & I know it.mp3" toFolder:@"Music"];
    [EKFileSystemUtil copyFile:@"Eminem - Rhianna.mp3" toFolder:@"Music"];
    [EKFileSystemUtil copyFile:@"LMFAO - Party Rock Anthem.mp3" toFolder:@"Music"];
    [EKFileSystemUtil copyFile:@"Pink panther theme.mp3" toFolder:@"Music"];
    [EKFileSystemUtil copyFile:@"Tarantella dance.mp3" toFolder:@"Music"];

    self.tableViewProvider = [[EKMusicPlayerTableViewProvider alloc] initWithData:[EKFileSystemUtil filesFromFolder:@"Music"]
                                                                         delegate:self];
    self.musicPlayerView.tableView.delegate = self.tableViewProvider;
	self.musicPlayerView.tableView.dataSource = self.tableViewProvider;
    [self setupUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup buttons

- (void)setupUI
{
	MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self
	                                                                                 action:@selector(leftDrawerButtonPress:)];
	leftDrawerButton.tintColor = [UIColor whiteColor];
    
	if ([EKLayoutUtil isSystemVersionLessThan7]) {
		UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
		                                                                        target:nil
		                                                                        action:nil];
		spacer.width = 12.0f;
		[self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:spacer, leftDrawerButton, nil]
		                                  animated:NO];
	}
	else {
		[self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
	}
    
    [self.navigationController.navigationBar setTranslucent:NO];
	self.title = NSLocalizedString(@"JustMusicPlayer", @"JustMusicPlayer");
}

- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)sender
{
    NSParameterAssert(sender != nil);
    
    self.appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
	[self.appDelegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - EKMusicPlayerProviderDelegate

- (void)playDidPressedWithTag:(NSUInteger)tag
{
    self.lastPressedButtonTag = tag;
	NSArray *songs = [EKFileSystemUtil filesFromFolder:@"Music"];
    self.musicPlayerView.songLabel.text = [songs[tag] allKeys][0];
    
	if (!self.paused) {
		[[EKMusicPlayer sharedInstance] playMusicFile:[songs[tag] allValues][0]];
	}
	else {
		[[EKMusicPlayer sharedInstance] play];
	}
    
	self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
	                                              target:self
	                                            selector:@selector(timerFired:)
	                                            userInfo:nil
	                                             repeats:YES];
    
	[[NSRunLoop currentRunLoop] addTimer:self.timer
	                             forMode:NSRunLoopCommonModes];
	self.paused = NO;
}

- (void)pauseDidPressedWithTag:(NSUInteger)tag
{
    if (self.lastPressedButtonTag != tag) {
        return;
    }
    
	self.paused = !self.paused;
	[[EKMusicPlayer sharedInstance] pause];
	[self.timer invalidate];
	[self updateDisplay];
}

- (void)stopDidPressedWithTag:(NSUInteger)tag
{
    if (self.lastPressedButtonTag != tag) {
        return;
    }
    
	[[EKMusicPlayer sharedInstance] stop];
	[self.timer invalidate];
	[self updateDisplay];
}

#pragma mark - Actions

- (void)timerFired:(NSTimer *)timer
{
    NSParameterAssert(timer != nil);
    
	[self updateDisplay];
}

- (void)updateDisplay
{
	NSTimeInterval currentTime = [[EKMusicPlayer sharedInstance] currentTime];
	NSTimeInterval duration = [[EKMusicPlayer sharedInstance] duration];
    
	[self.musicPlayerView.progressView setProgress:(CGFloat)(currentTime / duration)
	                                      animated:YES];
}

@end
