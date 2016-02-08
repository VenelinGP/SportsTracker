//
//  Workout.h
//  SportsTracker
//
//  Created by Venelin Petkov on 2/8/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Workout : NSObject

@property float *distance;
@property int duration;
@property (strong, nonatomic) NSDate *timestamps;
@property int userId;


-(instancetype)initDistance: (float *)distance
                   duration: (int *)duration
                 timestamps: (NSDate *)timestamps
                  andUserId: (int *)userId;

+(Workout *)distance: (float *)distance
            duration: (int *)duration
          timestamps: (NSDate *)timestamps
           andUserId: (int *)userId;
@end
