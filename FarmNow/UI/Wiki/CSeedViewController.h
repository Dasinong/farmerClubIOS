//
//  CSeedViewController.h
//  FarmNow
//
//  Created by zheliang on 15/10/15.
//  Copyright (c) 2015年 zheliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBaseViewController.h"
#import "CSortItemByFirstLetter.h"


@interface CSeedContentItem : NSObject <CSortItemByFirstLetterProtocol>

@property (strong, nonatomic) NSString* cropName;
@property (assign, nonatomic) NSInteger cropId;

@end
@interface CSeedViewController : CBaseViewController
@property (assign, nonatomic) EType type;
@end

