//
//  Location.h
//  SportsTracker
//
//  Created by Venelin Petkov on 2/8/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property float latitude;
@property float longitude;
@property (strong, nonatomic) NSDate *timestamps;
@property int userId;

-(instancetype)initLatitude: (float)latitude
                  longitude: (float)longitude
                 timestamps: (NSDate *)timestamps
                  andUserId: (int)userId;

+(Location *)latitude: (float)latitude
            longitude: (float)longitude
           timestamps: (NSDate *)timestamps
            andUserId: (int)userId;
@end
