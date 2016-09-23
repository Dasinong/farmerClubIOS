//
//  CGetFieldModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CField.h"

@interface CGetFieldParam : CRequestBaseParams
@property (nonatomic, assign) NSInteger id;
@end

@interface CGetFieldModel : CResponseModel
@property (nonatomic, strong) CField *field;
@end
