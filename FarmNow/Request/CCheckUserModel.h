//
//  CCheckUserModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/7.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CCheckUserParams : CRequestBaseParams
@property (strong, nonatomic) NSString* cellphone;
@end

@interface CCheckUserModel : CResponseModel
@property (assign, nonatomic) BOOL data;

@end
