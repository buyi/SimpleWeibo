//
//  ViewController.h
//  SimpleWeibo
//
//  Created by buyi on 16/1/11.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

-(void)getStatusesWithSinceId:(int)sinceId
maxId:(int)maxId
count:(int)count
page:(int)page
feature:(int)feature
trimUser:(int)trimUser
                      success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;


@end

