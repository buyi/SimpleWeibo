//
//  BYStatusTableViewCell.m
//  SimpleWeibo
//
//  Created by buyi on 16/3/15.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import "BYStatusTableViewCell.h"
#import "Status.h"
#import "User.h"

#import "EGOImageView.h"

#define KCColor(r,g,b) [UIColor colorWithHue:r/255.0 saturation:g/255.0 brightness:b/255.0 alpha:1] //颜色宏定义
#define kStatusTableViewCellControlSpacing 10 //控件间距
#define kStatusTableViewCellBackgroundColor KCColor(251,251,251)
#define kStatusGrayColor KCColor(50,50,50)
#define kStatusLightGrayColor KCColor(120,120,120)

#define kStatusTableViewCellAvatarWidth 80 //头像宽度
#define kStatusTableViewCellAvatarHeight kStatusTableViewCellAvatarWidth //头像高度


#define kStatusTableViewCellImageWidth 40
#define kStatusTableViewCellImageHeight kStatusTableViewCellImageWidth

#define kStatusTableViewCellUserNameFontSize 14
#define kStatusTableViewCellMbTypeWidth 13 //会员图标宽度
#define kStatusTableViewCellMbTypeHeight kStatusTableViewCellMbTypeWidth
#define kStatusTableViewCellCreateAtFontSize 12
#define kStatusTableViewCellSourceFontSize 12
#define kStatusTableViewCellTextFontSize 14


@interface BYStatusTableViewCell(){
    // 图片加载ImageView
    EGOImageView *_avatar;
    EGOImageView *_image1;
    EGOImageView *_image2;
    EGOImageView *_image3;
    EGOImageView *_image4;
    EGOImageView *_image5;
    EGOImageView *_image6;
    EGOImageView *_image7;
    EGOImageView *_image8;
    EGOImageView *_image9;
    NSMutableArray* images;
//    EGOImageView *_mbType;
    
    UILabel *_userName;
    UILabel *_createAt;
    UILabel *_source;
    UILabel *_text;
}

@end

@implementation BYStatusTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

#pragma mark 初始化视图
-(void)initSubView{
    
    images = [NSMutableArray new];
    //头像控件
    _avatar=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage new]];
    [self.contentView addSubview:_avatar];
   
    
    
    _image1=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage new]];
    [self.contentView addSubview:_image1];
     [images addObject:_image1];
    
    _image2=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage new]];
    [self.contentView addSubview:_image2];
     [images addObject:_image2];
    
    _image3=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage new]];
    [self.contentView addSubview:_image3];
     [images addObject:_image3];
    
    _image4=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage new]];
    [self.contentView addSubview:_image4];
     [images addObject:_image4];
    
    _image5=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage new]];
    [self.contentView addSubview:_image5];
     [images addObject:_image5];
    
    _image6=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage new]];
    [self.contentView addSubview:_image6];
     [images addObject:_image6];
    
    _image7=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage new]];
    [self.contentView addSubview:_image7];
     [images addObject:_image7];
    
    _image8=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage new]];
    [self.contentView addSubview:_image8];
     [images addObject:_image8];
    
    _image9=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage new]];
    [self.contentView addSubview:_image9];
     [images addObject:_image9];
    //用户名
    _userName=[[UILabel alloc]init];
    _userName.textColor=kStatusGrayColor;
    _userName.font=[UIFont systemFontOfSize:kStatusTableViewCellUserNameFontSize];
    [self.contentView addSubview:_userName];
//    //会员类型
//    _mbType=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage new]];
//    [self.contentView addSubview:_mbType];
    //日期
    _createAt=[[UILabel alloc]init];
    _createAt.textColor=kStatusLightGrayColor;
    _createAt.font=[UIFont systemFontOfSize:kStatusTableViewCellCreateAtFontSize];
    [self.contentView addSubview:_createAt];
    //设备
    _source=[[UILabel alloc]init];
    _source.textColor=kStatusLightGrayColor;
    _source.font=[UIFont systemFontOfSize:kStatusTableViewCellSourceFontSize];
    [self.contentView addSubview:_source];
    //内容
    _text=[[UILabel alloc]init];
    _text.textColor=kStatusGrayColor;
    _text.font=[UIFont systemFontOfSize:kStatusTableViewCellTextFontSize];
    _text.numberOfLines=0;
    //    _text.lineBreakMode=NSLineBreakByWordWrapping;
    [self.contentView addSubview:_text];
}

