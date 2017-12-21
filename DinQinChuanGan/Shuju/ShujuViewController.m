//
//  ViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/14.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "ShujuViewController.h"
#import "Masonry.h"

@interface ShujuViewController ()

@end

@implementation ShujuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    UIImage *image=[UIImage imageNamed:@"xunzhang"];
    UIImageView *imageView=[[UIImageView alloc] initWithImage:image];
    imageView.center=self.view.center;
    imageView.bounds=CGRectMake(0, 0, 37, 55);
    [self.view addSubview:imageView];
}

//修改状态栏（也就是手机运营商和电池所在的那栏）的风格，以下为亮色，系统默认的是暗色；
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
////下面为隐藏状态栏
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
