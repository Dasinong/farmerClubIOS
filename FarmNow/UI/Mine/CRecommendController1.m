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
#import <ZXingObjC.h>

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
        
//        NSString *urlString = [NSString stringWithFormat:@"%@/pic/refCode/%d.png",kServer,(int)userInfo.userId];
//        [self.qrView sd_setImageWithURL:[NSURL URLWithString:urlString]];
        
        ZXEncodeHints *hints = [ZXEncodeHints hints];
        hints.encoding = NSUTF8StringEncoding;
        ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
        NSString *string = [NSString stringWithFormat:@"function=refcode&code=%@", userInfo.refcode];
        
        NSError *error = nil;
        ZXBitMatrix* result = [writer encode:string format:kBarcodeFormatQRCode width:self.qrView.width * 3 height:self.qrView.height * 3 hints:hints error:&error];
        // 设置编码类型 hints.errorCorrectionLevel = [ZXErrorCorrectionLevel
        
        if (result) {
            CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
            self.qrView.image =  [UIImage imageWithCGImage: image];
            // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
        }
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
