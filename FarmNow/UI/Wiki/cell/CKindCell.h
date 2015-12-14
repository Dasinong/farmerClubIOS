//
//  CKindCell.h
//  FarmNow
//
//  Created by zheliang on 15/10/20.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CTableViewCell_StoryBoard.h"

@interface CKindCell : CTableViewCell_StoryBoard
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end
