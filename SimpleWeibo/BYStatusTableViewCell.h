//
//  BYStatusTableViewCell.h
//  SimpleWeibo
//
//  Created by buyi on 16/3/15.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeiboUser.h>
#import <UIKit/UIKit.h>

//typedef float CGFloat;// 32-bit
//typedef double CGFloat;// 64-bit

@interface BYStatusTableViewCell : UITableViewCell


#pragma mark 微博对象
@property (nonatomic,strong) WeiboUser *status;

#pragma mark 单元格高度
@property (assign,nonatomic) CGFloat height;
@end
