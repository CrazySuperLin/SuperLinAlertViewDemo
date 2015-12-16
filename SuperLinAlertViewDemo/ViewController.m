//
//  ViewController.m
//  SuperLinAlertViewDemo
//
//  Created by CheerHi on 15/12/11.
//  Copyright © 2015年 MrLin. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Blur.h"
#import "SuperLinAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

#define kKyoBlurRadius  10.0f
#define kKyoDeltaFactor 2.0f
#define kKyoNormalClickColor        [UIColor colorWithWhite:1.0f alpha:0.7f]


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImgView.image = [UIImage imageNamed:@"bgImg.jpg"];
    [self.view addSubview:bgImgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.center = self.view.center;
    btn.bounds = CGRectMake(0, 0, 100, 40);
    [btn setTitle:@"提示" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - BtnAction

-(void)btnAction:(id)sender
{
    // 实现毛玻璃效果需要的 （截图＋图片处理）
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height), NO, 1);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    __block UIImage *imgCancelBlurNormal = nil;
    
    CGRect sVRect = CGRectMake(([[UIScreen mainScreen] bounds].size.width-295)/2.0, ([[UIScreen mainScreen] bounds].size.height-151)/2.0, 295, 151);
    
    imgCancelBlurNormal = [snapshot applyBlurWithCrop:sVRect resize:sVRect.size blurRadius:kKyoBlurRadius tintColor:kKyoNormalClickColor saturationDeltaFactor:kKyoDeltaFactor maskImage:nil];
    
    
    //SuperLinAlertView 实例化 （使用方法） 注释掉的是没有实现毛玻璃效果的：参数blurBGImg设置为nil即可
    
//    SuperLinAlertView *view = [[SuperLinAlertView alloc]initWithThemeImage:[UIImage imageNamed:@"提示.png"] contentStr:@"是否退出登录？" segOne:@"取消" segTwo:@"退出" blurBGImg:imgCancelBlurNormal actionType:MYAlertViewActionDefault];
    
    SuperLinAlertView *view = [[SuperLinAlertView alloc]initWithThemeImage:[UIImage imageNamed:@"提示.png"] contentStr:@"是否退出登录？" segOne:@"取消" segTwo:@"退出" blurBGImg:nil actionType:MYAlertViewActionExpo];
    
    //两个按钮的回调
    
    view.rightBlock = ^(){
        NSLog(@"RightBtnAction");
    };
    view.leftBlock = ^(){
        NSLog(@"LeftBtnAction");
    };
    
    [view show];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
