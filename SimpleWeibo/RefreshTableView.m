//
//  RefreshTableView.m
//  SimpleWeibo
//
//  Created by buyi on 16/3/17.
//  Copyright © 2016年 buyi. All rights reserved.
//

//#import "RefreshTableView.h"

//
//  RefreshTableView.m
//  TableViewRefresh
//
//  Created by 王 尧 on 13-5-18.
//
//

#import "RefreshTableView.h"

@interface RefreshTableView ()<EGORefreshTableDelegate,UIScrollViewDelegate>

@end

@implementation RefreshTableView

- (void)dealloc{
    if (_refreshHeaderView) {
//        [_refreshHeaderView release];
        _refreshHeaderView = nil;
    }
    
    if (_refreshFooterView) {
//        [_refreshFooterView release];
        _refreshFooterView = nil;
    }
    
    self.pullActionDelegate = nil;
    
//    [super dealloc];
}

- (void)configRefreshTableView{
    self.contentInset = UIEdgeInsetsMake(0, 0, 10.0, 0);
    // set header
}

/**
 * @desc   TODO: 配置是否显示头部及底部的刷新栏
 * @author Wangyao
 * @param  N/A
 * @return N/A
 * @since  N/A
 */
- (void)configHeaderUsing:(BOOL)useHeader footer:(BOOL)useFooter{
    if (useHeader) {
        [self createHeaderView];
    }
    if (useFooter) {
        [self setFooterView];
    }
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self configRefreshTableView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configRefreshTableView];
    }
    return self;
}

- (void)awakeFromNib{
    [self configRefreshTableView];
}

#pragma mark-==============================上拉  下拉  刷新  ======================
#pragma mark
#pragma methods for creating and removing the header view

-(void)createHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0.0f, 0.0f - self.bounds.size.height,
                                     self.frame.size.width, self.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    
    [self addSubview:_refreshHeaderView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
}

-(void)removeHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
    _refreshHeaderView = nil;
}

-(void)setFooterView{
    // if the footerView is nil, then create it, reset the position of the footer
    NSLog(@"contentSize height is @a", self.contentSize.height);
    NSLog(@"frame height is @a", self.frame.size.height);
    CGFloat height = MAX(self.contentSize.height, self.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              self.frame.size.width,
                                              self.bounds.size.height);
    }else {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         self.frame.size.width, self.bounds.size.height)];
        
        
        _refreshFooterView.delegate = self;
        [self addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView refreshLastUpdatedDate];
    }
}

-(void)removeFooterView{
    if (_refreshFooterView && [_refreshFooterView superview]) {
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}

#pragma mark-
#pragma mark force to show the refresh headerView
-(void)showRefreshHeader:(BOOL)animated{
    if (animated)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        self.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        // scroll the table view to the top region
        [self scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
        [UIView commitAnimations];
    }
    else
    {
        self.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        [self scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
    }
    
    [_refreshHeaderView setState:EGOOPullRefreshLoading];
}


#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
    //  should be calling your tableviews data source model to reload
    _reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader) {
        // pull down to refresh data
        // overide, the actual loading data operation is done in the subclass
        //下拉刷新
        if (self.pullActionDelegate && [self.pullActionDelegate respondsToSelector:@selector(beginLoadData_PullDown)]) {
            [self.pullActionDelegate performSelector:@selector(beginLoadData_PullDown)];
        }
    }else if(aRefreshPos == EGORefreshFooter){
        // pull up to load more data
        if (self.pullActionDelegate && [self.pullActionDelegate respondsToSelector:@selector(beginLoadData_PullUp)]) {
            //上拉刷新
            [self.pullActionDelegate performSelector:@selector(beginLoadData_PullUp)];
        }
    }
}

#pragma mark -
#pragma mark method that should be called when the refreshing is finished
- (void)finishReloadingData{
    //  model should call this when its done loading
    _reloading = NO;
    
    if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        [self setFooterView];
    }
    
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}


#pragma mark -
#pragma mark EGORefreshTableDelegate Methods

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
    [self beginToReloadData:aRefreshPos];
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
    return _reloading; // should return if data source model is reloading
}


// if we don't realize this method, it won't display the refresh timestamp
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
    return [NSDate date]; // should return date data source was last changed
}


@end
