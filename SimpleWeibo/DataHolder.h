//
//  DataHolder.h
//  SimpleWeibo
//
//  Created by buyi on 16/1/13.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHolder : NSObject

+ (DataHolder *)sharedInstance;

//@property (assign) int level;
//@property (assign) int score;


@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;


-(void) saveData;
-(void) loadData;

@end
