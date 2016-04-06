//
//  MCButton.m
//  FaceBookAnimation_Pop
//
//  Created by ZMC on 16/3/30.
//  Copyright © 2016年 Zmc. All rights reserved.
//

#import "MCButton.h"
#import <POP/POP.h>
@implementation MCButton

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.style = MCStyleImageRightAndLeft;
        _isClickAnimation=NO;
        [self addAnimations:_isClickAnimation];
    }
    return self;
}


#pragma mark-根据属性判断动画手势是否添加
- (void)addAnimations:(BOOL)isClickAnimation{
    if (_isClickAnimation) {
        //点下去的动画
        [self addTarget:self action:@selector(scaleToSmall)
       forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(scaleAnimation)
       forControlEvents:UIControlEventTouchUpInside];
    }
    
}
//变小动画
- (void)scaleToSmall
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.75f, 0.75f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}
//抖动恢复动画
- (void)scaleAnimation
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 18.0f;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}


#pragma mark-重写各种内部方法-调整内部的文字布局和图片布局.

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    
    if(self.style == MCStyleTextTopAndBottom)
    {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat H = self.frame.size.height*self.titleRatio;
        CGFloat W = self.frame.size.width;
        
        return CGRectMake(x, y, W, H);
    }
    else if (self.style==MCStyleImageTopAndBottom){
        CGFloat x = 0;
        CGFloat y = self.frame.size.height *(1-self.titleRatio);
        CGFloat W = self.frame.size.width;
        CGFloat H = self.frame.size.height * self.titleRatio;
        return CGRectMake(x, y, W, H);
    }
    else if(self.style==MCStyleImageRightAndLeft)
    {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat H = self.frame.size.height;
        CGFloat W = self.frame.size.width*self.titleRatio;
        return CGRectMake(x, y, W, H);
    }
    else{
        CGFloat x = self.frame.size.width*(1-self.titleRatio);;
        CGFloat y = 0;
        CGFloat H = self.frame.size.height;
        CGFloat W = self.frame.size.width*self.titleRatio;
        return CGRectMake(x, y, W, H);
        
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if(self.style == MCStyleTextTopAndBottom)
    {
        CGFloat x = 0;
        CGFloat y = self.frame.size.height*self.titleRatio;
        CGFloat H = self.frame.size.height*(1-self.titleRatio);
        CGFloat W = self.frame.size.width;
        
        return CGRectMake(x, y, W, H);
    }
    else if (self.style==MCStyleImageTopAndBottom){
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat W = self.frame.size.width;
        CGFloat H = self.frame.size.height * (1-self.titleRatio);
        return CGRectMake(x, y, W, H);
    }
    else if(self.style==MCStyleImageRightAndLeft)
    {
        CGFloat x = self.frame.size.width*self.titleRatio;;
        CGFloat y = 0;
        CGFloat H = self.frame.size.height;
        CGFloat W = self.frame.size.width*(1-self.titleRatio);
        return CGRectMake(x, y, W, H);
    }
    else{
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat H = self.frame.size.height;
        CGFloat W = self.frame.size.width*(1-self.titleRatio);
        return CGRectMake(x, y, W, H);
        
    }
    
}


#pragma mark-重写内部内部设置文字和图片的方法,确立图片优先权.
- (void) setImage:(UIImage *)image forState:(UIControlState)state{
    if (!self.titleRatio) {
        self.titleRatio=0;
    }
    [super setImage:image forState:state];
}



- (void) setTitle:(NSString *)title forState:(UIControlState)state{
    if (!self.imageView.image) {
        self.titleRatio=1;
    }
    [super setTitle:title forState:state];
    [self setTitleColor:[UIColor blackColor] forState:0];
}

//去除高亮反应
- (void) setHighlighted:(BOOL)highlighted{
    
}
#pragma mark--类属性实现
- (void) setTitleRatio:(CGFloat)titleRatio{
    _titleRatio=titleRatio;
    [self layoutIfNeeded];
}

- (void) setFont:(UIFont *)font{
    self.font=font;
    self.titleLabel.font=font;
}
//图片对齐格式
- (void) setImageMode:(UIViewContentMode)imageMode{
    self.imageView.contentMode=imageMode;
}
//文字对齐格式
- (void) setTextAlignment:(NSTextAlignment)textAlignment{
    self.titleLabel.textAlignment=textAlignment;
}

- (void) setIsClickAnimation:(BOOL)isClickAnimation{
    _isClickAnimation=isClickAnimation;
    [self addAnimations:_isClickAnimation];
}
@end
