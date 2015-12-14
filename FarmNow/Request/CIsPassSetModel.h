//
//  CIsPassSetModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/8.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CIsPassSetParams : CRequestBaseParams
@property (strong, nonatomic) NSString* cellphone;
@end

@interface CIsPassSetModel : CResponseModel

@property (assign, nonatomic) BOOL data;

@end
