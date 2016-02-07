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


@interface WorkoutViewController ()<CLLocationManagerDelegate>

@end

@implementation WorkoutViewController

CLLocationManager *locationManager;
float currentLat;
float currentLong;

- (void)viewDidLoad {
    [super viewDidLoad];

    
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
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: defaultLat
                                                            longitude: defaultLong
                                                                 zoom: defaultZoom];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(defaultLat, defaultLong);
    marker.title = @"Sliven";
    marker.snippet = @"Bulgaria";
    marker.map = self.mapContainerView;
    
    //set the camera for the map
    self.mapContainerView.camera = camera;
    self.mapContainerView.myLocationEnabled = YES;
    
    UIView *subView = [[[NSBundle mainBundle] loadNibNamed:@"WorkoutSubUIView"
                                                     owner:self
                                                   options:nil]
                       objectAtIndex:0];
    [self.view addSubview:subView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray*)locations{
    CLLocation *location =[locations lastObject];
    
    float lat = location.coordinate.latitude;
    currentLat = lat;
    float lon = location.coordinate.longitude;
    currentLong = lon;
    
    NSLog(@"Longtitude: %.2f | Latitude: %.2f", lon, lat);
    
    [locationManager stopUpdatingLocation];
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
