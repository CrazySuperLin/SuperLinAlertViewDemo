//
//  UIImage+Blur.h
//  NiHongDeng
//
//  Created by CheerHi on 15/5/19.
//  Copyright (c) 2015年 Mr林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)

- (UIImage *)applyBlurWithCrop:(CGRect) bounds resize:(CGSize) size blurRadius:(CGFloat) blurRadius tintColor:(UIColor *) tintColor saturationDeltaFactor:(CGFloat) saturationDeltaFactor maskImage:(UIImage *) maskImage;

@end
