//
//  CAddCropViewController.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CBaseViewController.h"

@protocol CAddCropViewControllerDelegate <NSObject>
- (void)addCropCompelted;
@end

@interface CAddCropViewController : CBaseViewController
@property (nonatomic, weak) id<CAddCropViewControllerDelegate> delegate;
@end
