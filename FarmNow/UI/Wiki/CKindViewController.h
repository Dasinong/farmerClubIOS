//
//  CKindViewController.h
//  FarmNow
//
//  Created by zheliang on 15/10/22.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CTableViewController_StoryBoard.h"

@class CSeedContentItem;
@interface CKindViewController : CTableViewController_StoryBoard
@property (strong, nonatomic) CSeedContentItem* seedItem;
@property (assign, nonatomic) EType type;
@end
