//
//  CTableViewCell_StoryBoard.h
//  FarmNow
//
//  Created by zheliang on 15/10/16.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTableViewCell_StoryBoardDelegate <NSObject>
@optional
- (void)doAction:(NSIndexPath*)indexPath tag:(NSInteger)tag data:(id)data;

@end
@interface CTableViewCell_StoryBoard : UITableViewCell
@property (nonatomic, assign) NSObject<CTableViewCell_StoryBoardDelegate>* delegate;
@property (nonatomic, retain) id cellData;
@property (nonatomic, copy) NSIndexPath* indexPath;

- (void)setData:(id)data;
- (void)doAction:(NSInteger)tag;
@end