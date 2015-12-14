//
//  CBrowsePetDisSpecByCropIdAndTypeModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/23.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CPetDisSpecBrowseObject.h"

@interface CBrowsePetDisSpecByCropIdAndTypeParams : CRequestBaseParams
@property (assign, nonatomic) NSInteger cropId;
@property (strong, nonatomic) NSString* type;

@end

@interface CBrowsePetDisSpecByCropIdAndTypeModel : CResponseModel
@property (strong, nonatomic) NSArray<CPetDisSpecBrowseObject, Optional>* data;

@end
