//
//  EKGalleryViewController.m
//  JustApp
//
//  Created by Evgeny Karkan on 03.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKGalleryViewController.h"
#import "EKGalleryCell.h"
#import "EKLayoutUtil.h"
#import "EKAppDelegate.h"


@interface EKGalleryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, copy)   NSArray       *URLs;
@property (nonatomic, strong) EKAppDelegate *appDelegate;

@end


@implementation EKGalleryViewController;

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    
    self.URLs = @[@"http://upload.wikimedia.org/wikipedia/commons/f/fa/T-72_Ajeya1.jpg",
                  @"http://bm.img.com.ua/img/prikol/images/large/2/6/171162_336488.jpg",
                  @"http://img.go2load.com/photo/02/FunnyCatsKittens_090310/001_FunnyCatsKittens_090310_Go2LoadCOM.jpg",
                  @"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSTlUKlAVNk72xMPZSwAfgdw05_wjPkQdss0qZ-IAhOZCQMuOoQAIkWU3k",
	              @"http://freeon.in.ua/uploads/posts/2011-11/thumbs/1320600215_0_284da_78d5c77a_xl.jpg",
	              @"http://cs402817.vk.me/v402817321/8941/IU0ZH7TlZmQ.jpg",
	              @"http://cs314324.vk.me/v314324315/4cab/7lgB7KJQ60U.jpg",
	              @"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSHbQ5C977wp1rF7PFEgYE7S7HyR_IgRgPKhsMv2m8pupTQZJvpyFYbmA",
	              @"http://www.ljplus.ru/img/m/o/mosomedve/cat_orang.jpg",
	              @"http://img-fotki.yandex.ru/get/6618/3263013.f/0_767a9_f502ca25_L.jpg",
	              @"http://f3.mylove.ru/2om9Nng5pQvYCjH.jpg",
	              @"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcR_en0Je9FY6Mucx_rGqpq9sf8V0O4AI0VT6CmpjH2yDRgFhvqIZw"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UI

- (void)setupUI
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.bounces = YES;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = BACKGROUND_COLOR;
    self.tableView.separatorColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3f];
    self.tableView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - 64.0f);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
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
    self.title = NSLocalizedString(@"JustPhotoGallery", @"JustPhotoGallery");
    
    if (![EKLayoutUtil isSystemVersionLessThan7]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)sender
{
    NSParameterAssert(sender != nil);
    
    self.appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.appDelegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - Tableview API  --> this controller class is too easy -> so I decided to do all table view stuff here just for speed

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.URLs count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"myIdentifier";
    
    EKGalleryCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    
    if (cell == nil) {
        cell = [[EKGalleryCell alloc] init];
    }
    NSURL *imageUrl = [NSURL URLWithString:self.URLs[indexPath.row]];
    
    __weak EKGalleryCell *weakCell = cell;
    
    [cell.icon setImageWithURL:imageUrl
              placeholderImage:[UIImage imageNamed:@"Cat"]
                     completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                         weakCell.title.text = @"Image downloaded!";
                     }];
    return cell;
}

@end
