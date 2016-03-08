//
//  CPetDisCell.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPetDisSpec.h"

@protocol CPetDisCellDelegate <NSObject>
- (void)petSolutionClicked:(CPetDisSpec*)petDisSpec;
@end

@interface CPetDisCell : UITableViewCell
@property (nonatomic, weak) id<CPetDisCellDelegate> delegate;
- (void)setupWithModel:(id)model;
@end
