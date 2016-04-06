//
//  Request.h
//  SimpleWeibo
//
//  Created by buyi on 16/4/6.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject


-(void)getStatusesWithSinceId:(int)sinceId
                        maxId:(int)maxId
                        count:(int)count
                         page:(int)page
                      feature:(int)feature
                     trimUser:(int)trimUser
                      success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;
@end
