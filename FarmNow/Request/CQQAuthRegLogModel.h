//
//  CQQAuthRegLogModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/25.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CUserObject.h"

@interface CQQAuthRegLogParams : CRequestBaseParams
@property (strong, nonatomic) NSString* qqtoken;	//qq token
@property (strong, nonatomic) NSString* avater;		//用户头像
@property (strong, nonatomic) NSString* username;	//用户名字
@property (strong, nonatomic) NSString* channel;	//渠道号
@end

@interface CQQAuthRegLogModel : CResponseModel
@property (strong, nonatomic) CUserObject<Optional>* data;

@end
