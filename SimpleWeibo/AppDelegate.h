//
//  AppDelegate.h
//  SimpleWeibo
//
//  Created by buyi on 16/1/11.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#define kAppKey         @"4115683295"
#define kRedirectURI    @"http://www.sina.com"

@interface AppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@end

