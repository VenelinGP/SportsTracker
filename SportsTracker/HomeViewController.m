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
@property (strong, nonatomic) IBOutlet UILabel *labelForButton;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"check and create database");
    NSString *currentFullName = @"Sign In";
    NSString *selectUserIsLogged =[NSString stringWithFormat: @"%@ WHERE isLogged = 1", selectAllUsersSQL];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:databaseName];
    NSLog(@"%@", path);
    self.labelForButton.text = currentFullName;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
       return;
    }
    else{
        [db open];
        NSLog(@"Database exist.");
        FMResultSet *selectResult = [db executeQuery: selectUserIsLogged];
        if (selectResult == nil) {
            [db executeUpdate:createTableUserSQL];
            [db executeUpdate:createTableWorkoutsSQL];
            [db executeUpdate:createTableLocationsSQL];
            //NSLog(@"Table created!");
        }
        else{
            while ([selectResult next]) {
                //NSString  *currentUsername = [selectResult stringForColumn:@"username"];
                currentFullName = [selectResult stringForColumn:@"fullName"];
                NSLog(@"Name: %@", currentFullName);
                self.labelForButton.text = currentFullName;
            }
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
