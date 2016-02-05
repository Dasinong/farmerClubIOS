//
//  CSeedViewController.m
//  FarmNow
//
//  Created by zheliang on 15/10/15.
//  Copyright (c) 2015年 zheliang. All rights reserved.
//

#import <FMDB/FMDB.h>
#import "CSeedViewController.h"
#import "CKindCell.h"
#import "CKindViewController.h"
#import "CWikiViewController.h"
#import "CSearchWordModel.h"
#import "CWebViewController.h"
#import "RGIndexView.h"
#import "CSortItemByFirstLetter.h"

@implementation CSeedContentItem
- (NSString*)getSortString
{
	return self.cropName;
}


@end
@interface CSeedViewController () <UITableViewDelegate, UITableViewDataSource, CTableViewCell_StoryBoardDelegate, RGIndexViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UITableView *righttable;
@property (strong, nonatomic) NSArray* kinds;
@property (strong, nonatomic) NSArray* contents;

@property (strong, nonatomic) NSString* currentKindName;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDispalyController;
@property (strong, nonatomic) NSDictionary* searchResult;
@property (weak, nonatomic) IBOutlet RGIndexView *indexView;
@property (retain, nonatomic)    NSArray* sectionTitles;
@property (retain, nonatomic)    CSortItemByFirstLetter* sortArrayItem;

@end

@implementation CSeedViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.leftTable.rowHeight = UITableViewAutomaticDimension;
	self.leftTable.estimatedRowHeight = 44.0;
	self.kinds = @[@{@"icon":@"liangshizuowu",
					 @"title":@"粮食作物",
					 @"type":@"粮食作物"},
				   @{@"icon":@"jingjizuowu",
					 @"title":@"经济作物",
					 @"type":@"经济作物"},
				   @{@"icon":@"shucai",
					 @"title":@"蔬菜",
					 @"type":@"蔬菜"},
				   @{@"icon":@"shuiguo",
					 @"title":@"水果",
					 @"type":@"水果"},
				   @{@"icon":@"junlei",
					 @"title":@"菌类",
					 @"type":@"菌类"},
				   @{@"icon":@"jianguo",
					 @"title":@"坚果",
					 @"type":@"坚果类"},
				   @{@"icon":@"huahui",
					 @"title":@"花卉",
					 @"type":@"花卉"},
				   @{@"icon":@"mucao",
					 @"title":@"牧草",
					 @"type":@"牧草"},
				   @{@"icon":@"yaocai",
					 @"title":@"药材",
					 @"type":@"药材"}];
	
	self.currentKindName = self.kinds[0][@"type"];
	[self initTableViewIndexView];

	self.contents = [self getContentsWithKindName:self.currentKindName];
	[self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];

	if (self.type == ePinZhong) {
		self.searchBar.placeholder = @"搜索种子信息";
	}
	else
	{
		self.searchBar.placeholder = @"搜索病虫草害信息";

	}
}

