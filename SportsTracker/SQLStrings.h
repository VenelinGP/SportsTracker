//
//  Constants.h
//  SportsTracker
//
//  Created by Venelin Petkov on 2/6/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLStrings : NSObject

extern NSString *const databaseName;
extern NSString *const selectAllUsersSQL;
extern NSString *const createTableUserSQL;
extern NSString *const insertUserSQL;

@end
