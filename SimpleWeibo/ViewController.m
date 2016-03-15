//
//  ViewController.m
//  SimpleWeibo
//
//  Created by buyi on 16/1/11.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "DataHolder.h"
#import "weiboUser.h"
#import "BYStatusCellsViewController.h"

@interface ViewController()<UIScrollViewDelegate>
{
   
   
}
@property (nonatomic, strong) UIButton *shareButton;
//@property ViewController *obj;
@end

@interface ViewController () {

}

@end

@implementation ViewController
static ViewController *obj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    obj = self;
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    
    
    UIButton *ssoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ssoButton setTitle:NSLocalizedString(@"请求微博认证（SSO授权）", nil) forState:UIControlStateNormal];
    [ssoButton addTarget:self action:@selector(ssoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    ssoButton.frame = CGRectMake(20, 90, 280, 40);
    [scrollView addSubview:ssoButton];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.shareButton.titleLabel.numberOfLines = 2;
    self.shareButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareButton setTitle:NSLocalizedString(@"分享消息到微博", nil) forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton.frame = CGRectMake(210, 200, 90, 110);
    [scrollView addSubview:self.shareButton];
    
    UIButton *friendsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [friendsButton setTitle:NSLocalizedString(@"friend", nil) forState:UIControlStateNormal];
    [friendsButton addTarget:self action:@selector(testRequestForFriendsListOfUser) forControlEvents:UIControlEventTouchUpInside];
    friendsButton.frame = CGRectMake(240, 90, 280, 40);
    [scrollView addSubview:friendsButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ssoButtonPressed
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"ViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)shareButtonPressed
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}


- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
//    if (self.textSwitch.on)
//    {
        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
//    }
    
//    if (self.imageSwitch.on)
//    {
//        WBImageObject *image = [WBImageObject object];
//        image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
//        message.imageObject = image;
//    }
//    
//    if (self.mediaSwitch.on)
//    {
//        WBWebpageObject *webpage = [WBWebpageObject object];
//        webpage.objectID = @"identifier1";
//        webpage.title = NSLocalizedString(@"分享网页标题", nil);
//        webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
//        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
//        webpage.webpageUrl = @"http://sina.cn?a=1";
//        message.mediaObject = webpage;
//    }
    
    return message;
}

- (void)testRequestForFriendsListOfUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //just set extraPara for http request as you want, more paras description can be found on the API website,
    //for this API, details are from http://open.weibo.com/wiki/2/friendships/friends/en .
    NSMutableDictionary* extraParaDict = [NSMutableDictionary dictionary];
//    [extraParaDict setObject:@"2" forKey:@"cursor"];
//    [extraParaDict setObject:@"3" forKey:@"count"];
    
    NSLog(@"wbCurrentUserID is %@", [DataHolder sharedInstance].wbCurrentUserID);
     NSLog(@"wbtoken is %@", [DataHolder sharedInstance].wbtoken);
    
    [WBHttpRequest requestForFriendsListOfUser: [DataHolder sharedInstance].wbCurrentUserID withAccessToken:[DataHolder sharedInstance].wbtoken andOtherProperties:extraParaDict queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHanlder(httpRequest, result, error);
        
    }];
}

void DemoRequestHanlder(WBHttpRequest *httpRequest, id result, NSError *error)
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    if (error)
    {
        title = NSLocalizedString(@"请求异常", nil);
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:[NSString stringWithFormat:@"%@",error]
                                          delegate:nil
                                 cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                 otherButtonTitles:nil];
    }
    else
    {
        title = NSLocalizedString(@"收到网络回调", nil);
//        NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableLeaves error:&error];
//        
//          NSLog(@"weatherDic is %@", weatherDic);
        
        NSArray* array = [result objectForKey:@"users"];
          NSLog(@"array is %@", array);
        
        for (WeiboUser* object in array) {
            NSLog(@"array=%@", object.screenName);
        }
        
        
        NSNumber *next_cursor = [result objectForKey:@"next_cursor"];
          NSLog(@"next_cursor is %@", next_cursor);
        
         NSNumber *previous_cursor = [result objectForKey:@"previous_cursor"];
         NSLog(@"previous_cursor is %@", previous_cursor);
        
        NSNumber *total_number = [result objectForKey:@"total_number"];
        NSLog(@"total_number is %@", total_number);
        
        BYStatusCellsViewController *first = [[BYStatusCellsViewController alloc]init];
        first.status = array;
        [obj.navigationController pushViewController:first animated:YES];
        
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:[NSString stringWithFormat:@"%@",result]
                                          delegate:nil
                                 cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                 otherButtonTitles:nil];
    }
    
    [alert show];
}


@end
