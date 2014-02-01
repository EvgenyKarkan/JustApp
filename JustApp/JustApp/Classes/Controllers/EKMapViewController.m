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
#import "EKLocation.h"
#import "PSLocationManager.h"

@interface EKMapViewController () <MKMapViewDelegate, PSLocationManagerDelegate>

@property (nonatomic, strong) EKAppDelegate  *appDelegate;
@property (nonatomic, strong) EKMapView      *mapView;
@property (nonatomic, strong) UIButton       *startStopButton;
@property (nonatomic, assign) BOOL            isTrackingLocation;
@property (nonatomic, strong) EKLocation     *userLocation;
@property (nonatomic, strong) CLLocation     *waypoint;
@property (nonatomic, strong) NSMutableArray *breadcrumbs;
@property (nonatomic, retain) MKPolyline     *routeLine;
@property (nonatomic, retain) MKPolylineView *routeLineView;

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
	
    [self setupUI];
    
    self.mapView.map.delegate = self;
    [PSLocationManager sharedLocationManager].delegate = self;
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
	self.title = NSLocalizedString(@"JustMap", @"JustMap");
    
    self.startStopButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.startStopButton.frame = CGRectMake(0.0f, 0.0f, 50.0f, 32.0f);
	[self.startStopButton setTitle:NSLocalizedString(@"START_BUTTON_STARTS", @"")
                          forState:UIControlStateNormal];
    [self.startStopButton.titleLabel setFont:[UIFont fontWithName:[EKFontsUtil fontName]
                                                             size:15.0f]];
	[self.startStopButton addTarget:self
                             action:@selector(startPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
    
	UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
	[barButton setCustomView:self.startStopButton];
	self.navigationItem.rightBarButtonItem = barButton;
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
	[self clearMap];
    
	if (self.isTrackingLocation) {
		[self.startStopButton setTitle:NSLocalizedString(@"START_BUTTON_STOPS", @"")
                              forState:UIControlStateNormal];
	}
	else {
		[self.startStopButton setTitle:NSLocalizedString(@"START_BUTTON_STARTS", @"")
                              forState:UIControlStateNormal];
	}
	[self.mapView.map addAnnotation:self.userLocation];
	[self.mapView.map selectAnnotation:self.userLocation animated:YES];
}

#pragma mark - MKMapViewDelegate API

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation> )annotation
{
	if ([annotation isKindOfClass:[MKUserLocation class]]) {
		return nil;
	}
    
	static NSString *identifier = @"EKLocation";
    
	if ([annotation isKindOfClass:[EKLocation class]]) {
		MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView.map dequeueReusableAnnotationViewWithIdentifier:identifier];
		if (annotationView == nil) {
			annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:identifier];
		}
		else {
			annotationView.annotation = annotation;
		}
		annotationView.enabled        = YES;
		annotationView.canShowCallout = YES;
		annotationView.image          = self.userLocation.imageForPin;
        
		return annotationView;
	}
	return nil;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(0.0f, 0.0f),
                                                       MKCoordinateSpanMake(0.0f, 0.0f));
	MKCoordinateSpan span = MKCoordinateSpanMake(0.05f, 0.05f);
    
	CLLocationCoordinate2D location = CLLocationCoordinate2DMake(userLocation.coordinate.latitude,
                                                                 userLocation.coordinate.longitude);
	region.span = span;
	region.center = location;
    
	[mapView setRegion:region animated:YES];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay> )overlay
{
	MKOverlayView *overlayView = nil;
    
	if (overlay == self.routeLine) {
		if (self.routeLineView) {
			[self.routeLineView removeFromSuperview];
		}
		self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
		self.routeLineView.fillColor = [UIColor redColor];
		self.routeLineView.strokeColor = [UIColor redColor];
		self.routeLineView.lineWidth = 10;
		overlayView = self.routeLineView;
	}
    
	return overlayView;
}

#pragma mark - Helpers API

- (void)clearMap
{
	if ([[self.mapView.map annotations] count] > 2) {
		NSMutableArray *array = [@[] mutableCopy];
        
		for (id <MKAnnotation> annotation in [self.mapView.map annotations]) {
			if (![annotation isKindOfClass:[MKUserLocation class]]) {
				[array addObject:annotation];
			}
		}
		[self.mapView.map removeAnnotations:array];
		[self.mapView.dashboardView setUpInitialStateForLabels];
		[self.mapView.map removeOverlay:self.routeLine];
	}
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval
{
    NSInteger newTimeinterval = (NSInteger)interval;
    NSInteger seconds         = newTimeinterval % 60;
    NSInteger minutes         = (newTimeinterval / 60) % 60;
    NSInteger hours           = (newTimeinterval / 3600);
    
	return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];
}

