//
//  CDeleteSubScribeListModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/27.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CDeleteSubScribeListParams : CRequestBaseParams
@property (strong, nonatomic) NSNumber *id;			//subscription的Id

@end

@interface CDeleteSubScribeListModel : CResponseModel

@end
