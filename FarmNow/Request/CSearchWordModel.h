//
//  CSearchWordModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/27.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CSearchEntry.h"

@interface CSearchAllWordParams : CRequestBaseParams
@property (strong, nonatomic) NSString* key;	//搜索关键字

@end

@interface CSearchAllWordModel : CResponseModel
@property (strong, nonatomic) NSArray<CSearchEntry, Optional>* cpproduct;
@property (strong, nonatomic) NSArray<CSearchEntry, Optional>* disease;
@property (strong, nonatomic) NSArray<CSearchEntry, Optional>* pest;
@property (strong, nonatomic) NSArray<CSearchEntry, Optional>* variety;

@end

@interface CSearchSingleWordParams : CRequestBaseParams
@property (strong, nonatomic) NSString* key;	//搜索关键字
@property (strong, nonatomic) NSString* type;	//要搜索的百科类别

@end
@interface CSearchSingleWordModel : CResponseModel
@property (strong, nonatomic) NSArray<CSearchEntry, Optional>* data;

@end