- (void)showRoute
{
	MKMapPoint northEastPoint = MKMapPointMake(0.f, 0.f);
	MKMapPoint southWestPoint = MKMapPointMake(0.f, 0.f);
	MKMapPoint *pointArray    = malloc(sizeof(CLLocationCoordinate2D) * [self.breadcrumbs count]);
    
	NSParameterAssert([self.breadcrumbs count] > 1);
    
	for (NSUInteger i = 0; i < [self.breadcrumbs count]; i++) {
		CLLocationCoordinate2D location2D = [(NSValue *)self.breadcrumbs[i] MKCoordinateValue];
		MKMapPoint point = MKMapPointForCoordinate(CLLocationCoordinate2DMake(location2D.latitude,
                                                                              location2D.longitude));
        
		if (i == 0) {
			northEastPoint = point;
			southWestPoint = point;
		}
		else {
			if (point.x > northEastPoint.x) {
				northEastPoint.x = point.x;
			}
			if (point.y > northEastPoint.y) {
				northEastPoint.y = point.y;
			}
			if (point.x < southWestPoint.x) {
				southWestPoint.x = point.x;
			}
			if (point.y < southWestPoint.y) {
				southWestPoint.y = point.y;
			}
		}
		pointArray[i] = point;
	}
    
	if (self.routeLine) {
		[self.mapView.map removeOverlay:self.routeLine];
	}
    
	self.routeLine = [MKPolyline polylineWithPoints:pointArray
	                                          count:[self.breadcrumbs count]];
    
	if (nil != self.routeLine) {
		[self.mapView.map addOverlay:self.routeLine];
	}
    
	free(pointArray);
}

#pragma mark - "isTrackingLocation" setter

- (void)setIsTrackingLocation:(BOOL)isTrackingLocation
{
	_isTrackingLocation = isTrackingLocation;
    
	NSString *title     = nil;
	NSString *subtitle  = nil;
	NSString *imageName = nil;
    
	if (_isTrackingLocation) {
		title     = NSLocalizedString(@"START_TRACKING", @"");
		subtitle  = NSLocalizedString(@"START_TRACKING_INFO", @"");
		imageName = @"StartPin";
        
        [[PSLocationManager sharedLocationManager] prepLocationUpdates];
		[[PSLocationManager sharedLocationManager] resetLocationUpdates];
		[[PSLocationManager sharedLocationManager] startLocationUpdates];
        
		EKLocation *location = [[EKLocation alloc] initWithTitle:title
		                                                subTitle:subtitle
		                                                   image:[UIImage imageNamed:imageName]
		                                              coordinate:self.mapView.map.userLocation.location.coordinate];
		self.userLocation = location;
		self.breadcrumbs = [@[] mutableCopy];
		[self.breadcrumbs addObject:[NSValue valueWithMKCoordinate:self.mapView.map.userLocation.location.coordinate]];
	}
	else {
		title     = NSLocalizedString(@"END_TRACKING", @"");
		subtitle  = NSLocalizedString(@"END_TRACKING_INFO", @"");
		imageName = @"FinishPin";
        
		[[PSLocationManager sharedLocationManager] stopLocationUpdates];
        
		CLLocationCoordinate2D endPoint = CLLocationCoordinate2DMake(0.0f, 0.0f);
        
#ifdef __i386__
		endPoint = self.waypoint.coordinate;
#else
		endPoint = self.mapView.map.userLocation.location.coordinate;
#endif
		EKLocation *location = [[EKLocation alloc] initWithTitle:title
		                                                subTitle:subtitle
		                                                   image:[UIImage imageNamed:imageName]
		                                              coordinate:endPoint];
		self.userLocation = location;
	}
}

#pragma mark - PSLocationManagerDelegate APIs

- (void)locationManager:(PSLocationManager *)locationManager distanceUpdated:(CLLocationDistance)distance
{
	self.mapView.dashboardView.distanceLabel.text = [NSString stringWithFormat:@"%.2f %@", distance  / 1000.0f, @"km"];
}

- (void)locationManager:(PSLocationManager *)locationManager waypoint:(CLLocation *)waypoint calculatedSpeed:(double)calculatedSpeed
{
	[self.breadcrumbs addObject:[NSValue valueWithMKCoordinate:waypoint.coordinate]];
    
#ifdef __i386__
	self.waypoint = [[CLLocation alloc] init];
	self.waypoint = waypoint;
#else
#endif
    
	if (calculatedSpeed < 0) {
		calculatedSpeed = 0.0f;
	}
	self.mapView.dashboardView.speedLabel.text = [NSString stringWithFormat:@"%.2f %@", calculatedSpeed, @"mph"];
	self.mapView.dashboardView.timeLabel.text = [self stringFromTimeInterval:locationManager.totalSeconds];
    
    [self showRoute];
}

- (void)locationManager:(PSLocationManager *)locationManager error:(NSError *)error
{
	[SVProgressHUD showErrorWithStatus:NSLocalizedString(@"UNABLE_LOCATION", @"")];
}

@end
