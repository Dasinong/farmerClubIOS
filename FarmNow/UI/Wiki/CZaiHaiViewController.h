//
//  CZaiHaiViewController.h
//  FarmNow
//
//  Created by zheliang on 15/10/23.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CTableViewController_StoryBoard.h"

@class CSeedContentItem;

@interface CZaiHaiViewController : CTableViewController_StoryBoard
@property (strong, nonatomic) CSeedContentItem* seedItem;
@property (assign, nonatomic) NSInteger selectedIndex;
@end
