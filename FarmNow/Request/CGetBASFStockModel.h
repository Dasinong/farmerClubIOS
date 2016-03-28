//
//  CGetBASFStockModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/28.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CWinSafe.h"

@interface CGetBASFStockParams : CRequestBaseParams

@end

@interface CGetBASFStockModel : CResponseModel
@property (strong, nonatomic) NSArray<CWinSafe>* data;
@end
