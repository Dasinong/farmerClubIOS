//
//  CStoreTableViewCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/15.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CStoreTableViewCell.h"
#import "CStore.h"

@interface CStoreTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *storePhoneLabel;

@end

@implementation CStoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupWithModel:(id)model {
    CStore *store = (CStore*)model;
    
    self.storeNameLabel.text = store.name;
    self.storeAddressLabel.text = store.location;
    self.storePhoneLabel.text = store.phone;
}
@end
