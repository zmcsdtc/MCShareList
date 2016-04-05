//
//  MCButton.h
//  FaceBookAnimation_Pop
//
//  Created by ZMC on 16/3/30.
//  Copyright © 2016年 Zmc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    /**
     *  图片和文字上下分布,文字在上
     */
    MCStyleTextTopAndBottom=10,
    /**
     *  图片和文字上下分布,图片在上
     */
    MCStyleImageTopAndBottom,
    /**
     *  图片和文字左右分布,图片在右
     */
    MCStyleImageRightAndLeft,
    /**
     *  图片和文字左右分布,图片在左
     */
    MCStyleTextRightAndLeft,
    
    
}MCButtonStyle;

@interface MCButton : UIButton
/**
 *  文字占比例
 */
@property(assign,nonatomic)CGFloat titleRatio;
/**
 *  按钮布局风格
 */
@property(assign,nonatomic)MCButtonStyle style;
/**
 *  字体大小
 */
@property(strong,nonatomic)UIFont*font;
/**
 *  图片内部布局位置
 */
@property(assign,nonatomic)UIViewContentMode imageMode;
/**
 *  文字内部布局位置
 */
@property(assign,nonatomic)NSTextAlignment textAlignment;
/**
 *  点击动画是否开启
 */
@property(assign,nonatomic)BOOL isClickAnimation;




@end

