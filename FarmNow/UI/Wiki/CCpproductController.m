//
//  CCpproductController.m
//  FarmNow
//
//  Created by zheliang on 15/10/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CCpproductController.h"
#import "CKindViewController.h"
#import "CSearchWordModel.h"
#import "CWebViewController.h"

@interface CCpproductController ()
@property (strong, nonatomic) NSArray* items;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchbarDisplayController;
@property (strong, nonatomic) NSDictionary* searchResult;

@end

@implementation CCpproductController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.items = @[@{@"title":@"杀菌剂",
					 @"sub":@"治疗细菌、真菌等菌类疾病"},
				   @{@"title":@"杀虫剂",
					 @"sub":@"治疗害虫的药物"},
				   @{@"title":@"除草剂",
					 @"sub":@"消除杂草的药物"},
				   @{@"title":@"植物生长调节剂",
					 @"sub":@"抑制剂等药物"},
				   @{@"title":@"杀螨剂",
					 @"sub":@"治疗螨虫类疾病的药物"}];
	UITableViewModel* model = [UITableViewModel new];
	for (NSDictionary* dict in self.items) {
		[model addRow:TABLEVIEW_ROW(@"kindcell", dict) forSection:0];
	}
	[self updateModel:model];
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

- (void)didSelect:(NSIndexPath *)indexPath identifier:(NSString*)identifier data:(id)data
{
	CKindViewController* controller = [self.storyboard controllerWithID:@"CKindViewController"];
	NSString* title = [[self.items objectAtIndex_s:indexPath.row] valueForKey:@"title"];
	controller.type = eIngredient;
	controller.title = title;
	[self.navigationController pushViewController:controller animated:YES];
}

#pragma UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	NSString* searchWord = searchBar.text;
	[self search:searchWord];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                   // called when keyboard search button pressed
{
	NSString* searchWord = searchBar.text;
	[self search:searchWord];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	self.searchResult = nil;
	
}
- (void)search:(NSString*)key
{
	
		
		CSearchSingleWordParams* params = [CSearchSingleWordParams new];
		params.key = key;
		params.type = @"petdisspec";
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];

		[CSearchSingleWordModel requestWithParams:params completion:^(CSearchSingleWordModel* model, JSONModelError *err) {
			[MBProgressHUD hideHUDForView:self.view animated:YES];

			if (err == nil && model) {
				
				self.searchResult = @{params.type:model.data};
				[self.searchDisplayController.searchResultsTableView reloadData];
			}
		}];
}

#pragma UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.tableView) {
		return [super tableView:tableView heightForRowAtIndexPath:indexPath];
	}
	else{
		return UITableViewAutomaticDimension;
		
	}
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if (tableView == self.tableView) {
		return [super numberOfSectionsInTableView:tableView];
	}
	else{
		return self.searchResult.count;
		
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (tableView == self.tableView) {
		return [super tableView:tableView numberOfRowsInSection:section];
	}
	else
	{
		NSArray* values = [self.searchResult.allValues objectAtIndex_s:section];
		
		return values.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.tableView) {
		return [super tableView:tableView cellForRowAtIndexPath:indexPath];
	}
	else{
		NSString              *identifier = @"searchcell";
		UITableViewCell       *cell       = [self.tableView dequeueReusableCellWithIdentifier:identifier];
		
		//    if (!cell)
		//    {
		//        Error(@"cell for %@ is nil", identifier);
		//    }
		if ([cell isKindOfClass:[CTableViewCell_StoryBoard class]]) {
			((CTableViewCell_StoryBoard*)cell).delegate = self;
			NSArray* values = [self.searchResult.allValues objectAtIndex_s:indexPath.section];
			CSearchEntry* entry = [values objectAtIndex_s:indexPath.row];
			[((CTableViewCell_StoryBoard*)cell) setData:entry];
		}
		//		if (indexPath.row) {
		//			<#statements#>
		//		}
		//		[self configureCell:cell data:[rowModel data] indexPath:indexPath];
		[cell setNeedsUpdateConstraints];
		[cell updateConstraintsIfNeeded];
		return cell;
	}
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.tableView) {
		return [super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
	else{
		NSArray* values = [self.searchResult.allValues objectAtIndex_s:indexPath.section];
		CSearchEntry* entry = [values objectAtIndex_s:indexPath.row];
		CWebViewController* webController       = [self.storyboard controllerWithID:@"CWebViewController"];
		webController.address                       = [NSString stringWithFormat:@"%@baike?id=%ld&type=%@",kServerAddress, (long)entry.id,entry.type];
		webController.title                     = entry.name;
		[self.navigationController pushViewController:webController animated:YES];
	}
}

@end