//
//  SignUpViewController.m
//  SportsTracker
//
//  Created by Venelin Petkov on 2/6/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import "SignUpViewController.h"
#import "FMDB.h"
#import "User.h"
#import "SQLStrings.h"

@interface SignUpViewController ()
@property (strong, nonatomic) IBOutlet UITextField *fieldFullname;
@property (strong, nonatomic) IBOutlet UITextField *fieldUsername;
@property (strong, nonatomic) IBOutlet UITextField *fieldPassword;
@property (strong, nonatomic) IBOutlet UITextField *fieldEmail;

- (IBAction)buttonSignIn:(id)sender;

@end

@implementation SignUpViewController

- (IBAction)buttonSignIn:(id)sender {
    
    User *user = [[User alloc]
                  initName:self.fieldUsername.text
                  password:self.fieldPassword.text
                  fullName:self.fieldFullname.text
                  imageName:@"default"
                  address:@""
                  email:self.fieldEmail.text
                  age: -1
                  andIsLogged: 1];
    NSInteger userAge = (NSInteger)user.age;
    NSInteger userIsLogged = (NSInteger) user.isLogged;
    
    int userExist = 0;
    NSString *selectUser =[NSString stringWithFormat: @"%@ WHERE username = \"%@\"", selectAllUsersSQL, user.username];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:databaseName];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        [db close];
        return;
    }
    else{
        FMResultSet *result = [db executeQuery: selectUser];
        if (!(result == nil)) {
            while ([result next]) {
                NSString  *currentUsername = [result stringForColumn:@"username"];
                if (currentUsername == user.username) {
                    ++userExist;
                    NSLog(@"Username exist");
                }
            }
            if (userExist == 0) {
                BOOL success = [db executeUpdate: insertUserSQL, user.username, user.password, user.fullName, user.imageName, user.address, user.email, @(userAge), @(userIsLogged)];
                if (!success) {
                    NSLog(@"error = %@", [db lastErrorMessage]);
                }
                else {
                    NSLog(@"succsess");
                }
                [db close];
                NSLog(@"Table updated");
            }
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