- (void)viewDidUnload {
	[super viewDidUnload];
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
//{
//	return [_dataModel numberOfSections ];
//}
- (void)initTableViewIndexView {
	
	self.indexView.backgroundColor = [UIColor clearColor];
	self.indexView.textColor = COLOR(0x737373);
	self.indexView.font = [UIFont systemFontOfSize:12];
	
	self.indexView.delegate = self;
	self.indexView.hidden = YES;
	[self.indexView reloadIndex];
	
}

- (NSArray*)getContentsWithKindName:(NSString*)kindName
{
	NSString *newPath=[[NSBundle mainBundle] pathForResource:@"dns" ofType:@"db"];

	FMDatabase* database = [FMDatabase databaseWithPath:newPath];
	if (![database open]) {
		return nil;
	}
	NSString* queryString = [NSString stringWithFormat:@"SELECT * FROM \"crop\" WHERE type = \"%@\"",kindName];
	FMResultSet *s = [database executeQuery:queryString];
	NSMutableArray* contents = [NSMutableArray arrayWithCapacity:0x1];
	while ([s next]) {
		CSeedContentItem* item = [CSeedContentItem new];
		item.cropName = [s stringForColumn:@"cropName"];
		item.cropId =  [s intForColumn:@"cropId"];
		[contents addObject_s:item];
		
	}
	[database close];
	[self sortData:contents];

	return contents;
}

- (void) sortData:(NSArray*)attentions
{
	self.sortArrayItem = [[CSortItemByFirstLetter alloc] initWithItems:attentions];
	//        self.stockSporkers = sortItem[kStockSporkerKey];
	BOOL hasContent = [self.sortArrayItem.keys count] && YES;
	if (hasContent) {

		self.indexView.hidden = NO;
		
		[self.indexView reloadIndex];
	}
	
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if (tableView == self.leftTable) {
		return 1;
	}
	else if (tableView == self.righttable)
	{
		if (self.sortArrayItem.keys.count > 0) {
			return self.sortArrayItem.keys.count;
		}
	}
	return 1;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
	if (tableView == self.leftTable) {
		return [self.kinds count];
	}
	else if (tableView == self.righttable)
	{
		NSArray* keys = self.sortArrayItem.keys;
		NSString* key = [keys objectAtIndex_s:section];
		NSDictionary* items = self.sortArrayItem.itemsBySort;
		if (key) {
			NSArray* rows = items[key];
			return rows.count;
		}
		return 0;
	}
	
    if (self.searchResult.count == 0) {
        return 0;
    }
    else {
        return [self.searchResult[self.searchResult.allKeys[0]] count];
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	UITableViewCell       *cell = nil;
	if (tableView == self.leftTable) {
		CKindCell* kindCell       = [self.leftTable dequeueReusableCellWithIdentifier:@"kindcell"];
		NSUInteger row = indexPath.row;
		if (row < self.kinds.count) {
			kindCell.iconImage.image = [UIImage image_s:self.kinds[row][@"icon"]];
			kindCell.title.text = self.kinds[row][@"title"];

		}
		cell = kindCell;


	}
	else if (tableView == self.righttable)
	{
		NSArray* keys = self.sortArrayItem.keys;
		NSString* key = [keys objectAtIndex_s:indexPath.section];
		NSDictionary* items = self.sortArrayItem.itemsBySort;

		if (key) {
			NSArray* rows = items[key];
			CSeedContentItem* item = [rows objectAtIndex:indexPath.row];
			cell       = [self.righttable dequeueReusableCellWithIdentifier:@"contentcell"];
			NSUInteger row = indexPath.row;
			if (row < rows.count) {
				cell.textLabel.text = item.cropName;
			}
		}

	}
	else
	{
		NSString              *identifier = @"searchcell";
		cell       = [self.righttable dequeueReusableCellWithIdentifier:identifier];
		
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
	}

	[cell setNeedsUpdateConstraints];
	[cell updateConstraintsIfNeeded];
	return cell;
} /* tableView */

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
	if (tableView ==  self.righttable) {
		return  55.f;
	}
	else if (tableView == self.leftTable)
	{
		return UITableViewAutomaticDimension;
	}
    
    return 75;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.leftTable) {
		NSUInteger row = indexPath.row;
		if (row < self.kinds.count) {
			self.currentKindName = self.kinds[row][@"type"];
			self.contents = [self getContentsWithKindName:self.currentKindName];
			[self.righttable reloadData];
		}
	}
	else if (tableView == self.righttable)
	{
		[tableView deselectRowAtIndexPath:indexPath animated:YES];

		NSUInteger row = indexPath.row;
		if (row < self.contents.count) {
			NSArray* keys = self.sortArrayItem.keys;
			NSString* key = [keys objectAtIndex_s:indexPath.section];
			NSDictionary* items = self.sortArrayItem.itemsBySort;
			
			if (key) {
				NSArray* rows = items[key];
				CSeedContentItem* item = [rows objectAtIndex:indexPath.row];
				if (self.type == ePinZhong) {
					CKindViewController* controller = [self.storyboard controllerWithID:@"CKindViewController"];
					controller.seedItem = item;
					controller.type = ePinZhong;
					[self.navigationController pushViewController:controller animated:YES];
				}
				else if (self.type == eChongHai)
				{
					CWikiViewController* controller = [self.storyboard controllerWithID:@"CWikiViewController"];
					controller.seedItem = item;
					controller.type = eChongHai;
					[self.navigationController pushViewController:controller animated:YES];
				}
			}

		}
	}
	else
	{
		NSArray* values = [self.searchResult.allValues objectAtIndex_s:indexPath.section];
		CSearchEntry* entry = [values objectAtIndex_s:indexPath.row];
		CWebViewController* webController       = [self.storyboard controllerWithID:@"CWebViewController"];
		webController.address                       = [NSString stringWithFormat:@"%@baike?id=%ld&type=%@",kServerAddress, (long)entry.id,entry.type];
		webController.title                     = entry.name;
		[self.navigationController pushViewController:webController animated:YES];
	}
}


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
	if (self.type == ePinZhong) {
		CSearchSingleWordParams* params = [CSearchSingleWordParams new];
		params.key = key;
		params.type = @"variety";
		//	params.type =
		[MBProgressHUD showHUDAddedTo:self.view animated:YES];

		[CSearchSingleWordModel requestWithParams:params completion:^(CSearchSingleWordModel* model, JSONModelError *err) {
			[MBProgressHUD hideHUDForView:self.view animated:YES];

			if (err == nil && model) {
				self.searchResult = @{params.type:model.data};
				[self.searchDispalyController.searchResultsTableView reloadData];
                
                // 搜不到，去百度
                if (model.data.count == 0) {
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
		
		CSearchSingleWordParams* params = [CSearchSingleWordParams new];
		params.key = key;
		params.type = @"petdisspec";
		[MBProgressHUD showHUDAddedTo:self.view animated:YES];

		[CSearchSingleWordModel requestWithParams:params completion:^(CSearchSingleWordModel* model, JSONModelError *err) {
			[MBProgressHUD hideHUDForView:self.view animated:YES];

			if (err == nil && model) {
				
				self.searchResult = @{params.type:model.data};
				[self.searchDispalyController.searchResultsTableView reloadData];
			}
		}];
	}
}

#pragma mark - RGIndexDelegate

-(NSString*)textForIndex:(int)index{
	NSArray* keys = self.sortArrayItem.keys;

	return [keys objectAtIndex_s:index];
}


-(int)numberOfItemsInIndexView{
	NSArray* keys = self.sortArrayItem.keys;
	return (int)keys.count;
}



- (void)indexView:(RGIndexView*)indexView didSelectIndex:(int)index{
	NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
	[self.righttable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
	
}

@end
