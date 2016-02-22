//
//  CCropDetailViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCropDetailViewController.h"
#import "CWeatherSectionView.h"

@interface CCropDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CCropDetailViewController

- (IBAction)goToWiki:(id)sender {
    NSLog(@"goToWiki");
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 36;
    }
    
    return CGFLOAT_MIN;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section > 0) {
        NSArray *countNib = [[NSBundle mainBundle] loadNibNamed:@"CWeatherSectionView" owner:self options:nil];
        CWeatherSectionView* sectionView = [countNib objectAtIndex:0];
        
        NSString* title = @"ddd";
        [sectionView setTitle:title];
        
        return sectionView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 152;
        case 1:
            return 50;
        case 2:
            return 50;
        default:
            break;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        case 2:
            return 3;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
    }
    
    if (indexPath.section == 1) {
        return [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    }
    
    if (indexPath.section == 2) {
        return [tableView dequeueReusableCellWithIdentifier:@"DeseaseCell" forIndexPath:indexPath];
    }
    
    return nil;
}
@end
