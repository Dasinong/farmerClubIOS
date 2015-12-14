//
//  CWeiXinAuthRegLogModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/26.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CUserObject.h"

@interface CWeiXinAuthRegLogParams : CRequestBaseParams
@property (strong, nonatomic) NSString* weixintoken;
@property (strong, nonatomic) NSString* avater;
@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* channel;
@property (strong, nonatomic) NSString* institutionId;


@end

@interface CWeiXinAuthRegLogModel : CResponseModel

@property (strong, nonatomic) CUserObject<Optional>* data;

@end
