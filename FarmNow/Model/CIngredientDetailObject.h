//
//  CIngredientDetailObject.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/29.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CIngredientDetailObject
@end

@interface CIngredientDetailObject : CJSONModel
@property (nonatomic, strong) NSArray *activeIngredient;
@property (nonatomic, strong) NSArray *activeIngredientUsage;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *feature;
@property (nonatomic, strong) NSString *guideline;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *manufacturer;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *pictures;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, strong) NSString *registrationId;
@property (nonatomic, strong) NSString *slogan;
@property (nonatomic, strong) NSString *specification;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *tip;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *instructions;
@end
