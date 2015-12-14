//
//  CUpdatePasswordModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/8.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CUpdatePasswordParams : CRequestBaseParams

@property (strong, nonatomic) NSString* oPassword;

@property (strong, nonatomic) NSString* nPassword;
@end

@interface CUpdatePasswordModel : CResponseModel

@end
