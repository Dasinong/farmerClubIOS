//
//  CClaimCouponTableViewCell.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/15.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CClaimCouponTableViewCellDelegate <NSObject>
- (void)textFieldEndEditing:(UITextField *)textField;
@end

@interface CClaimCouponTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fieldLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField2;
@property (weak, nonatomic) IBOutlet UIButton *pickerButton;
@property (weak, nonatomic) IBOutlet UIView *separator;

@property (weak, nonatomic) id<CClaimCouponTableViewCellDelegate> delegate;
@end
