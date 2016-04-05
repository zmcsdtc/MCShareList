//
//  MCSocialShareList.h
//  MCSocietyShareList
//
//  Created by ZMC on 16/4/3.
//  Copyright © 2016年 Zmc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCSocialShareList : UIView

-(instancetype)initListByTitles:(NSArray*)titiles images:(NSArray*)images;

@property(copy,nonatomic)void(^completeBlock)(NSInteger index);
@end
