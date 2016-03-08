//
//  CRecommendController2.m
//  FarmNow
//
//  Created by zheliang on 15/11/7.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CRecommendController2.h"
#import "CSetRefModel.h"
#import "MBProgressHUD+Express.h"
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>

@interface CRecommendController2 () <QRCodeReaderDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (strong, nonatomic) QRCodeReaderViewController* reader;
@end

@implementation CRecommendController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)doneClick:(id)sender {
	if (self.codeField.text == nil || self.codeField.text.length == 0) {
		[MBProgressHUD alert:@"请填写邀请码"];
		return;
	}
	CSetRefParams* params = [CSetRefParams new];
	params.refcode = self.codeField.text;
	[CSetRefModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
		if (model && err== nil) {
			[MBProgressHUD alert:@"发送成功"];
		}
    }];
}

- (IBAction)scan:(id)sender {
    [self presentViewController:self.reader animated:YES completion:NULL];
}

- (QRCodeReaderViewController *)reader {
    if (_reader == nil) {
        NSArray *types = @[AVMetadataObjectTypeQRCode];
        _reader = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];
        
        // Using delegate methods
        _reader.delegate = self;
    }
    
    return _reader;
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSInteger valid = 0; // function=refcode&code=123456都成立
        NSArray *paramArray = [result componentsSeparatedByString:@"&"];
        
        NSString *code = nil;
        if (paramArray.count >= 2) {
            for (NSString *keyValue in paramArray) {
                NSArray *keyValueArray = [keyValue componentsSeparatedByString:@"="];
                if (keyValueArray.count == 2) {
                    NSString *key = keyValueArray[0];
                    NSString *value = keyValueArray[1];
                    
                    if ([[key lowercaseString] isEqualToString:@"function"] && [[value lowercaseString] isEqualToString:@"refcode"]) {
                        valid++;
                        continue;
                    }
                    
                    if ([[key lowercaseString] isEqualToString:@"code"]) {
                        if (value.length > 0) {
                            code = value;
                            valid++;
                        }
                        continue;
                    }
                }
            }
        }
        
        if (valid >= 2) {
           self.codeField.text = code;
        }
        else {
            [MBProgressHUD alert:@"非法的二维码"];
        }
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
