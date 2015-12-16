//
//  SuperLinAlertView.m
//  test
//
//  Created by CheerHi on 15/12/11.
//  Copyright © 2015年 yiliao. All rights reserved.
//

#import "SuperLinAlertView.h"
#import "UIImage+Blur.h"
#import <QuartzCore/QuartzCore.h>

#define MY_ALERTVIEW_WIDTH 295.0f
#define MY_THEMEIMG_WIDTH 32.0f
#define MY_THEMEIMG_HEIGHT 32.0f
#define MY_TOP_RANGE 16.0f
#define MY_MIDDLE_RANGE 23.0f
#define MY_BOTTOM_RANGE 20.0f
#define MY_LINEVIEW_HEIGHT 0.5f
#define MY_BUTTON_HEIGHT 45.0f

#define kKyoBlurRadius  10.0f
#define kKyoDeltaFactor 2.0f
#define kKyoNormalClickColor        [UIColor colorWithWhite:1.0f alpha:0.9f]
#define kKyoHightlightClickColor    [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:0.9f]

@interface SuperLinAlertView () {
    
    BOOL _leftLeave;
    
}

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;


@end

@implementation SuperLinAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define MY_TITLE_OFFSET 20.0f
#define MY_TITLE_WIDTH 280.0f

#pragma mark - init

- (id)initWithThemeImage:(UIImage *)themeImg contentStr:(NSString *)contentStr segOne:(NSString *)segOneStr segTwo:(NSString *)segTwoStr blurBGImg:(UIImage *)blurBGImg actionType:(MYAlertViewActionType)type
{
    if (self = [super init]) {
        
        
        UIImageView *bgIMGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MY_ALERTVIEW_WIDTH, 151)];
        [self addSubview:bgIMGView];
        
        

        if (blurBGImg) {
            NSLog(@"is___%@",blurBGImg);
            [bgIMGView setImage:blurBGImg];
        }
        else {
            NSLog(@"no___%@",blurBGImg);
            bgIMGView.backgroundColor = [UIColor whiteColor];
        }
        
        UIImageView *themeIV = [[UIImageView alloc] initWithFrame:CGRectMake((MY_ALERTVIEW_WIDTH-MY_THEMEIMG_WIDTH)/2.0, MY_TOP_RANGE, MY_THEMEIMG_WIDTH, MY_THEMEIMG_HEIGHT)];
        themeIV.image = themeImg;
        [self addSubview:themeIV];
        
        
//        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
//        CGSize size = [contentStr boundingRectWithSize:CGSizeMake(MY_ALERTVIEW_WIDTH-20, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, MY_TOP_RANGE+MY_THEMEIMG_HEIGHT+MY_MIDDLE_RANGE, MY_ALERTVIEW_WIDTH-20, 14)];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = contentStr;
        titleLab.font = [UIFont systemFontOfSize:14];
        titleLab.textColor = [UIColor grayColor];
        [self addSubview:titleLab];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, MY_TOP_RANGE+MY_THEMEIMG_HEIGHT+MY_MIDDLE_RANGE+14+MY_BOTTOM_RANGE,MY_ALERTVIEW_WIDTH, MY_LINEVIEW_HEIGHT)];
        lineView.backgroundColor = [UIColor blackColor];
        [self addSubview:lineView];
        
        
        //        UIView *lineViewTwo = [[UIView alloc]initWithFrame:CGRectMake(0, 216+MY_TITLEVIEW_HEIGHT, MY_ALERTVIEW_WIDTH, MY_LINEVIEW_HEIGHT)];
        //        lineViewTwo.backgroundColor = [UIColor blackColor];
        //        [self addSubview:lineViewTwo];
        
        
        UIButton *segOne = [UIButton buttonWithType:UIButtonTypeCustom];
        segOne.frame = CGRectMake(0, MY_TOP_RANGE+MY_THEMEIMG_HEIGHT+MY_MIDDLE_RANGE+14+MY_BOTTOM_RANGE+1, MY_ALERTVIEW_WIDTH*0.5, MY_BUTTON_HEIGHT);
        [segOne setTitle:segOneStr forState:UIControlStateNormal];
        segOne.titleLabel.font = [UIFont systemFontOfSize:16];
        [segOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [segOne addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:segOne];
        
        UIButton *segTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        segTwo.frame = CGRectMake(MY_ALERTVIEW_WIDTH*0.5, MY_TOP_RANGE+MY_THEMEIMG_HEIGHT+MY_MIDDLE_RANGE+14+MY_BOTTOM_RANGE+1, MY_ALERTVIEW_WIDTH*0.5, MY_BUTTON_HEIGHT);
        [segTwo setTitle:segTwoStr forState:UIControlStateNormal];
        segTwo.titleLabel.font = [UIFont systemFontOfSize:16];
        [segTwo setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [segTwo addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:segTwo];
        
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        
        self.layer.cornerRadius = 16.0f;
        self.clipsToBounds = YES;
        
    }
    return self;
}


#pragma mark - BtnClickBlock

- (void)leftBtnClicked:(id)sender
{
    _leftLeave = YES;
    [self dismissAlert];
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)rightBtnClicked:(id)sender
{
    _leftLeave = NO;
    [self dismissAlert];
    if (self.rightBlock) {
        self.rightBlock();
    }

}

#pragma mark - Custom

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    
    topVC.view.backgroundColor = [UIColor redColor];
    
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - MY_ALERTVIEW_WIDTH) * 0.5, (CGRectGetHeight(topVC.view.bounds) - 151) * 0.5, 0, 0);
    
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview
{
    
    UIViewController *topVC = [self appRootViewController];
    
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - MY_ALERTVIEW_WIDTH) * 0.52, (CGRectGetHeight(topVC.view.bounds) - 151) * 0.5, 0, 0);
    
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        self.backImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
        
        [self.backImageView removeFromSuperview];
        self.backImageView = nil;
    }];
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];

    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - MY_ALERTVIEW_WIDTH) * 0.5, (CGRectGetHeight(topVC.view.bounds) - 151) * 0.5, MY_ALERTVIEW_WIDTH, 151);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
        self.backImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    } completion:^(BOOL finished) {
    }];
    
    
    [super willMoveToSuperview:newSuperview];
}

/*
#pragma mark - Custom

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    
    topVC.view.backgroundColor = [UIColor redColor];
    
    
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - MY_ALERTVIEW_WIDTH) * 0.5, - 151 - 30, MY_ALERTVIEW_WIDTH, 151);
    
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview
{
    
    UIViewController *topVC = [self appRootViewController];
    
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - MY_ALERTVIEW_WIDTH) * 0.5, CGRectGetHeight(topVC.view.bounds), MY_ALERTVIEW_WIDTH, 151);

    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        self.backImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
        if (_leftLeave) {
            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
        }else {
            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        }
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
        
        [self.backImageView removeFromSuperview];
        self.backImageView = nil;
    }];
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - MY_ALERTVIEW_WIDTH) * 0.5, (CGRectGetHeight(topVC.view.bounds) - 151) * 0.5, MY_ALERTVIEW_WIDTH, 151);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
        self.backImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    } completion:^(BOOL finished) {
    }];

    
    [super willMoveToSuperview:newSuperview];
}

 */

@end
