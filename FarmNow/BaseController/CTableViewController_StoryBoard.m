//
//  CTableViewController_StoryBoard.m
//  FarmNow
//
//  Created by zheliang on 15/10/16.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CTableViewController_StoryBoard.h"

@interface CTableViewController_StoryBoard ()

@end

#define str_fmt(fmt, ...)                   [NSString stringWithFormat : fmt,##__VA_ARGS__]

NSString   *kDesignableTableViewDefaultTableViewCellIdenifier = @"content";
NSString   *kDesignableTableViewDefaultNumberOfRow            = @"10";

@interface UITableViewRowModel ()
@end
@implementation UITableViewRowModel
+ (UITableViewRowModel*)modelWithIdentifier:(NSString*)identifier data:(id)data delegate:(NSObject<CTableViewCell_StoryBoardDelegate>*) delegate
{
	UITableViewRowModel   *model = [[UITableViewRowModel alloc] init];
	model.delegate = delegate;
	model.identifier = identifier;
	model.data       = data;
	model.height = -1;
	return model;
}

- (void)dealloc
{
	self.data = nil;
	self.identifier = nil;
}
@end

@implementation UITableViewSectionModel

- (void)dealloc
{
	self.title = nil;
	[self.rows removeAllObjects];
	self.rows = nil;
	
}
@end


@implementation UITableViewModel
{
	NSMutableDictionary   *_sections;
}

- (id)init
{
	self = [super init];
	if (self)
	{
		_sections = [NSMutableDictionary dictionary];
	}
	
	return self;
}


- (NSString*)keyForSection:(NSInteger)sectionIndex
{
	return str_fmt(@"section-%ld", (long)sectionIndex);
}

- (UITableViewSectionModel*)modelForSection:(NSInteger)section
{
	UITableViewSectionModel   *model = [_sections valueForKey:[self keyForSection:section]];
	
	if (!model)
	{
		model      = [[UITableViewSectionModel alloc] init];
		model.rows = [NSMutableArray array];
		[_sections setValue:model forKey:[self keyForSection:section]];
	}
	
	return model;
} /* sectionModel */

- (void)setTitle:(NSString*)title forSection:(NSInteger)section
{
	UITableViewSectionModel   *model = [self modelForSection:section];
	
	model.title = title;
} /* setTitle */

- (NSString*)titleForSection:(NSInteger)section
{
	return [[self modelForSection:section] title];
}

- (NSInteger)numberOfSections
{
	return [[_sections allKeys] count];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
	return [[[self modelForSection:section] rows] count];
}

- (UITableViewSectionModel*)modelForSectionAtIndex:(int)section
{
	return [self modelForSection:section];
}

- (void)addRow:(UITableViewRowModel*)row forSection:(NSInteger)section
{
	[[[self modelForSection:section] rows] push:row];
}

- (void)insertRow:(UITableViewRowModel*)row forIndexPath:(NSIndexPath*)indexPath
{
	[[[self modelForSection:indexPath.section] rows] insertObject:row atIndex:indexPath.row];
}

- (void)insertRowWithNewSecton:(UITableViewRowModel *)row forIndexPath:(NSIndexPath *)indexPath
{
	UITableViewSectionModel   *model = [[UITableViewSectionModel alloc] init];
		model.rows = [NSMutableArray array];
	[model.rows addObject:row];
		[_sections setValue:model forKey:[self keyForSection:indexPath.section]];
}
- (void)removeSection:(NSInteger)section
{
	[_sections removeObjectForKey:[self keyForSection:section]];
}

- (UITableViewRowModel*)modelForRowAtIndexPath:(NSIndexPath*)indexPath
{
	return [[[self modelForSection:indexPath.section] rows] at:indexPath.row];
}

- (NSString*)identifierForRowAtIndexPath:(NSIndexPath*)indexPath
{
	return [[self modelForRowAtIndexPath:indexPath] identifier];
}

- (id)dataForRowAtIndexPath:(NSIndexPath*)indexPath
{
	return [[self modelForRowAtIndexPath:indexPath] data];
}

