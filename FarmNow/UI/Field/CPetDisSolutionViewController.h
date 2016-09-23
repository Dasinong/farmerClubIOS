//
//  CPetDisSolutionViewController.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CBaseViewController.h"
#import "CPetSolution.h"

@interface CPetDisSolutionViewController : CBaseViewController
@property (nonatomic, strong) CPetSolution *solution;
@property (nonatomic, assign) NSInteger solutionIndex;
@end
