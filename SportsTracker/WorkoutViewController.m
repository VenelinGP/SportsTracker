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


@interface WorkoutViewController ()<CLLocationManagerDelegate, GMSMapViewDelegate>

@end

@implementation WorkoutViewController

CLLocationManager *locationManager;
float currentLat;
float currentLong;

- (void)viewDidLoad {
    [super viewDidLoad];

    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: defaultLat
                                                            longitude: defaultLong
                                                                 zoom: defaultZoom];
    //set the camera for the map
    self.mapContainerView.camera = camera;
    self.mapContainerView.myLocationEnabled = YES;
    
    WorkoutSubUIView *subView = [[[NSBundle mainBundle] loadNibNamed:@"WorkoutSubUIView"
                                                               owner:self
                                                             options:nil]
                                 objectAtIndex:0];
    [self.view addSubview:subView];
    
    [subView.buttonStart addTarget:self action:@selector(startLocationManager) forControlEvents:UIControlEventTouchUpInside];

    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapContainerView addObserver:self forKeyPath:@"myLocation" options:0 context:nil];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) startLocationManager{

    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        NSLog(@"Enabled");
    } else {
        NSLog(@"Not Enabled");
    }
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray*)locations{
    CLLocation *location =[locations lastObject];
    
    currentLat = location.coordinate.latitude;
    currentLong = location.coordinate.longitude;
    
    NSLog(@"Longtitude: %.2f | Latitude: %.2f", currentLong, currentLat);    
    //[locationManager stopUpdatingLocation];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
