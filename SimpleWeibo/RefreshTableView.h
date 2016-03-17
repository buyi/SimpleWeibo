//
//  RefreshTableView.h
//  SimpleWeibo
//
//  Created by buyi on 16/3/17.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import <Foundation/Foundation.h>

//
//  RefreshTableView.h
//  TableViewRefresh
//
//  Created by 王 尧 on 13-5-18.
//
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "EGOViewCommon.h"


@protocol RefreshTableViewDelegate <NSObject>

/**
 * @desc   TODO: 触发操作-->下拉刷新
 * @author Wangyao
 * @param  N/A
 * @return N/A
 * @since  N/A
 */
- (void)beginLoadData_PullDown;

/**
 * @desc   TODO: 触发操作-->上拉刷新
 * @author Wangyao
 * @param  N/A
 * @return N/A
 * @since  N/A
 */
- (void)beginLoadData_PullUp;

@end

@interface RefreshTableView : UITableView
{
    BOOL _reloading;
}

@property (nonatomic, retain) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, retain) EGORefreshTableFooterView *refreshFooterView;

//用来告知调用类需要执行刷新回调-->不实现该回调的统统切JJ
@property (nonatomic, assign) id<RefreshTableViewDelegate> pullActionDelegate;


/**
 * @desc   TODO: 配置是否显示头部及底部的刷新栏
 * @author Wangyao
 * @param  N/A
 * @return N/A
 * @since  N/A
 */
- (void)configHeaderUsing:(BOOL)useHeader footer:(BOOL)useFooter;
// create/remove footer/header view, reset the position of the footer/header views

-(void)setFooterView;
-(void)removeFooterView;
-(void)createHeaderView;
-(void)removeHeaderView;

// overide methods
-(void)beginToReloadData:(EGORefreshPos)aRefreshPos;
-(void)finishReloadingData;

// force to refresh
-(void)showRefreshHeader:(BOOL)animated;

@end

