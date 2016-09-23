//
//  CRemoteControModel.h
//  FarmNow
//
//  Created by zheliang on 15/12/15.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CRemoteControParams : CRequestBaseParams

@property (nonatomic, strong) NSString* appId;// /gatekeepers
@property (nonatomic, strong) NSString* version;// /gatekeepers

@end

@interface CRemoteControModel : CResponseModel

@property (nonatomic, assign) BOOL qqLogin;
@property (nonatomic, assign) BOOL weixinLogin;

@end
