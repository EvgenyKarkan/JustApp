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

@interface EKMusicPlayerViewController ()

@property (nonatomic, strong) EKAppDelegate  *appDelegate;
@property (nonatomic, strong) EKMusicPlayerView  *musicPlayerView;
@property (nonatomic, strong) EKMusicPlayerTableViewProvider *tableViewProvider;

@end


@implementation EKMusicPlayerViewController;

#pragma mark - Live cycle

- (void)loadView
{
	EKMusicPlayerView *view = [[EKMusicPlayerView alloc] init];
	self.view = view;
	self.musicPlayerView = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Create new folder Music in Documents directory
    [EKFileSystemUtil createNewFolderInDocumentsWithName:@"Music"];
    
    //Copy music files from bundle to Music folder
    [EKFileSystemUtil copyFile:@"LMFAO - Sexy & I now it.mp3" toFolder:@"Music"];
    [EKFileSystemUtil copyFile:@"Eminem - Rhianna.mp3" toFolder:@"Music"];
    [EKFileSystemUtil copyFile:@"LMFAO - Party Rock Anthem.mp3" toFolder:@"Music"];
    [EKFileSystemUtil copyFile:@"Pink panther theme.mp3" toFolder:@"Music"];
    [EKFileSystemUtil copyFile:@"Tarantella dance.mp3" toFolder:@"Music"];

    self.tableViewProvider = [[EKMusicPlayerTableViewProvider alloc] initWithData:[EKFileSystemUtil filesFromFolder:@"Music"]];
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
    
    self.view.backgroundColor = BACKGROUND_COLOR;
	self.title = NSLocalizedString(@"JustMusicPlayer", @"JustMusicPlayer");
}

- (void)leftDrawerButtonPress:(id)sender
{
    NSParameterAssert(sender != nil);
    
    self.appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
	[self.appDelegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