#pragma mark 设置微博
-(void)setStatus:(Status *)status{
    
    if (status.retweetedStatus != NULL) {
        NSLog(@"转发微博不为空");
    } else {
        NSLog(@"转发微博为空");
    }
    
    if (status.pic_urls != NULL) {
        for (NSDictionary *temp in  status.pic_urls) {
            NSLog(@"temp is %@", [temp valueForKey:@"thumbnail_pic"]);
        }
    } else {
        NSLog(@"图片为空");
    }
     
    //设置头像大小和位置
    CGFloat avatarX = 10, avatarY = 10;
    CGRect avatarRect = CGRectMake(avatarX, avatarY, kStatusTableViewCellAvatarWidth, kStatusTableViewCellAvatarHeight);
    
//    NSLog(@"photo is %@", status.user.avatarLarge);
    _avatar.imageURL = [NSURL URLWithString:status.user.avatarLarge];
    _avatar.frame = avatarRect;
    
    
    //设置会员名称大小和位置
    CGFloat userNameX = CGRectGetMaxX(_avatar.frame) + kStatusTableViewCellControlSpacing ;
    CGFloat userNameY = avatarY;
    //根据文本内容取得文本占用空间大小
    CGSize userNameSize = [status.user.screenName sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kStatusTableViewCellUserNameFontSize]}];
    CGRect userNameRect = CGRectMake(userNameX, userNameY, userNameSize.width,userNameSize.height);
    _userName.text=status.user.screenName;
    _userName.frame=userNameRect;
    
    
//    //设置会员图标大小和位置
//    CGFloat mbTypeX=CGRectGetMaxX(_userName.frame)+kStatusTableViewCellControlSpacing;
//    CGFloat mbTypeY=avatarY;
//    CGRect mbTypeRect=CGRectMake(mbTypeX, mbTypeY, kStatusTableViewCellMbTypeWidth, kStatusTableViewCellMbTypeHeight);
////    _mbType.image=[UIImage imageNamed:status.user.verifiedReason];
//    
//    _mbType.imageURL = [NSURL URLWithString:status.bmiddlePic];
//    _mbType.frame=mbTypeRect;
    
    
    
    
    
    //设置微博内容大小和位置
    CGFloat textX = userNameX;
    CGFloat textY = CGRectGetMaxY(_userName.frame) + kStatusTableViewCellControlSpacing;
    CGFloat textWidth = self.frame.size.width - kStatusTableViewCellControlSpacing * 2;
    CGSize textSize=[status.text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kStatusTableViewCellTextFontSize]} context:nil].size;
    CGRect textRect = CGRectMake(textX, textY, textSize.width, textSize.height);
    _text.text = status.text;
    
    _text.frame = textRect;
     NSLog(@"_text is %@", _text.text);
    
    
    
    //设置发布日期大小和位置
    CGSize createAtSize=[status.createdAt sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kStatusTableViewCellCreateAtFontSize]}];
    CGFloat createAtX = userNameX;
    CGFloat createAtY = CGRectGetMaxY(_text.frame)+ kStatusTableViewCellControlSpacing;
    CGRect createAtRect = CGRectMake(createAtX, createAtY, createAtSize.width, createAtSize.height);
    _createAt.text = status.createdAt;
    _createAt.frame = createAtRect;
    
    
    //设置设备信息大小和位置
    CGSize sourceSize = [status.source sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kStatusTableViewCellSourceFontSize]}];
    CGFloat sourceX = userNameX;//CGRectGetMaxX(_createAt.frame) ;
    CGFloat sourceY = createAtY + kStatusTableViewCellControlSpacing;
    CGRect sourceRect = CGRectMake(sourceX, sourceY, sourceSize.width,sourceSize.height);
    _source.text = status.source;
    _source.frame = sourceRect;
    
//   
//    NSString* temp1;
//    if (status.pic_urls != NULL) {
//        for (NSDictionary *temp in  status.pic_urls) {
//            NSLog(@"temp is %@", [temp valueForKey:@"thumbnail_pic"]);
//            temp1 = [temp valueForKey:@"thumbnail_pic"];
//           
//        }
//    }
    
    
    NSUInteger size = status.pic_urls.count;
    NSLog(@"pic's count is %lu", (unsigned long)size);
          NSLog(@"EGOImageView's images is %@", images);
//          NSLog(@"EGOImageView's images coount is %@", images.count);
    CGRect imageSizeCount;
    
    for (int i = 0; i< size; i++) {
    
      CGRect imageSize = CGRectMake(userNameX + kStatusTableViewCellControlSpacing* (i %3), sourceY+ kStatusTableViewCellControlSpacing * (i / 3 + 2), kStatusTableViewCellImageWidth , kStatusTableViewCellImageHeight );
       EGOImageView  *image = [images objectAtIndex:i];
          NSLog(@"EGOImageView's image is %@", image);
           NSLog(@"EGOImageView's url is %@", [status.pic_urls objectAtIndex:i]);
        image.imageURL = [NSURL URLWithString:[[status.pic_urls objectAtIndex:i] valueForKey: @"thumbnail_pic"]];
        image.frame = imageSize;
        imageSizeCount = imageSize;
    }
//    CGRect imageSize = CGRectMake(userNameX, sourceY+ kStatusTableViewCellControlSpacing, kStatusTableViewCellImageWidth, kStatusTableViewCellImageHeight);
//    _image.imageURL = [NSURL URLWithString:temp1];
//    _image.frame = imageSize;
    
    if (status.pic_urls.count == 0) {
        imageSizeCount = sourceRect;
        
    } else {
        
        imageSizeCount = ((EGOImageView*)[images objectAtIndex:(status.pic_urls.count - 1)]).frame;
    }
    _height = CGRectGetMaxY(imageSizeCount)+kStatusTableViewCellControlSpacing;
}

#pragma mark 重写选择事件，取消选中
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
}
@end

