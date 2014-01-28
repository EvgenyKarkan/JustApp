//
//  EKMenuViewController.m
//  JustApp
//
//  Created by Evgeny Karkan on 28.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMenuViewController.h"
#import "EKMenuView.h"
#import "EKMenuTableViewProvider.h"

@interface EKMenuViewController () <EKMenuTableViewProviderDelegate>

@property (nonatomic, strong) EKMenuView *menuView;
@property (nonatomic, strong) EKMenuTableViewProvider *tableViewProvider;

@end


@implementation EKMenuViewController;

#pragma mark - Life cycle

- (void)loadView
{
    EKMenuView *view = [[EKMenuView alloc] init];
	self.view = view;
	self.menuView = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableViewProvider = [[EKMenuTableViewProvider alloc] initWithDelegate:self];
    self.menuView.tableView.delegate = self.tableViewProvider;
	self.menuView.tableView.dataSource = self.tableViewProvider;
    
        //self.view.backgroundColor = MENU_BACKGROUND_COLOR;
    self.title = @"Menu";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - EKMenuTableViewProviderDelegate

- (void)cellDidPressWithIndex:(NSUInteger)index
{
    NSParameterAssert(index >= 0);
    
	switch (index) {
		case 0:
                //[self showTimeTrackViewController];
			break;
            
		case 1:
                //[self showCalendarViewController];
			break;
            
		case 2:
                //[self showSettingsViewController];
			break;
            
		default:
			break;
	}
}


@end
