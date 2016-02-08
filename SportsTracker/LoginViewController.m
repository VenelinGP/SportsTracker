//
//  LoginViewController.m
//  SportsTracker
//
//  Created by Venelin Petkov on 2/6/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import "LoginViewController.h"
#import "FMDB.h"
#import "SQLStrings.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonLogin:(id)sender {
    int userExist = 0;
    NSString *selectUser =[NSString stringWithFormat: @"%@ WHERE username = \"%@\"", selectAllUsersSQL, self.fieldUsername.text];
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
                NSString *currentPassword = [result stringForColumn:@"Password"];
                if (currentPassword == self.fieldPassword.text) {
                    ++userExist;
                    //"UPDATE Person SET gender= '%@' WHERE name= '%@'",gender,name]
                    [db executeUpdate: @"UPDATE users SET isLogged= '%@' WHERE username = '%@'",@(1), self.fieldUsername.text];
                    NSLog(@"Username logged");
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UIAlertView"
                                                                    message:@"My message"
                                                                   delegate:self cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"OK", nil];
                    [alert show];
                    [alert awakeFromNib];
                }
            }
            
        }
    }
}
@end