- (void)removeRowAtIndexPath:(NSIndexPath*)indexPath
{
	[[[self modelForSection:indexPath.section] rows] removeObjectAtIndex:indexPath.row];
}
- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
{
	UITableViewRowModel* fromRowModel = [self modelForRowAtIndexPath:fromIndexPath];
	UITableViewRowModel* toRowModel = [self modelForRowAtIndexPath:toIndexPath];
	
	UITableViewSectionModel* fromSection = [self modelForSectionAtIndex:(int)fromIndexPath.section];
	[fromSection.rows replaceObjectAtIndex:fromIndexPath.row withObject:toRowModel];
	
	UITableViewSectionModel* toSection = [self modelForSectionAtIndex:(int)toIndexPath.section];
	[toSection.rows replaceObjectAtIndex:toIndexPath.row withObject:fromRowModel];
}

- (void)clear
{
	[_sections removeAllObjects];
}
@end


@implementation CTableViewController_StoryBoard
{
	UITableViewModel      *_dataModel;
	NSMutableDictionary   *_cellsForHeightCalculate;
	
}

- (id)init
{
	self = [super init];
	if (self)
	{
		self.staticCellHeight = NO;
	}
	
	return self;
}

- (void)dealloc
{
	self.tableView = nil;
	[_cellsForHeightCalculate removeAllObjects];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.tableView.delegate   = self;
	self.tableView.dataSource = self;
	self.staticCellHeight = NO;//默认计算所有cell高度 为YES时相同id的cell只计算一次
	
	_dataModel                = [[UITableViewModel alloc] init];
	if ([self useIOS7NewFeatures]) {
		self.tableView.rowHeight = UITableViewAutomaticDimension;
		self.tableView.estimatedRowHeight = 44.0;
	}
	[self buildDesignUI];
}

- (BOOL)useIOS7NewFeatures
{
		return YES;

}
- (void)buildDesignUI
{
	_cellsForHeightCalculate = [NSMutableDictionary dictionary];
	
} /* buildDesignUI */

#pragma mark -
- (UITableViewModel*)tableViewModel
{
	return _dataModel;
}

