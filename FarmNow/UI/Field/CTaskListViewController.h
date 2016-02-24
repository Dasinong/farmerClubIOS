//
//  CTaskListViewController.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CDataRequestViewController.h"
#import "CTaskSpec.h"

@interface CTaskListViewController : CDataRequestViewController
@property (nonatomic, strong) CTaskSpec *taskSpec;
@end
