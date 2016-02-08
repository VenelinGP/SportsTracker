//
//  Workout.m
//  SportsTracker
//
//  Created by Venelin Petkov on 2/8/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import "Workout.h"

@implementation Workout

-(instancetype)initDistance: (float *)distance
                   duration: (int *)duration
                 timestamps: (NSDate *)timestamps
                  andUserId: (int *)userId

{
    self = [super init];
    if (self) {
        self.distance = *(distance);
        self.duration = *(duration);
        self.timestamps = timestamps;
        self.userId=*(userId);
    }
    return self;
}


+(Workout *)distance: (float *)distance
            duration: (int *)duration
          timestamps: (NSDate *)timestamps
           andUserId: (int *)userId{
    return [[Workout alloc] initDistance:distance
                                duration:duration
                              timestamps:timestamps
                               andUserId:userId];
}

@end
