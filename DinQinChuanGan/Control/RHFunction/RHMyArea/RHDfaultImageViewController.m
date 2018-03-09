//
//  RHDfaultImageViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/2/2.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHDfaultImageViewController.h"

@interface RHDfaultImageViewController ()

@end

@implementation RHDfaultImageViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - layoutViews
- (void)layoutViews {
    self.view.backgroundColor=[UIColor purpleColor];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationItem.title=@"选取墙纸";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
