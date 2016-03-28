
//
//  CWinSafeDetailViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/28.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CWinSafeDetailViewController.h"

@interface CWinSafeDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CWinSafeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.winSafe.name;
    self.volumeLabel.text = self.winSafe.volume;
    self.countLabel.text = [NSString stringWithFormat:@"%d", (int)self.winSafe.count];
}

@end
