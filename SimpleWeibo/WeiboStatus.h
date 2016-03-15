//
//  WeiboStatus.h
//  SimpleWeibo
//
//  Created by buyi on 16/3/15.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboStatus : NSObject


@property BOOL isFollowingMe;
@property BOOL isFollowingByMe;
@property BOOL isAllowAllActMsg;
@property BOOL isAllowAllComment;
@property BOOL isGeoEnabled;
@property BOOL isVerified;



@property NSString* userID;
//
//_isFollowingMe	BOOL	NO	false
//_isFollowingByMe	BOOL	YES	true
//_isAllowAllActMsg	BOOL	NO	false
//_isAllowAllComment	BOOL	YES	true
//_isGeoEnabled	BOOL	YES	true
//_isVerified	BOOL	YES	true
//_userID	__NSCFString *	@"2865101843"	0x00007fbdb9659010
//_userClass	NSTaggedPointerString *	@"1"	0xa000000000000311
//_screenName	__NSCFString *	@"柯洁大棋渣"	0x00007fbdb9647c70
//_name	__NSCFString *	@"柯洁大棋渣"	0x00007fbdb9647c70
//_province	NSTaggedPointerString *	@"11"	0xa000000000031312
//_city	NSTaggedPointerString *	@"1"	0xa000000000000311
//_location	__NSCFString *	@"北京 东城区"	0x00007fbdb967ddd0
//_userDescription	__NSCFString *	@"围棋第一人 第2届百灵杯世界围棋公开赛冠军 第20届三星杯世界围棋大师赛冠军 第二届梦百合杯世界围棋公开赛冠军 以及若干国内冠军"	0x00007fbdb96794b0
//_url	__NSCFConstantString *	@""	0x0000000102790f50
//_profileImageUrl	__NSCFString *	@"http://tp4.sinaimg.cn/2865101843/50/5726736775/1"	0x00007fbdb9632430
//_coverImageUrl	void *	NULL	0x0000000000000000
//_coverImageForPhoneUrl	__NSCFString *	@"http://ww2.sinaimg.cn/crop.0.0.640.640.640/638f41a8jw1exw2esr96xj20hs0hstes.jpg;http://ww1.sinaimg.cn/crop.0.0.640.640.640/6cf8d7ebjw1ehfr4xa8psj20hs0hsgpg.jpg"	0x00007fbdb967c1a0
//_profileUrl	__NSCFString *	@"u/2865101843"	0x00007fbdb9652480
//_userDomain	__NSCFConstantString *	@""	0x0000000102790f50
//_weihao	__NSCFConstantString *	@""	0x0000000102790f50
//_gender	NSTaggedPointerString *	@"m"	0xa0000000000006d1
//_followersCount	NSTaggedPointerString *	@"450081"	0xa003138303035346
//_friendsCount	NSTaggedPointerString *	@"34"	0xa000000000034332
//_pageFriendsCount	NSTaggedPointerString *	@"0"	0xa000000000000301
//_statusesCount	NSTaggedPointerString *	@"85"	0xa000000000035382
//_favouritesCount	NSTaggedPointerString *	@"0"	0xa000000000000301
//_createdTime	__NSCFString *	@"Thu Sep 27 21:06:01 +0800 2012"	0x00007fbdb9667b70
//_verifiedType	NSTaggedPointerString *	@"0"	0xa000000000000301
//_remark	__NSCFConstantString *	@""	0x0000000102790f50
//_statusID	__NSCFString *	@"3953071161414979"	0x00007fbdb967dd80
//_ptype	NSTaggedPointerString *	@"0"	0xa000000000000301
//_avatarLargeUrl	__NSCFString *	@"http://tp4.sinaimg.cn/2865101843/180/5726736775/1"	0x00007fbdb965a600
//_avatarHDUrl	__NSCFString *	@"http://tva4.sinaimg.cn/crop.103.100.226.226.1024/aac5fc13jw8es68h9k7pmj20bh0bpabv.jpg"	0x00007fbdb9658070
//_verifiedReason	__NSCFString *	@"围棋九段 第二届百灵杯世界冠军 柯洁"	0x00007fbdb966b9d0
//_verifiedTrade	NSTaggedPointerString *	@"790"	0xa000000003039373
//_verifiedReasonUrl	__NSCFConstantString *	@""	0x0000000102790f50
//_verifiedSource	__NSCFConstantString *	@""	0x0000000102790f50
//_verifiedSourceUrl	__NSCFConstantString *	@""	0x0000000102790f50
//_verifiedState	NSTaggedPointerString *	@"0"	0xa000000000000301
//_verifiedLevel	NSTaggedPointerString *	@"2"	0xa000000000000321
//_onlineStatus	NSTaggedPointerString *	@"0"	0xa000000000000301
//_biFollowersCount	NSTaggedPointerString *	@"13"	0xa000000000033312
//_language	NSTaggedPointerString *	@"zh-cn"	0xa00006e632d687a5
//_star	void *	NULL	0x0000000000000000
//_mbtype	NSTaggedPointerString *	@"12"	0xa000000000032312
//_mbrank	NSTaggedPointerString *	@"2"	0xa000000000000321
//_block_word	NSTaggedPointerString *	@"0"	0xa000000000000301
//_block_app	NSTaggedPointerString *	@"1"	0xa000000000000311
//_credit_score	NSTaggedPointerString *	@"80"	0xa000000000030382
//_originParaDict	WBSDKJKDictionary *	0x7fbdb9664c80	0x00007fbdb9664c80

@end
