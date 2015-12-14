//
//  CWikiViewController.h
//  FarmNow
//
//  Created by zheliang on 15/10/20.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CTableViewController_StoryBoard.h"

@class CSeedContentItem;
@interface CWikiViewController : CTableViewController_StoryBoard
@property (assign, nonatomic) EType type;
@property (strong, nonatomic) CSeedContentItem* seedItem;

@end
