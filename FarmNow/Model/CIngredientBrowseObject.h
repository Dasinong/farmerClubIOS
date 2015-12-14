//
//  CIngredientBrowseObject.h
//  FarmNow
//
//  Created by zheliang on 15/10/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CIngredientBrowseObject

@end

@interface CIngredientBrowseObject : CJSONModel
@property (strong, nonatomic) NSString  * model;				//农药大类
@property (strong, nonatomic) NSString  * activeIngredient;		//农药有效成分
@property (strong, nonatomic) NSString  * activeIngredientPY;	//农药有效成分拼音
@property (assign, nonatomic) NSInteger cPProductId;			//农药Id

@end
