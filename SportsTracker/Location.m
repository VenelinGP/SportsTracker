//
//  Location.m
//  SportsTracker
//
//  Created by Venelin Petkov on 2/8/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import "Location.h"

@implementation Location

-(instancetype)initLatitude: (float *)latitude
                   longitude: (float *)longitude
                 timestamps: (NSDate *)timestamps
                  andUserId: (int *)userId

{
    self = [super init];
    if (self) {
        self.latitude = *(latitude);
        self.longitude = *(longitude);
        self.timestamps = timestamps;
        self.userId=*(userId);
    }
    return self;
}


+(Location *)latitude: (float *)latitude
            longitude: (float *)longitude
          timestamps: (NSDate *)timestamps
           andUserId: (int *)userId{
    return [[Location alloc] initLatitude:latitude
                                longitude:longitude
                              timestamps:timestamps
                               andUserId:userId];
}
@end
