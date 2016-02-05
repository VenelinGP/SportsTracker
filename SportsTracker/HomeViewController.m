//
//  FirstViewController.m
//  SportsTracker
//
//  Created by Venelin Petkov on 2/3/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import "HomeViewController.h"
#import "FMDB.h"

@interface HomeViewController ()


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profileImageView.layer.cornerRadius = 15.0f;

    //self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    
    self.profileImageView.layer.borderWidth = 3.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    NSLog(@"check and create database doing");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"test.db"];
    NSString *createTableUser = @"create table user(name text primary key, age int)";
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
       
        return;
    }
    else{
        [db open];
        NSLog(@"Database exist.");
        FMResultSet *selectResult = [db executeQuery:@"SELECT * FROM user"];
        if (selectResult == nil) {
            [db executeUpdate:createTableUser];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
