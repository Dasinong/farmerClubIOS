//
//  CSetUserTypeModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CSetUserTypeParams : CRequestBaseParams
@property (strong, nonatomic) NSString* type;
@end

@interface CSetUserTypeModel : CResponseModel

@end
