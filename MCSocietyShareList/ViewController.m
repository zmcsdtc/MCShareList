//
//  ViewController.m
//  MCSocietyShareList
//
//  Created by ZMC on 16/4/1.
//  Copyright © 2016年 Zmc. All rights reserved.
//

#import "ViewController.h"
#import "MCSocialShareList.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title=@"导航";

}

- (void) test{
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    MCSocialShareList*list=[[MCSocialShareList alloc]initListByTitles:titles images:images];
    
    list.completeBlock=^(NSInteger index){
        NSLog(@"index--=%zd",index);
    };
}


- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self test];

//    [MCSocietyShareList show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
