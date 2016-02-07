//
//  WorkoutSubView.h
//  SportsTracker
//
//  Created by Venelin Petkov on 2/7/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WorkoutSubUIView : UIView
@property (strong, nonatomic) IBOutlet UILabel *labelDate;
@property (strong, nonatomic) IBOutlet UILabel *labelDuration;
@property (strong, nonatomic) IBOutlet UILabel *labelDistance;
@property (strong, nonatomic) IBOutlet UILabel *labelMaxSpeed;
@property (strong, nonatomic) IBOutlet UILabel *labelAvgSpeed;
@property (strong, nonatomic) IBOutlet UIButton *buttonStart;
@property (strong, nonatomic) IBOutlet UIButton *buttonStop;


@end
