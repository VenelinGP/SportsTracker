//
//  Users.m
//  SportsTracker
//
//  Created by Venelin Petkov on 2/6/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

#import "User.h"

@implementation User

int *_age;
int *_isLogged;

-(instancetype)initName: (NSString *)username
               password: (NSString *)password
               fullName: (NSString *)fullname
              imageName: (NSString *)imageName
                address: (NSString *)address
                  email: (NSString *)email
                    age: (int)age
            andIsLogged: (int)isLogged
{
    self = [super init];
    if (self) {
        self.username = username;
        self.password = password;
        self.fullName = fullname;
        self.imageName = imageName;
        self.address = address;
        self.email = email;
        self.age = age;
        self.isLogged = isLogged;
    }
    return self;
}
;

+(User*)userName: (NSString *)username
        password: (NSString *)password
        fullName: (NSString *)fullname
       imageName: (NSString *)imageName
         address: (NSString *)address
           email: (NSString *)email
             age: (int)age
     andIsLogged: (int)isLogged{
    return [[User alloc] initName:username
                         password:password
                         fullName:fullname
                        imageName:imageName
                          address:address
                            email:email
                              age:age
                      andIsLogged:isLogged];
};

@end
