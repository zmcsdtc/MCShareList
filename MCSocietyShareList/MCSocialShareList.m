//
//  MCSocialShareList.m
//  MCSocietyShareList
//
//  Created by ZMC on 16/4/3.
//  Copyright © 2016年 Zmc. All rights reserved.
//

#import "MCSocialShareList.h"
#import "MCButton.h"
#import "UIView+Extension.h"
#import <POP.h>
/**
 *  窗口透明度
 */
#define BGALPHA 0.2
/**
 *  窗口黑色
 */
#define BGCOLOR [UIColor blackColor]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//一般情况下的空隙
#define NORMAL_SPACE 10
//背景动画事件
#define BG_DURATION 0.15

#define BTN_DURATION 0.1

@implementation MCSocialShareList

static UIWindow*_window;
static UIView*_bgView;
-(instancetype)initListByTitles:(NSArray *)titiles images:(NSArray *)images{
    if (self=[super init]) {
        self.userInteractionEnabled = YES;
        [self creatWindow];
        [self creatListBy:titiles images:images];
    }
    return self;
}

#pragma mark---创建窗口
- (void) creatWindow{
    _window = [[UIWindow alloc] init];
    _window.frame = [UIScreen mainScreen].bounds;
    _window.backgroundColor = [BGCOLOR colorWithAlphaComponent:BGALPHA];
    _window.windowLevel=UIWindowLevelAlert;
    _window.hidden=NO;
}

- (void)creatListBy:(NSArray*)titles images:(NSArray*)images{
    NSInteger maxCols=4;
    //按钮的尺寸
    CGFloat buttonW=72;
    CGFloat buttonH=buttonW+20;
    NSInteger count=titles.count;
    //    CGFloat space=(SCREEN_WIDTH-count*buttonW)/count+1;
    CGFloat space=0;
    if (count>maxCols) {
        space=(SCREEN_WIDTH-maxCols*buttonW)/(maxCols+1);
    }
    else{
        space=(SCREEN_WIDTH-count*buttonW)/(count+1);
    }
    //底部取消按钮的尺寸
    CGFloat cancelBtnH=35;
    CGFloat cancelBtnW=SCREEN_WIDTH/3;
    
    //背景view,存放按钮
    UIView*bgView=[[UIView alloc]init];
    CGFloat bgViewW=SCREEN_WIDTH;
    bgView.userInteractionEnabled=YES;
    CGFloat bgViewH=NORMAL_SPACE+(NORMAL_SPACE+buttonH)*(count/maxCols+1)+cancelBtnH+NORMAL_SPACE;
    bgView.backgroundColor=[UIColor clearColor];
    bgView.frame=CGRectMake(0, SCREEN_HEIGHT, bgViewW, bgViewH);
    [self addSubview:bgView];
    [UIView animateWithDuration:BG_DURATION animations:^{
        CGRect frame=bgView.frame;
        frame.origin.y=SCREEN_HEIGHT-bgViewH;
        bgView.frame=frame;
    }];
    _bgView=bgView;
    
    MCButton*canBtn=[[MCButton alloc]initWithFrame:CGRectMake((bgViewW-cancelBtnW)/2, bgViewH-cancelBtnH-NORMAL_SPACE, cancelBtnW, cancelBtnH)];
    [canBtn setTitle:@"取消" forState:0];
    [canBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:canBtn];
    
    CGFloat buttonStartX=space;
    CGFloat buttonStartY=NORMAL_SPACE;
    for (NSInteger i=0; i<count; i++) {
        MCButton*btn=[[MCButton alloc]init];
        [btn setImage:[UIImage imageNamed:images[i]] forState:0];
        [btn setTitle:titles[i] forState:0];
        btn.style=MCStyleImageTopAndBottom;
        btn.titleRatio=20*1.0/buttonH;
        btn.isClickAnimation=YES;
        [btn addTarget:self action:@selector(clickThisBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        btn.tag=100+i;
        
        //布局
        NSInteger row=i/maxCols;
        NSInteger col=i%maxCols;
        CGFloat buttonX=buttonStartX+(space+buttonW)*col;
        CGFloat buttonEndY=buttonStartY+row*(buttonH+NORMAL_SPACE);
        CGFloat buttonBeginY=bgViewH;
        //动画类型,改变frame
        POPSpringAnimation*anim=[POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        
        anim.fromValue=[NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue=[NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness=10;
        anim.springSpeed=10;
        anim.beginTime=CACurrentMediaTime()+BTN_DURATION*i;
        [btn pop_addAnimation:anim forKey:@"AnnimChangeFrame"];
    }
    [_window addSubview:self];
    
}
- (void) layoutSubviews{
    self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

#pragma mark-按钮点击事件
- (void)clickThisBtn:(UIButton*)btn{
    NSInteger index=btn.tag-100;
    [self cancelWithCompletionBlock:^{
        if (self.completeBlock) {
            self.completeBlock(index);
        }
    }];
}
/**
 *  取消
 */
- (void)clickCancel{
    [self  cancelWithCompletionBlock:nil];
}
/**
 *  点击消失
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self  cancelWithCompletionBlock:nil];
}
#pragma mark-退出动画的Block,其他的退出都依据这个方法
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    self.userInteractionEnabled = NO;
    int beginIndex = 1;
    for (int i = beginIndex; i<_bgView.subviews.count; i++) {
        UIView *subview = _bgView.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + SCREEN_HEIGHT;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * BTN_DURATION;
        [subview pop_addAnimation:anim forKey:nil];
        if (i == _bgView.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [UIView animateWithDuration:BG_DURATION animations:^{
                    CGRect frame=_bgView.frame;
                    frame.origin.y=SCREEN_HEIGHT;
                    _bgView.frame=frame;
                } completion:^(BOOL finished) {
                    _window.hidden=YES;
                    _window = nil;
                }];
                if (completionBlock) {
                    completionBlock();
                }
            }];
        }
    }
}

@end
