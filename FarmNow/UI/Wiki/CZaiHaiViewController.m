//
//  CZaiHaiViewController.m
//  FarmNow
//
//  Created by zheliang on 15/10/23.
//  Copyright © 2015年 zheliang. All rights reserved.
//
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "CZaiHaiViewController.h"
#import "CSeedViewController.h"
#import "CBrowsePetDisSpecByCropIdAndTypeModel.h"
#import "CWebViewController.h"
#import "CPetDisListViewController.h"

@interface CZaiHaiViewController ()
@property (weak, nonatomic) IBOutlet HMSegmentedControl *segement;
@property (strong, nonatomic) NSArray* titles;
@end

@implementation CZaiHaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.titles = @[@"病害", @"虫害", @"草害"];
	self.title = self.seedItem.cropName;
	
//	DZNSegmentedControl *control = [[DZNSegmentedControl alloc] initWithItems:items];
	[self.segement setSectionTitles:self.titles];
	self.segement.selectionIndicatorColor = COLOR(0x2C9F27);
	self.segement.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
	self.segement.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
	self.segement.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segement.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
//	self.segement.delegate = self;
	self.segement.selectedSegmentIndex = self.selectedIndex;
	[self selectedSegment:self.segement];
	[self.segement addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectedSegment:(id)sender
{
	self.selectedIndex =self.segement.selectedSegmentIndex;
	NSString*  type = [self.titles objectAtIndex_s:self.segement.selectedSegmentIndex];
	CBrowsePetDisSpecByCropIdAndTypeParams* params = [CBrowsePetDisSpecByCropIdAndTypeParams new];
	params.type = type;
	params.cropId = self.seedItem.cropId;
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];

	[CBrowsePetDisSpecByCropIdAndTypeModel requestWithParams:params completion:^(CBrowsePetDisSpecByCropIdAndTypeModel* model, JSONModelError *err) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];

		if (err == nil) {
            UITableViewModel* talbeModel = [UITableViewModel new];
            for (CPetDisSpecBrowseObject* object in model.data) {
                [talbeModel addRow:TABLEVIEW_ROW(@"imagecell", object) forSection:0];
            }
            [self updateModel:talbeModel];
		}
	}];
	
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didSelect:(NSIndexPath *)indexPath identifier:(NSString*)identifier data:(id)data
{
    CPetDisSpecBrowseObject* object = (CPetDisSpecBrowseObject*)data;
    
    CPetDisListViewController *controller = [self.storyboard controllerWithID:@"CPetDisListViewController"];
    controller.id = object.petDisSpecId;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
