//
//  Request.m
//  SimpleWeibo
//
//  Created by buyi on 16/4/6.
//  Copyright © 2016年 buyi. All rights reserved.
//

#define HOSTURL @"api.weibo.com"

#import "Request.h"
#import "HttpBaseModel.h"

#import "Status.h"
#import "SBJSON.h"

@implementation Request



//- (void) questForStatus {
/**
 *	获取当前登录用户及其所关注用户的最新微博
 *
 *	@param	sinceId     若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *	@param	maxId       若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *	@param	count       单页返回的记录条数，最大不超过100，默认为20。
 *	@param	page        返回结果的页码，默认为1。
 *	@param	feature     过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 *	@param	trimUser	返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回的微博信息数组
 */
- (void)getStatusesWithSinceId:(int)sinceId
                         maxId:(int)maxId
                         count:(int)count
                          page:(int)page
                       feature:(int)feature
                      trimUser:(int)trimUser
                       success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess
{
    //        NSString *accessToken = [DataHolder sharedInstance].wbtoken;
    NSString* accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"wbtoken"];
    NSLog(@"accessToken = %@", accessToken);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:accessToken forKey:@"access_token"];
    [dic setObject:[NSString stringWithFormat:@"%d",sinceId] forKey:@"since_id"];
    [dic setObject:[NSString stringWithFormat:@"%d",maxId] forKey:@"max_id"];
    [dic setObject:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
    [dic setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",feature] forKey:@"feature"];
    [dic setObject:[NSString stringWithFormat:@"%d",trimUser] forKey:@"trim_user"];
    
    [HttpBaseModel getDataResponseHostName:HOSTURL Path:@"2/statuses/home_timeline.json" params:dic httpMethod:@"GET" onCompletion:^(NSData *responseData){
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//        NSLog(@"responseString = %@", responseString);
        
        SBJSON *json = [[SBJSON alloc] init];
        NSError *error = nil;
        NSDictionary *jsonDic = [json objectWithString:responseString error:&error];
        
        NSArray *array = [jsonDic objectForKey:@"statuses"];
        NSMutableArray *statusArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in array) {
            Status *status = [Status getStatusFromJsonDic:dic];
            [statusArray addObject:status];
        }
        isSuccess(YES, statusArray);
        
        //            [json release];
        //            [responseString release];
    } onError:^(NSError *error){
        isSuccess(NO, nil);
    }];
}
//}

@end
