//
//  CSetRefModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/7.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CSetRefParams : CRequestBaseParams
@property (strong, nonatomic) NSString* refcode;

@end

@interface CSetRefModel : CResponseModel

@end
