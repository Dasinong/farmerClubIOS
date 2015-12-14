//
//  CSubScribeListController.m
//  FarmNow
//
//  Created by zheliang on 15/11/27.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CSubScribeListController.h"
#import "CGetSubScribeListsModel.h"
#import "CSubScribeDetailController.h"
#import "CDeleteSubScribeListModel.h"

@interface CSubScribeListController ()
@property (weak, nonatomic) IBOutlet UIButton *subScribeBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightItem;

@end

@implementation CSubScribeListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.subScribeBtn.layer.borderWidth = 1.f;
	self.subScribeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
	[self getSubScribeData];
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
- (void)getSubScribeData
{
	[CGetSubScribeListsModel requestWithParams:[CGetSubScribeListsParams new] completion:^(CGetSubScribeListsModel* model, JSONModelError *err) {
		if (model && err == nil) {
			if (model.data.count > 0) {
				__block UITableViewModel * tableModel = [UITableViewModel new];
				[model.data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
					NSDictionary* content = @{@"name":key, @"id":obj};
					[tableModel addRow:TABLEVIEW_ROW(@"subscribecell", content) forSection:0];

				}];
				[self updateModel:tableModel];
			}

		}
	}];
}
- (IBAction)rightItemCLick:(id)sender {
	if (self.tableView.editing == NO) {
		[self.tableView setEditing:YES];
		self.rightItem.title = @"完成";
	}
	else
	{
		[self.tableView setEditing:NO];
		self.rightItem.title = @"编辑";
	}
	
}

- (void)didSelect:(NSIndexPath *)indexPath identifier:(NSString *)identifier data:(id)data
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	CSubScribeDetailController* controller = [self.storyboard controllerWithID:@"CSubScribeDetailController"];
	controller.subscribeId = data[@"id"];
	[self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)creatClick:(id)sender {
	CSubScribeDetailController* controller = [self.storyboard controllerWithID:@"CSubScribeDetailController"];
	[self.navigationController pushViewController:controller animated:YES];
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}


-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		NSDictionary* content = [self.tableViewModel modelForRowAtIndexPath:indexPath].data;
		
		[self deleteRowsAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
		CDeleteSubScribeListParams* params = [CDeleteSubScribeListParams new];
		params.id = content[@"id"];
		[MBProgressHUD showHUDAddedTo:self.view animated:YES];
		
		[CDeleteSubScribeListModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
			[MBProgressHUD hideHUDForView:self.view animated:YES];
			if (model && err == nil) {
				[MBProgressHUD alert:@"删除成功"];
			}
		}];
	}
}


@end
