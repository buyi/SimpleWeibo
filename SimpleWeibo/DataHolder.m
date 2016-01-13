//
//  DataHolder.m
//  SimpleWeibo
//
//  Created by buyi on 16/1/13.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import "DataHolder.h"


NSString * const kWbtoken = @"kWbtoken";
NSString * const kWbRefreshToken = @"kWbRefreshToken";
NSString * const kWbCurrentUserID = @"kWbCurrentUserID";

@implementation DataHolder

- (id) init
{
    self = [super init];
    if (self)
    {
//        _level = 0;
//        _score = 0;
    }
    return self;
}

+ (DataHolder *)sharedInstance
{
    static DataHolder *_sharedInstance = nil;
    static dispatch_once_t onceSecurePredicate;
    dispatch_once(&onceSecurePredicate,^
                  {
                      _sharedInstance = [[self alloc] init];
                  });
    
    return _sharedInstance;
}

//in this example you are saving data to NSUserDefault's
//you could save it also to a file or to some more complex
//data structure: depends on what you need, really

-(void)saveData
{
    [[NSUserDefaults standardUserDefaults] setObject:self.wbtoken forKey:kWbtoken];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.wbRefreshToken forKey:kWbRefreshToken];
    
     [[NSUserDefaults standardUserDefaults] setObject:self.wbCurrentUserID forKey:kWbCurrentUserID];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadData
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kWbtoken])
    {
        self.wbtoken = (NSString *)[[NSUserDefaults standardUserDefaults] stringForKey:kWbtoken];
           self.wbRefreshToken = (NSString *)[[NSUserDefaults standardUserDefaults] stringForKey:kWbRefreshToken];
           self.wbCurrentUserID = (NSString *)[[NSUserDefaults standardUserDefaults] stringForKey:kWbCurrentUserID];
    }
    else
    {
//        self.level = 0;
//        self.score = 0;
    }
}

@end
