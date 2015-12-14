//
//  CCPProductObject.h
//  FarmNow
//
//  Created by zheliang on 15/10/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CCPProductObject

@end
@interface CCPProductObject : CJSONModel
@property (assign, nonatomic) NSInteger  id;//农药Id
@property (strong, nonatomic) NSString   * activeIngredient;//农药有效成分
@property (strong, nonatomic) NSString   * name;//农药名称
@property (strong, nonatomic) NSString   * type;//农药类型
@property (strong, nonatomic) NSString   * crop;//关联的作物
@property (strong, nonatomic) NSString   * disease;//农药有效成分拼音
@property (strong, nonatomic) NSString   * volumn;//农药有效成分拼音
@property (strong, nonatomic) NSString   * method;//农药有效成分拼音
@property (strong, nonatomic) NSString   * guideline;//农药有效成分拼音
@property (strong, nonatomic) NSString   * registrationId;//农药有效成分拼音
@property (strong, nonatomic) NSString   * manufacturer;//农药有效成分拼音
@property (strong, nonatomic) NSString   * tip;//农药有效成分拼音

@end
