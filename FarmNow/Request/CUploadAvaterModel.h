//
//  CUploadAvaterModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CUploadAvaterParams : CRequestBaseParams

@end

@interface CUploadAvaterModel : CResponseModel
@property (nonatomic, strong) NSString *data;
@end
