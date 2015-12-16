//
//  SuperLinAlertView.h
//  test
//
//  Created by CheerHi on 15/12/11.
//  Copyright © 2015年 yiliao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperLinAlertView : UIView

typedef NS_ENUM(NSInteger, MYAlertViewActionType) {
    MYAlertViewActionDefault    = 0,    // 默认上下动画
    MYAlertViewActionExpo   = 1,       // 中心放大动画，没写完，暂不支持
};

//初始化参数分别为   主题图片；提示内容文字；选项一文字；选项二文字;毛玻璃背景图片。

- (id)initWithThemeImage:(UIImage *)themeImg
              contentStr:(NSString *)contentStr
                  segOne:(NSString *)segOneStr
                  segTwo:(NSString *)segTwoStr
                  blurBGImg:(UIImage *)blurBGImg
              actionType:(MYAlertViewActionType)type;


- (void)show;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;

@end
