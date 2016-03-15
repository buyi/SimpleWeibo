//
//  BYStatusCellsViewController.m
//  SimpleWeibo
//
//  Created by buyi on 16/3/15.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import "BYStatusCellsViewController.h"

//@implementation BYStatusCellsViewController
//
//@end


#import "BYStatusCellsViewController.h"
#import "WeiboUser.h"
#import "BYStatusTableViewCell.h"

@interface BYStatusCellsViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UITableView *_tableView;
//    NSMutableArray *_status;
    NSMutableArray *_statusCells;//存储cell，用于计算高度
}
@end

@implementation BYStatusCellsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
//    [self initData];
//    NSLog("")
    
    for (WeiboUser* object in _status) {
//        NSLog(@"array=%@", object.screenName);
//        
        BYStatusTableViewCell *cell=[[BYStatusTableViewCell alloc]init];
                [_statusCells addObject:cell];
    }
    
    
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];
}

#pragma mark 加载数据
//-(void)initData{
//    NSString *path=[[NSBundle mainBundle] pathForResource:@"StatusInfo" ofType:@"plist"];
//    NSArray *array=[NSArray arrayWithContentsOfFile:path];
//    _status=[[NSMutableArray alloc]init];
//    _statusCells=[[NSMutableArray alloc]init];
//    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
////        [_status addObject:[WeiboUser statusWithDictionary:obj]];
//        BYStatusTableViewCell *cell=[[BYStatusTableViewCell alloc]init];
//        [_statusCells addObject:cell];
//    }];
//}
#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _status.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    BYStatusTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[BYStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //在此设置微博，以便重新布局
    WeiboUser *status=_status[indexPath.row];
    cell.status=status;
    return cell;
}

#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //KCStatusTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    BYStatusTableViewCell *cell= _statusCells[indexPath.row];
    cell.status=_status[indexPath.row];
    return cell.height;
}

#pragma mark 重写状态样式方法
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
