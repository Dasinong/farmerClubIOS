//
//  CRefappModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/7.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CRefappParams : CRequestBaseParams

@property (strong, nonatomic) NSString* cellPhones;	//多个手机号码以逗号分隔

@end

@interface CRefappModel : CResponseModel

@end
