//
//  Constants.m
//  SportsTracker
//
//  Created by Venelin Petkov on 2/6/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import "SQLStrings.h"

@implementation SQLStrings

NSString *const databaseName = @"SportsTracker.db";
NSString *const selectAllUsersSQL = @"SELECT * FROM users";
NSString *const createTableUserSQL = @"CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, fullName TEXT, imageName TEXT, address TEXT, email TEXT, age INT, isLogged INT)";
NSString *const insertUserSQL = @"INSERT INTO users (username, password, fullName, imageName, address, email, age, isLogged) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
@end
