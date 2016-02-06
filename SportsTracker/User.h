//
//  Users.h
//  SportsTracker
//
//  Created by Venelin Petkov on 2/6/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong,nonatomic) NSString *password;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *email;
@property int age;
@property int isLogged;

-(instancetype)initName: (NSString *)username
               password: (NSString *)password
               fullName: (NSString *)fullname
              imageName: (NSString *)imageName
                address: (NSString *)address
                  email: (NSString *)email
                    age: (int)age
            andIsLogged: (int)isLogged;

+(User *) userName: (NSString *)username
          password: (NSString *)password
          fullName: (NSString *)fullname
         imageName: (NSString *)imageName
           address: (NSString *)address
             email: (NSString *)email
               age: (int)age
       andIsLogged: (int)isLogged;

@end
