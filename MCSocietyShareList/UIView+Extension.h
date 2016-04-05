//
//  MCButton.h
//  FaceBookAnimation_Pop
//
//  Created by ZMC on 16/3/30.
//  Copyright © 2016年 Zmc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

- (void)addCornerWithRadius:(CGFloat)radius withBorderWidth:(CGFloat)borderWidth withBorderColor:(UIColor *)borderColor;

+(UIView*)createLine:(CGRect)frame color:(UIColor*)color;
@end
