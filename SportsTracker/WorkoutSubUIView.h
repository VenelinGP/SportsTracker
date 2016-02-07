//
//  WorkoutSubView.h
//  SportsTracker
//
//  Created by Venelin Petkov on 2/7/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleMaps/GoogleMaps.h"

@interface WorkoutSubUIView : UIView
@property (strong, nonatomic) IBOutlet UILabel *labelDuration;
@property (strong, nonatomic) IBOutlet UILabel *labelDistance;
@property (strong, nonatomic) IBOutlet UILabel *labelMaxSpeed;
@property (strong, nonatomic) IBOutlet UILabel *labelAvgSpeed;
- (IBAction)buttonStart:(id)sender;

@end
