//
//  CWikiViewController.m
//  FarmNow
//
//  Created by zheliang on 15/10/20.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWikiViewController.h"
#import "CSeedViewController.h"
#import "CCpproductController.h"
#import "CKindViewController.h"
#import "CSearchWordModel.h"
#import "CSearchSectionView.h"
#import "CWebViewController.h"
#import "CZaiHaiViewController.h"
#import "CUserObject.h"
#import "CPersonalCache.h"
#import "CCpproductDetailController.h"

#define TYPE_DIC @{@"variety":@"品种",\
					@"disease":@"病害",\
					@"pest":@"虫害",\
					@"cpproduct":@"农药"}

#define ICON_DIC @{@"variety":@"weed.png",\
					@"disease":@"binghai.png",\
					@"pest":@"pest.png",\
					@"cpproduct":@"product.png"}
@interface CWikiViewController () <UISearchBarDelegate>

@property (strong, nonatomic) NSDictionary* searchResult;

//variety;		//品种
//disease;		//病害
//pest;			//虫害
//cpproduct;	//农药

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchbarHeight;

@end

@implementation CWikiViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		self.type = eWiki;
	}
	return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.searchDisplayController.searchResultsTableView.rowHeight = UITableViewAutomaticDimension;
	self.searchDisplayController.searchResultsTableView.estimatedRowHeight = 44.0;
	
	NSArray* contents = nil;
	if (self.type == eChongHai) {
		self.searchbarHeight.constant = 0;
		self.searchBar.placeholder = @"搜索病虫草害";

		contents = @[@{@"icon":@"binghai",
					   @"title":[NSString stringWithFormat:@"%@常见病害",self.seedItem.cropName],
					   @"sub":@"认识各种疾病"},
					 @{@"icon":@"pest",
					   @"title":[NSString stringWithFormat:@"%@常见虫害",self.seedItem.cropName],
					   @"sub":@"认识各种害虫"},
					 @{@"icon":@"weed",
					   @"title":[NSString stringWithFormat:@"%@常见草害",self.seedItem.cropName],
					   @"sub":@"认识各种杂草"}];

	}
	else{
		self.searchBar.placeholder = @"搜索种子、病虫草害、药物信息";
        
        if ([USER isBASF]) {
            contents = @[@{@"icon":@"pinzhong",
                           @"title":@"品种大全",
                           @"sub":@"找到最适合您的优良品种"},
                         @{@"icon":@"nongyao",
                           @"title":@"农药大全",
                           @"sub":@"上万种农药和使用方法"},
                         @{@"icon":@"chonghai",
                           @"title":@"病虫草害大全",
                           @"sub":@"植物保护的必备大全"},
                         @{@"icon":@"basf",
                           @"title":@"巴斯夫产品介绍",
                           @"sub":@"巴斯夫产品介绍"},
                         @{@"icon":@"zhishi",
                           @"title":@"农业气象小常识",
                           @"sub":@"更好利用气象数据指导种植"},
                         @{@"icon":@"cetu",
                           @"title":@"测土配方必读",
                           @"sub":@"了解土地才能科学施肥"},];
        }
        else {
            contents = @[@{@"icon":@"pinzhong",
                           @"title":@"品种大全",
                           @"sub":@"找到最适合您的优良品种"},
                         @{@"icon":@"nongyao",
                           @"title":@"农药大全",
                           @"sub":@"上万种农药和使用方法"},
                         @{@"icon":@"chonghai",
                           @"title":@"病虫草害大全",
                           @"sub":@"植物保护的必备大全"},
                         @{@"icon":@"zhishi",
                           @"title":@"农业气象小常识",
                           @"sub":@"更好利用气象数据指导种植"},
                         @{@"icon":@"cetu",
                           @"title":@"测土配方必读",
                           @"sub":@"了解土地才能科学施肥"},];
        }

	}
	UITableViewModel* tableModel = [UITableViewModel new];
	for (NSDictionary* dict in contents) {
		[tableModel addRow:TABLEVIEW_ROW(@"cell", dict) forSection:0];
	}
	
	[self updateModel:tableModel];
	
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if ([delegate.jumpState isEqualToString:@"wiki"]) {
        CCpproductController* controller = [self.storyboard controllerWithID:@"CCpproductController"];
        controller.isBASF = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    delegate.jumpState = nil;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUDForView:self.view animated:NO];
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
	if (self.type == eWiki) {
		if (indexPath.row == 0) {
			CSeedViewController* controller = [self.storyboard controllerWithID:@"CSeedViewController"];
			controller.type = ePinZhong;
			[self.navigationController pushViewController:controller animated:YES];
		}
		else if (indexPath.row == 1)
		{
			CCpproductController* controller = [self.storyboard controllerWithID:@"CCpproductController"];
			[self.navigationController pushViewController:controller animated:YES];
		}
		else if (indexPath.row == 2){
			CSeedViewController* controller = [self.storyboard controllerWithID:@"CSeedViewController"];
			controller.type = eChongHai;
			[self.navigationController pushViewController:controller animated:YES];
		}
        else {
            NSInteger row = indexPath.row;
            if (![USER isBASF]) {
                row++;
            }
            
            if (row == 3){
                CCpproductController* controller = [self.storyboard controllerWithID:@"CCpproductController"];
                controller.isBASF = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
            else if (row == 4){
                CKindViewController* controller = [self.storyboard controllerWithID:@"CKindViewController"];
                controller.title = @"农业气象小常识";
                controller.type = eXiaoChangShi;
                [self.navigationController pushViewController:controller animated:YES];
            }
            else if (row == 5){
                CKindViewController* controller = [self.storyboard controllerWithID:@"CKindViewController"];
                controller.title = @"测土配方必读";
                controller.type = eSoil;
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
	}
	else{
		switch (indexPath.row) {
			case 0:
			case 1:
			case 2:
			{
				CZaiHaiViewController* controller = [self.storyboard controllerWithID:@"CZaiHaiViewController"];
				controller.seedItem = self.seedItem;
				controller.selectedIndex = indexPath.row;
				[self.navigationController pushViewController:controller animated:YES];
			}
    break;
				case 3:
			{
				
			}
				break;
			default:
    break;
		}
		
	}
}

#pragma UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	NSString* searchWord = searchBar.text;
	if (searchWord && searchWord.length > 0) {

	[self search:searchWord];
	}
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                   // called when keyboard search button pressed
{
	NSString* searchWord = searchBar.text;
	if (searchWord && searchWord.length > 0) {

	[self search:searchWord];
	}
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	self.searchResult = nil;
	
}
- (void)search:(NSString*)key
{
	if (self.type == eWiki) {
		CSearchAllWordParams* params = [CSearchAllWordParams new];
		params.key = key;
		//	params.type =
		[MBProgressHUD showHUDAddedTo:self.view animated:YES];

		[CSearchAllWordModel requestWithParams:params completion:^(CSearchAllWordModel* model, JSONModelError *err) {
			[MBProgressHUD hideHUDForView:self.view animated:NO];

			if (err == nil && model) {
				NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithCapacity:0x1];
				if (model.variety.count > 0) {
					[dic setObject:model.variety forKey:@"variety"];
				}
				if (model.disease.count > 0) {
					[dic setObject:model.disease forKey:@"disease"];
				}
				if (model.pest.count > 0) {
					[dic setObject:model.pest forKey:@"pest"];
				}
				if (model.cpproduct.count > 0) {
					[dic setObject:model.cpproduct forKey:@"cpproduct"];
				}
				self.searchResult = dic;
				[self.searchDisplayController.searchResultsTableView reloadData];
                
                // 搜不到，去百度
                if (model.variety.count + model.disease.count + model.pest.count + model.cpproduct.count == 0) {
                    CWebViewController* webController = [self.storyboard controllerWithID:@"CWebViewController"];
                    webController.address = [NSString stringWithFormat:@"https://www.baidu.com/s?wd=%@", [key URLEncodedString]];
                    webController.title = @"百度搜索";
                    [self.navigationController pushViewController:webController animated:YES];
                }
			}
		}];

	}
	else if (self.type == eChongHai)
	{
		[MBProgressHUD showHUDAddedTo:self.view animated:YES];

		CSearchSingleWordParams* params = [CSearchSingleWordParams new];
		params.key = key;
		params.type = @"petdisspec";
		
		[CSearchSingleWordModel requestWithParams:params completion:^(CSearchSingleWordModel* model, JSONModelError *err) {
			[MBProgressHUD hideHUDForView:self.view animated:NO];

			if (err == nil && model) {
				
				self.searchResult = @{params.type:model.data};
				[self.searchDisplayController.searchResultsTableView reloadData];
			}
		}];
	}
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (tableView == self.tableView) {
		return 0;
	}
	else
	{
		if (self.type == eWiki) {
			return 44.f;
		}
		else{
			return 0;
		}
	}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (tableView == self.tableView) {
		return [super tableView:tableView viewForHeaderInSection:section];
	}
	else
	{
		
		NSArray *countNib = [[NSBundle mainBundle] loadNibNamed:@"searchSectionView" owner:self options:nil];
		CSearchSectionView* sectionView = [countNib objectAtIndex:0];
		
		
		NSString* type =[[self.searchResult allKeys] objectAtIndex_s:section];
		if (type) {
			sectionView.title.text = TYPE_DIC[type];
			sectionView.imageView.image = IMAGE(ICON_DIC[type]);
		}
	
		return sectionView;
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
        
        //NSLog(@"%@",entry.type);
        
        CCpproductDetailController *controller = [self.storyboard controllerWithID:@"CCpproductDetailController"];
        controller.type = entry.type;
        controller.id = entry.id;
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
	}
}
@end
