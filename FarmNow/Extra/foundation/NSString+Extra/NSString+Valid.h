//
//  NSString+Valid.h
//  HomeService
//
//  Created by pre-team on 14-5-27.
//  Copyright (c) 2014年 pre-team. All rights reserved.
//

#import <Foundation/Foundation.h>

 
@interface  NSString (REGEXP)
+ (BOOL)validateEmail:(NSString*)email;
+ (BOOL)validateMobile:(NSString*)mobile;
+ (BOOL)validateCarNo:(NSString*)carNo;
+ (BOOL)validateCarType:(NSString*)CarType;
+ (BOOL)validateUserName:(NSString*)name;
+ (BOOL)validatePassword:(NSString*)passWord;
+ (BOOL)validateNickname:(NSString*)nickname;
+ (BOOL)validateIdentityCard:(NSString*)identityCard;
@end