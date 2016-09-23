//
//  CAuthRegLogModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/11.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CUserObject.h"

@interface CAuthRegLogParams : CRequestBaseParams

@property (strong, nonatomic) NSString* cellphone;
@property (strong, nonatomic) NSString* channel;	//渠道号
@property (strong, nonatomic) NSString* appId;	// appId

@end

@interface CAuthRegLogModel : CResponseModel
@property (strong, nonatomic) CUserObject<Optional>* data;

@end