- (void)updateModel:(UITableViewModel*)dataModel
{
	if (dataModel == nil) {
		[self clearData];
		return;
	}
	if (_dataModel != dataModel)
	{

		_dataModel                = dataModel;
		
		self.tableView.dataSource = self;
		self.tableView.delegate   = self;
		//如果用系统动画滚动 或者 设置与reload并发 在低端手机 会出现滚动异常
		[UIView animateWithDuration:.2 animations:^{
			[self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
			
		} completion:^(BOOL finished) {
			[self.tableView reloadData];
			
		}];
		
		
	}
	else
	{
		[self.tableView reloadData];
	}
} /* updateModel */

- (void)updateModelNoScollToTop:(UITableViewModel*)dataModel;
{
	if (dataModel == nil) {
		[self clearData];
		return;
	}
	if (_dataModel != dataModel)
	{

		_dataModel                = dataModel;
		
		self.tableView.dataSource = self;
		self.tableView.delegate   = self;
		[self.tableView reloadData];
	}
	else
	{
		[self.tableView reloadData];
	}
} /* updateModel */

- (void)configureCell:(UITableViewCell*)cell data:(id)data indexPath:(NSIndexPath*)indexPath
{
	if ([cell isKindOfClass:[CTableViewCell_StoryBoard class]]) {
		((CTableViewCell_StoryBoard*)cell).cellData = data;
		((CTableViewCell_StoryBoard*)cell).indexPath = indexPath;
		((CTableViewCell_StoryBoard*)cell).delegate = self;
		
		[((CTableViewCell_StoryBoard*)cell) setData:data];
	}
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
	return [_dataModel numberOfSections ];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_dataModel numberOfRowsInSection:section];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	UITableViewRowModel   *rowModel   = [_dataModel modelForRowAtIndexPath:indexPath];
	NSString              *identifier = [rowModel identifier];
	UITableViewCell       *cell       = [self.tableView dequeueReusableCellWithIdentifier:identifier];
	
	//    if (!cell)
	//    {
	//        Error(@"cell for %@ is nil", identifier);
	//    }
	if ([cell isKindOfClass:[CTableViewCell_StoryBoard class]]) {
		((CTableViewCell_StoryBoard*)cell).delegate = rowModel.delegate;
		
	}
	[self configureCell:cell data:[rowModel data] indexPath:indexPath];
	[cell setNeedsUpdateConstraints];
	[cell updateConstraintsIfNeeded];
	return cell;
} /* tableView */

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
	return [_dataModel titleForSection:section];
}


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
	if ([self useIOS7NewFeatures]) {
		return UITableViewAutomaticDimension;
		
	}
	UITableViewRowModel   *rowModel   = [_dataModel modelForRowAtIndexPath:indexPath];
	//如果高度已经计算并缓存 直接返回
	if (rowModel.height != -1 && rowModel) {
		return rowModel.height;
	}
	NSString              *identifier = [rowModel identifier];
	UITableViewCell       *cell       = [_cellsForHeightCalculate valueForKey:identifier];
	
	if (!cell)
	{
		cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
		
		[_cellsForHeightCalculate setObject:cell forKey:identifier];
	}
	////相同identifier cell高度相同 只计算一次
	else if(self.staticCellHeight)
	{
		//如果有相同identifier的cell 计算过高度 那么直接返回
		UITableViewRowModel   *model   = [self.tableViewModel modelForRowAtIndexPath:((CTableViewCell_StoryBoard*)cell).indexPath];
		
		if (model.height != -1 && [model.identifier isEqualToString:identifier]) {
			return model.height;
		}
	}
	if (!cell)
	{
		
		return 0;
	}
	
	[cell prepareForReuse];
	
	[self configureCell:cell data:[rowModel data] indexPath:indexPath];
	
	
	// Add a hard width constraint to make dynamic content views (like labels) expand vertically instead
	// of growing horizontally, in a flow-layout manner.
	NSLayoutConstraint *tempWidthConstraint =
	[NSLayoutConstraint constraintWithItem:cell.contentView
								 attribute:NSLayoutAttributeWidth
								 relatedBy:NSLayoutRelationEqual
									toItem:nil
								 attribute:NSLayoutAttributeNotAnAttribute
								multiplier:1.0
								  constant:CGRectGetWidth(self.tableView.frame)];
	[cell.contentView addConstraint:tempWidthConstraint];
	
	// Auto layout engine does its math
	CGSize fittingSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
	
	[cell.contentView removeConstraint:tempWidthConstraint];
	
	// Add 1px extra space for separator line if needed, simulating default UITableViewCell.
	if (self.tableView.separatorStyle != UITableViewCellSeparatorStyleNone) {
		fittingSize.height += 1.0 / [UIScreen mainScreen].scale;
	}
	
	CGFloat height = fittingSize.height;
	
	if (height == 0)
	{
		height = cell.frame.size.height;
	}
	/**
	 *  将计算好的高度缓存到cache中 第二次将不再计算
	 */
	if (rowModel.height == -1) {
		rowModel.height = height;
	}
	
	return height;
} /* tableView */


- (void)didSelect:(NSIndexPath *)indexPath identifier:(NSString*)identifier data:(id)data
{
	
}

- (void)didDeSelect:(NSIndexPath *)indexPath identifier:(NSString*)identifier data:(id)data
{
	
}

- (void)clearData
{
	if ([[self tableViewModel] numberOfSections] > 0) {
		[[self tableViewModel] clear];
		[self.tableView reloadData];
	}
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewRowModel   *rowModel   = [_dataModel modelForRowAtIndexPath:indexPath];
	[self didSelect:indexPath identifier:rowModel.identifier data:rowModel.data];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewRowModel   *rowModel   = [_dataModel modelForRowAtIndexPath:indexPath];
	[self didDeSelect:indexPath identifier:rowModel.identifier data:rowModel.data];
}
- (void)    tableView:(UITableView*)tableView
	  willDisplayCell:(UITableViewCell*)cell
	forRowAtIndexPath:(NSIndexPath*)indexPath
{
#if 0
	cell.transform = CGAffineTransformMakeTranslation(10, 0);
	[UIView animateWithDuration:.3 animations: ^{
		cell.transform = CGAffineTransformMakeTranslation(-10, 0);
	} completion: ^(BOOL finished) {
		// cell.transform = CGAffineTransformMakeScale(1.0,1.0);
	}];
#endif
}

- (void)insertRowsAtIndexPath:(UITableViewRowModel*)row indexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation
{
	[self.tableViewModel insertRow:row forIndexPath:indexPath];
	[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)deleteRowsAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation
{
	[self.tableViewModel removeRowAtIndexPath:indexPath];
	
	[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
{
	[self.tableViewModel moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];

}
@end

