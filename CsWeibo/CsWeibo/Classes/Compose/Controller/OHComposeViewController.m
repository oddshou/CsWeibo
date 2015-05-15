//
//  OHComposeViewController.m
//  CsWeibo
//
//  Created by niuwan on 15/5/14.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#import "OHComposeViewController.h"
#import "OHAccountTools.h"
#import "OHAccount.h"
#import "UIView+Extension.h"
#import "OHPlaceHolderTextView.h"
#import "NSString+Extension.h"
#import "OHCompseToolbar.h"
#import "OHStatusPhotosView.h"
#import "OHComposePhotosView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"


@interface OHComposeViewController () <OHComposeToolbarDelegate, UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 输入控件 */
@property (nonatomic, weak) OHPlaceHolderTextView *textView;
/** 键盘顶部的工具条 */
@property (nonatomic, weak) OHCompseToolbar *toolbar;
/** 相册（存放拍照或者相册中选择的图片） */
@property (nonatomic, weak) OHComposePhotosView *photosView;


@end

@implementation OHComposeViewController


#pragma mark 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏内容
    [self setupNav];
    //添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
    
    // 添加相册
    [self setupPhotosView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)dealloc
{
    [OHNotificationCenter removeObserver:self];
}

#pragma mark 初始化方法
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //设置title
    NSString *name = [OHAccountTools account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.numberOfLines = 0;
        NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        //创建一个带有属性的字符串
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        //添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    }else{
        self.title = prefix;
    }
    
}

- (void)setupTextView
{
    //textView继承自uiscrollView contentInset.top默认会等于64
    OHPlaceHolderTextView *textView = [[OHPlaceHolderTextView alloc] init];
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;   //监听 下拉
    //设置 placeHolder View
    UILabel *placeholder = [[UILabel alloc] init];
    placeholder.textColor = [UIColor grayColor];
    placeholder.font = [UIFont systemFontOfSize:15];
    placeholder.numberOfLines = 0;
    placeholder.text = @"分享新鲜事...";
    CGSize size = [placeholder.text sizeWithFont:placeholder.font maxW:self.view.width];
    placeholder.frame = (CGRect){{6, 6}, size};
    [textView setLabelPlaceholder:placeholder];
    
    [self.view addSubview:textView];
    self.textView = textView;
    //监听文字改变，没有文字不可以点击发送
    [OHNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    //监听键盘frame改变,调整toolbar的位置
    [OHNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

- (void)setupToolbar
{
    OHCompseToolbar *toolbar = [[OHCompseToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
}

- (void)setupPhotosView
{
    OHComposePhotosView *photosView = [[OHComposePhotosView alloc] init];
    photosView.y = 100;
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
    
    
}

#pragma mark 事件方法
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    if (self.photosView.photos.count) {
        [self sendWithImage];
    }else{
        [self sendWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    /**
     notification.userInfo = @{
     // 键盘弹出\隐藏后的frame
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 352}, {320, 216}},
     // 键盘弹出\隐藏所耗费的时间
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     // 键盘弹出\隐藏动画的执行节奏（先快后慢，匀速）
     UIKeyboardAnimationCurveUserInfoKey = 7
     }
     */
    //可以先打印信息查看回传数据
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
//        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
//            self.toolbar.y = self.view.height - self.toolbar.height;
//        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
//        }
        NSLog(@"%@", NSStringFromCGRect(self.toolbar.frame));
    }];
    
}

#pragma mark 辅助方法
/**
 * 发布带有图片的微博
 */
- (void)sendWithImage
{
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    /**	pic true binary 微博的配图。*/
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [OHAccountTools account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

/**
 * 发布没有图片的微博
 */
- (void)sendWithoutImage
{
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [OHAccountTools account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)openAlbum
{
    // 如果想自己写一个图片选择控制器，得利用AssetsLibrary.framework，利用这个框架可以获得手机上的所有相册图片
    // UIImagePickerControllerSourceTypePhotoLibrary > UIImagePickerControllerSourceTypeSavedPhotosAlbum
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        return;
    }
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}


#pragma mark delegate方法
/**
 *  composeToolbar button 点击代理方法
 *
 *  @param toolbar    被点击的toolbar
 *  @param buttonType 所点击的按钮编号
 */
- (void)composeToolbar:(OHCompseToolbar *)toolbar didClickButton:(OHCompseToolbarButtonType)buttonType
{
    switch (buttonType) {
        case OHComposeToolbarButtonTypeCamera: // 拍照
//            [self openCamera];
            break;
            
        case OHComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        case OHComposeToolbarButtonTypeMention: // @
            NSLog(@"--- @");
            break;
            
        case OHComposeToolbarButtonTypeTrend: // #
            NSLog(@"--- #");
            break;
            
        case OHComposeToolbarButtonTypeEmotion: // 表情\键盘
            NSLog(@"--- 表情");
            break;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView endEditing:YES];
}

/**
 * 从UIImagePickerController选择完图片后就调用（拍照完毕或者选择相册图片完毕）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //info中包含了所选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
//    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
//    [self.view addSubview:imageview];
    
    [self.photosView addPhoto:image];
}

@end
