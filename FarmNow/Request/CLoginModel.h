//
//  CLoginModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/8.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CUserObject.h"

@interface CLoginParams : CRequestBaseParams

@property (strong, nonatomic) NSString* password;
@property (strong, nonatomic) NSString* cellphone;
@property (strong, nonatomic) NSString* appId;

@end

@interface CLoginModel : CResponseModel
@property (strong, nonatomic) CUserObject* data;

@end
