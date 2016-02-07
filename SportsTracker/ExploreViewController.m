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

@end


@implementation ExploreViewController

GMSMapView *mapView_;



- (void)viewDidLoad {
    [super viewDidLoad];

    mapView_.settings.myLocationButton = YES;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: defaultLat
                                                            longitude: defaultLong
                                                                 zoom: defaultZoom];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.mapType = kGMSTypeNormal;
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(defaultLat, defaultLong);
    marker.title = @"Sliven";
    marker.snippet = @"Bulgaria";
    marker.map = mapView_;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
