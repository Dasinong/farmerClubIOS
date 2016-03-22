//
//  CRecommendController1.m
//  FarmNow
//
//  Created by zheliang on 15/11/7.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CRecommendController1.h"
#import "CPersonalCache.h"
#import "CSetRefModel.h"
#import "CRefappModel.h"

@interface CRecommendController1 ()
@property (weak, nonatomic) IBOutlet UIImageView *qrView;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@end

@implementation CRecommendController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	CUserObject* userInfo = [[CPersonalCache defaultPersonalCache] cacheUserInfo];
	if (userInfo) {
		self.codeLabel.text = [NSString stringWithFormat:@"或直接输入：%@",userInfo.refcode];
        [self.qrView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/pic/refCode/%d.png",kServer,(int)userInfo.userId]]];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
