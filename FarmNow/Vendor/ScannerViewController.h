//
//  ViewController.h
//  iOS7_BarcodeScanner
//
//  Created by Jake Widmer on 11/16/13.
//  Copyright (c) 2013 Jake Widmer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScannerViewControllerDelegate <NSObject>
- (void)scanned:(NSString *)scanned;
@end

@interface ScannerViewController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) NSMutableArray * allowedBarcodeTypes;
@property (nonatomic, weak) id<ScannerViewControllerDelegate> delegate;
@end
