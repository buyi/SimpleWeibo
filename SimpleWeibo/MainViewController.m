//
//  MainViewController.m
//  CDPullToRefreshDemo
//
//  Created by cDigger on 13-11-23.
//  Copyright (c) 2013年 cDigger. All rights reserved.
//

#import "MainViewController.h"
#import "Pull2RefreshTableView.h"
#import "Status.h"
#import "BYStatusTableViewCell.h"

const NSInteger pull2RefreshHeaderHeight = 65;
const NSInteger pull2RefreshFooterHeight = 50;

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    Pull2RefreshTableView *pull2RefreshTableView;
    
//    NSMutableArray        *dataSource;
    BOOL                  reload;
    NSMutableArray *_statusCells;//存储cell，用于计算高度
}

@end


@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    pull2RefreshTableView = [[Pull2RefreshTableView alloc] initWithFrame:self.view.bounds showDragRefreshHeader:YES showDragRefreshFooter:YES];
    pull2RefreshTableView.dragHeaderHeight = pull2RefreshHeaderHeight;
    pull2RefreshTableView.dragFooterHeight = pull2RefreshFooterHeight;
    
    __weak MainViewController *vc = self;
    pull2RefreshTableView.dragEndBlock = ^(Pull2RefreshViewType type)
    {
        if (type == kPull2RefreshViewTypeHeader)
        {
            [vc reloadInitDataInOtherThread];
        }
        else
        {
            [vc addMoreDataInOtherThread];
        }
    };
    pull2RefreshTableView.dataSource = self;
    
    [self.view addSubview:pull2RefreshTableView];
    
//    [self addMoreData];
    
    
    
//    [super viewDidLoad];
    
    //初始化数据
    //    [self initData];
    //    NSLog("")
    _statusCells=[[NSMutableArray alloc]init];
    
    
    
    
    for (Status* object in _status) {
        //        NSLog(@"array=%@", object.screenName);
        //
        //         [_status addObject:object];
        BYStatusTableViewCell *cell=[[BYStatusTableViewCell alloc]init];
        [_statusCells addObject:cell];
    }
//    
//    
//    //创建一个分组样式的UITableView
//    //    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    //    [_tableView configHeaderUsing:YES footer:YES];
//    //    _tableView.pullActionDelegate = self;
//    
//    _tableView = [[RefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    [_tableView configHeaderUsing:YES footer:NO];
//    [_tableView setBackgroundColor:[UIColor clearColor]];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.pullActionDelegate = self;
//    //    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    //    _tableView.clipsToBounds = NO;
//    //
//    //    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
//    
//    
//    //    CGRect tableViewframe = _tableView.frame;
//    //    tableViewframe.size.height -= 65;
//    //    _tableView.frame = tableViewframe;
//    
//    [self.view addSubview:self->_tableView];
//    
//    //设置数据源，注意必须实现对应的UITableViewDataSource协议
//    //    _tableView.dataSource=self;
//    //设置代理
//    //    _tableView.delegate=self;
//    
//    //    [self.view addSubview:_tableView];

}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return dataSource ? dataSource.count : 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _status.count;
//    if (section < dataSource.count)
//    {
//        return [[dataSource objectAtIndex:section] count];
//    }
//    
//    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellIdentifier = @"cellIdentifier";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.textLabel.text = @"Row";
//    }
//    
//    return cell;
    
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    BYStatusTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[BYStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //在此设置微博，以便重新布局
    Status *status=_status[indexPath.row];
    cell.status=status;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 100;
    BYStatusTableViewCell *cell= _statusCells[indexPath.row];
    cell.status=_status[indexPath.row];
    return cell.height;
}

#pragma mark 重写状态样式方法
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark - 模拟获取数据
- (void)addMoreDataInOtherThread
{
    [NSThread detachNewThreadSelector:@selector(addMoreData) toTarget:self withObject:nil];
}

- (void)addMoreData
{
    sleep(2);
    
//    if (!dataSource)
//    {
//        dataSource = [NSMutableArray new];
//    }
//    
//    NSArray *moreDataArr = [NSArray arrayWithObjects:@"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", nil];
//    [dataSource addObject:moreDataArr];
    
    [pull2RefreshTableView reloadData];
    [pull2RefreshTableView completeDragRefresh];
    
    pull2RefreshTableView.shouldShowDragFooter = YES;
    [pull2RefreshTableView addDragFooterView];
}

- (void)reloadInitDataInOtherThread
{
    [NSThread detachNewThreadSelector:@selector(reloadInitData) toTarget:self withObject:nil];
}

- (void)reloadInitData
{
    sleep(20);
//    if (dataSource.count > 0)
//    {
//        [dataSource removeAllObjects];
//    }
//    
//    NSArray *initDataArr = [NSArray arrayWithObjects:@"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", @"Row", nil];
//    [dataSource addObject:initDataArr];
    
    [pull2RefreshTableView reloadData];
    [pull2RefreshTableView completeDragRefresh];
}

@end
