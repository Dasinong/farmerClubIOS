//
//  CTableViewController_StoryBoard.h
//  FarmNow
//
//  Created by zheliang on 15/10/16.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CBaseViewController.h"
#define _TYPE(_type, ...)
#import "CTableViewCell_StoryBoard.h"

@interface UITableViewRowModel : NSObject
@property ( nonatomic, strong ) NSString   *identifier;
@property ( nonatomic, strong ) id          data;
@property ( nonatomic, assign ) NSObject<CTableViewCell_StoryBoardDelegate>* delegate;
@property (nonatomic, assign) CGFloat height;//没有计算过时候默认-1;

+ (UITableViewRowModel*)modelWithIdentifier:(NSString*)identifier data:(id)data delegate:(NSObject<CTableViewCell_StoryBoardDelegate>*) delegate;
@end

#define TABLEVIEW_ROW(identifier_, data_) [UITableViewRowModel modelWithIdentifier : identifier_ data : data_ delegate:nil]
#define TABLEVIEW_ROW_With_Delegate(identifier_, data_, delegate_) [UITableViewRowModel modelWithIdentifier : identifier_ data : data_ delegate:delegate_]

@interface UITableViewSectionModel : NSObject
@property ( nonatomic, strong ) NSString   *title;
@property ( nonatomic, strong )_TYPE(UITableViewRowModel) NSMutableArray * rows;
@end

@interface UITableViewModel : NSObject

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (UITableViewSectionModel*)modelForSection:(NSInteger)section;
- (void)setTitle:(NSString*)title forSection:(NSInteger)section;
- (NSString*)titleForSection:(NSInteger)section;

- (void)addRow:(UITableViewRowModel*)row forSection:(NSInteger)section;
- (void)insertRow:(UITableViewRowModel*)row forIndexPath:(NSIndexPath*)indexPath;
- (void)insertRowWithNewSecton:(UITableViewRowModel*)row forIndexPath:(NSIndexPath*)indexPath;

- (void)removeSection:(NSInteger)section;

- (UITableViewRowModel*)modelForRowAtIndexPath:(NSIndexPath*)indexPath;
- (NSString*)identifierForRowAtIndexPath:(NSIndexPath*)indexPath;
- (id)dataForRowAtIndexPath:(NSIndexPath*)indexPath;
- (void)removeRowAtIndexPath:(NSIndexPath*)indexPath;
- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
- (void)clear;
@end


@interface CTableViewController_StoryBoard : CBaseViewController <UITableViewDataSource, UITableViewDelegate,CTableViewCell_StoryBoardDelegate>


@property (nonatomic, retain) IBOutlet UITableView   *tableView;
@property (nonatomic, readonly) UITableViewModel   *tableViewModel;
@property (nonatomic, assign)  BOOL   staticCellHeight; //相同identifier cell高度相同 只计算一次 默认为NO 计算所有cell

/**
 *  构建在interface builder中设计的测试界面
 *  @note 子类需要实现该方法,取消构建测试界面
 *  @since 1.0
 */
- (void)buildDesignUI;

/**
 *  是否使用IOS8tableview自动运算CELL高度特性
 *
 *  @return YES,使用 NO，不使用，使用原始算法
 */
- (BOOL)useIOS7NewFeatures;

/**
 * 使用data配置tableviewcell
 *
 */
- (void)configureCell:(UITableViewCell*)cell data:(id)data indexPath:(NSIndexPath*)indexPath;

/**
 *  更新数据模型
 *
 *  @since 1.0
 */
- (UITableViewModel*)tableViewModel;
- (void)updateModel:(UITableViewModel*)dataModel;
- (void)updateModelNoScollToTop:(UITableViewModel*)dataModel;

- (void)didSelect:(NSIndexPath*)indexPath identifier:(NSString*)identifier data:(id)data;
- (void)didDeSelect:(NSIndexPath*)indexPath identifier:(NSString*)identifier data:(id)data;
- (void)clearData;
- (void)insertRowsAtIndexPath:(UITableViewRowModel*)row indexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowsAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end
