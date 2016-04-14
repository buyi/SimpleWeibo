//
//  ImageViewController.m
//  SimpleWeibo
//
//  Created by buyi on 16/4/14.
//  Copyright © 2016年 buyi. All rights reserved.
//

#import "ImageViewController.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"

@interface ImageViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    UIImagePickerController* imagepicker;
    UIImageView* imageView;
}

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imagepicker = [[UIImagePickerController alloc] init];
    imagepicker.delegate = self;
    // Do any additional setup after loading the view.
    
    UIButton *btn1 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    btn1.frame = CGRectMake(60.0, 237.0, 200.0, 32.0);
    [btn1 setTitle:@"从媒体库中选取图片" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(picker) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn2 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(60.0, 290.0, 200.0, 32.0);
    [btn2 setTitle:@"从相机获取图片" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(picker1) forControlEvents:UIControlEventTouchUpInside];
    
    imageView = [UIImageView new];
    
    CGRect imageSize = CGRectMake(60, 100, 80 , 80 );
    imageView.frame = imageSize;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:btn1];
     [self.view addSubview:btn2];
      [self.view addSubview:imageView];
}

// 从照片库里面选取

-(void)picker

{
    
    imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagepicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    imagepicker.allowsEditing = YES;
    [self presentModalViewController:imagepicker animated:YES];
}


- (WBMessageObject *)messageToShare:(NSData*) data
{
    WBMessageObject *message = [WBMessageObject message];
    
    //    if (self.textSwitch.on)
    //    {
    message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    //    }
    
    //    if (self.imageSwitch.on)
    //    {
    WBImageObject *image = [WBImageObject object];
    image.imageData = data;
    message.imageObject = image;
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

// 从相机获取
-(void)picker1
{
    
    imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagepicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagepicker.allowsEditing = YES;
    [self presentModalViewController:imagepicker animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 初始化选取
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    imageView.image = image;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);//UIImagePNGRepresentation(image);
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare:imageData] authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
//    [self messageToShare:imageData];
    [picker dismissModalViewControllerAnimated:YES];
}
// 完成选取

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
