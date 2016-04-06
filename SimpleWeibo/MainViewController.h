//
//  MainViewController.h
//  CDPullToRefreshDemo
//
//  Created by cDigger on 13-11-23.
//  Copyright (c) 2013年 cDigger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"

@interface MainViewController : UIViewController
@property NSMutableArray* status;
@property (strong, nonatomic) Request *request;
@end
