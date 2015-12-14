//
//  CUpdateProfileModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/7.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CUserObject.h"

@interface CUpdateProfileParams : CRequestBaseParams
@property (strong, nonatomic) NSString* username;	//用户名
@property (strong, nonatomic) NSString* cellphone;	//手机号
@property (strong, nonatomic) NSString* address;	//住址
@property (strong, nonatomic) NSString* telephone;	//电话

@end

@interface CUpdateProfileModel : CResponseModel

@property (strong, nonatomic ) CUserObject* data;

@end
