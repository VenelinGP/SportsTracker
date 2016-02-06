//
//  FirstViewController.m
//  SportsTracker
//
//  Created by Venelin Petkov on 2/3/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import "HomeViewController.h"
#import "User.h"
#import "FMDB.h"
#import "SQLStrings.h"

@interface HomeViewController ()


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"check and create database");

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:databaseName];
    //NSLog(@"%@", path);
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
     
        return;
    }
    else{
        [db open];
        NSLog(@"Database exist.");
        FMResultSet *selectResult = [db executeQuery: selectAllUsersSQL];
        if (selectResult == nil) {
            [db executeUpdate:createTableUserSQL];
            //NSLog(@"Table created!");
        }
        else{
            //NSLog(@"Table exist");
            [db close];
        }
    }
    
    self.profileImageView.layer.cornerRadius = 15.0f;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 3.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
