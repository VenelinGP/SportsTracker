//
//  WorkoutViewController.h
//  SportsTracker
//
//  Created by Venelin Petkov on 2/7/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleMaps/GoogleMaps.h"

@interface WorkoutViewController : UIViewController

@property (strong, nonatomic) IBOutlet GMSMapView *mapContainerView;


@end
