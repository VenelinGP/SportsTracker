//
//  WorkoutViewController.m
//  SportsTracker
//
//  Created by Venelin Petkov on 2/7/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import "WorkoutViewController.h"
#import "WorkoutSubUIView.h"
#import "Coordinates.h"
#import "GoogleMaps/GoogleMaps.h"
#import "Location.h"
#import "Workout.h"
#import "SportsTracker-Swift.h"
#import "User.h"
#import "FMDB.h"
#import "SQLStrings.h"

@interface WorkoutViewController ()<CLLocationManagerDelegate, GMSMapViewDelegate>

@property (strong, nonatomic) WorkoutSubUIView *workoutSubView;
@property int seconds;
@property float distance;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WorkoutViewController

float currentLat;
float currentLong;

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDateFormatter *currentData = [[NSDateFormatter alloc] init];
    [currentData setDateFormat:@"dd.MMM.YYYY   hh:mm"];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: defaultLat
                                                            longitude: defaultLong
                                                                 zoom: defaultZoom];
    //set the camera for the map
    self.mapContainerView.camera = camera;
    self.mapContainerView.myLocationEnabled = YES;
    
    _workoutSubView = [[[NSBundle mainBundle] loadNibNamed:@"WorkoutSubUIView"
                                                               owner:self
                                                             options:nil]
                                 objectAtIndex:0];
    
    [self.view addSubview:_workoutSubView];
    
    self.workoutSubView.labelDate.text = [NSString stringWithFormat:@"%@", [currentData stringFromDate:[NSDate date]]];
    self.workoutSubView.buttonStop.hidden = YES;
    
    [_workoutSubView.buttonStart addTarget:self action:@selector(startLocationUpdates) forControlEvents:UIControlEventTouchUpInside];
    [_workoutSubView.buttonStart addTarget:self action:@selector(startWorkout) forControlEvents:UIControlEventTouchUpInside];
    [_workoutSubView.buttonStop addTarget:self action:@selector(stopWorkout) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
            [super viewWillAppear:animated];
            [self.mapContainerView addObserver:self forKeyPath:@"myLocation" options:0 context:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

- (void)dealloc {
    [self.mapContainerView removeObserver:self forKeyPath:@"myLocation"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"myLocation"]) {
        CLLocation *location = [object myLocation];
        //...
        NSLog(@"Location, %@,", location);
        
        CLLocationCoordinate2D target =
        CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        
        [self.mapContainerView animateToLocation:target];
        [self.mapContainerView animateToZoom:17];
    }
}

- (void)eachSecond
{
    Calculations *calc =[[Calculations alloc]init];

    self.seconds++;
    self.workoutSubView.labelDuration.text = [NSString stringWithFormat: @"%@", [calc stringifySecondCountWithSeconds:self.seconds andLongFormat:NO]];
    self.workoutSubView.labelDistance.text = [NSString stringWithFormat: @"%@", [calc stringifyDistanceInMeters:self.distance]];
    self.workoutSubView.labelAvgSpeed.text = [NSString stringWithFormat:@"%@",  [calc stringifyAvgSpeedInMeters:self.distance andSeconds:self.seconds]];
}
-(void)startWorkout{
    self.workoutSubView.buttonStart.hidden = YES;
    self.workoutSubView.buttonStop.hidden = NO;
    self.workoutSubView.labelDuration.text = @"00:00";
    self.workoutSubView.labelDistance.text = @"0.00 km";
    self.workoutSubView.labelMaxSpeed.text = @"0.00 km/h";
    self.workoutSubView.labelAvgSpeed.text = @"0.00 m/s";
    self.seconds = 0;
    self.distance = 0;
    self.locations = [NSMutableArray array];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(eachSecond) userInfo:nil repeats:YES];
    [self startLocationUpdates];
}

-(void)stopWorkout{
    self.workoutSubView.buttonStart.hidden = NO;
    self.workoutSubView.buttonStop.hidden = YES;
    self.workoutSubView.labelMaxSpeed.text = @"0.00 km/h";
    NSDateFormatter *currentData = [[NSDateFormatter alloc] init];
    [currentData setDateFormat:@"dd.MMM.YYYY   hh:mm"];
    self.workoutSubView.labelDate.text = [NSString stringWithFormat:@"%@", [currentData stringFromDate:[NSDate date]]];
    [self.timer invalidate];
    [_locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray*)locations{
    CLLocation *location =[locations lastObject];
    
    currentLat = location.coordinate.latitude;
    currentLong = location.coordinate.longitude;
    
    NSLog(@"Longtitude: %.2f | Latitude: %.2f", currentLong, currentLat);
    for (CLLocation *newLocation in locations) {
        if (newLocation.horizontalAccuracy < 20) {
            
            // update distance
            if (self.locations.count > 0) {
                self.distance += [newLocation distanceFromLocation:self.locations.lastObject];
            }
            
            [self.locations addObject:newLocation];
        }
    }

}

- (void)startLocationUpdates
{
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeFitness;
    
    self.locationManager.distanceFilter = 10; // meters
    [self.locationManager startUpdatingLocation];
}

-(void)saveWorkout{
    
    Workout *workout = [[Workout alloc]init];
    
    workout.distance = (float)[NSNumber numberWithFloat:self.distance];
    workout.duration = (int)[NSNumber  numberWithInt:self.seconds];
    workout.timestamps = [NSDate date];
    workout.userId =1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
