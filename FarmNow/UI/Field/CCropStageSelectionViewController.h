//
//  CCropStageSelectionViewController.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CBaseViewController.h"

@interface CCropStageSelectionViewController : CBaseViewController
@property (nonatomic, assign) NSInteger cropId;
@property (nonatomic, assign) double area;
@property (nonatomic, assign) NSNumber *locationId;
@property (nonatomic, strong) NSString *fieldName;
@property (nonatomic, assign) NSInteger currentStageId;

@property (nonatomic, strong) NSString *cropName;
@property (nonatomic, strong) NSString *cunName;
@end
