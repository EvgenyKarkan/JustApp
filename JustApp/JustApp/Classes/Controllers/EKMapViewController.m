//
//  EKMapViewController.m
//  JustApp
//
//  Created by Evgeny Karkan on 31.01.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EKMapViewController.h"
#import "EKLayoutUtil.h"
#import "EKFontsUtil.h"
#import "EKAppDelegate.h"
#import "EKMapView.h"
#import "EKFontsUtil.h"

@interface EKMapViewController () <MKMapViewDelegate>

@property (nonatomic, strong) EKAppDelegate *appDelegate;
@property (nonatomic, strong) EKMapView *mapView;
@property (nonatomic, strong) UIButton *startStopButton;
@property (nonatomic, assign) BOOL isTrackingLocation;

@end


@implementation EKMapViewController;

#pragma mark - Life cycle

- (void)loadView
{
	EKMapView *view = [[EKMapView alloc] init];
	self.view = view;
	self.mapView = view;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    
	self.appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = BACKGROUND_COLOR;
	self.title = NSLocalizedString(@"JustMap", @"JustMap");
    
    [self setupLeftMenuButton];
    
	self.startStopButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.startStopButton.frame = CGRectMake(0.0f, 0.0f, 50.0f, 32.0f);
	[self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startStopButton.titleLabel setFont:[UIFont fontWithName:[EKFontsUtil fontName] size:15.0f]];
	[self.startStopButton addTarget:self action:@selector(startPressed:) forControlEvents:UIControlEventTouchUpInside];
    
	UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
	[barButton setCustomView:self.startStopButton];
	self.navigationItem.rightBarButtonItem = barButton;
    
    self.mapView.map.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Side-menu button with handler

- (void)setupLeftMenuButton
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
}

- (void)leftDrawerButtonPress:(id)sender
{
    NSParameterAssert(sender != nil);
    
    self.appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
	[self.appDelegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - Action

- (void)startPressed:(id)sender
{
    NSParameterAssert(sender != nil);
    
    self.isTrackingLocation = !self.isTrackingLocation;
    
    if (self.isTrackingLocation) {
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
    }
    else {
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation> )annotation
{
	if ([annotation isKindOfClass:[MKUserLocation class]]) {
		return nil;
    }
    
	static NSString *identifier = @"MyLocation";
    
	if ([annotation isKindOfClass:[MyLocation class]]) {
		MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView.map dequeueReusableAnnotationViewWithIdentifier:identifier];
		if (annotationView == nil) {
			annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
		}
		else {
			annotationView.annotation = annotation;
		}
        
		annotationView.enabled = YES;
		annotationView.canShowCallout = YES;
		annotationView.image = [UIImage imageNamed:@"arrest.png"]; 
        
		return annotationView;
	}
    
	return nil;
}

@end
