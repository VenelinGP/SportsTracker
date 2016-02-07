//
//  ExploreViewController.m
//  SportsTracker
//
//  Created by Venelin Petkov on 2/3/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import "ExploreViewController.h"
#import "Coordinates.h"


@interface ExploreViewController ()<CLLocationManagerDelegate, GMSMapViewDelegate>

@property (nonatomic, strong) GMSMapView *mapView;

@end


@implementation ExploreViewController

//GMSMapView *mapView_;



- (void)viewDidLoad {
    [super viewDidLoad];

    _mapView.settings.myLocationButton = YES;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: defaultLat
                                                            longitude: defaultLong
                                                                 zoom: defaultZoom];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.mapType = kGMSTypeNormal;
    _mapView.myLocationEnabled = YES;
    self.view = _mapView;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapView addObserver:self forKeyPath:@"myLocation" options:0 context:nil];
}

- (void)dealloc {
    [self.mapView removeObserver:self forKeyPath:@"myLocation"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"myLocation"]) {
        CLLocation *location = [object myLocation];
        //...
        NSLog(@"Location, %@,", location);
        
        CLLocationCoordinate2D target =
        CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        
        [self.mapView animateToLocation:target];
        [self.mapView animateToZoom:15];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
