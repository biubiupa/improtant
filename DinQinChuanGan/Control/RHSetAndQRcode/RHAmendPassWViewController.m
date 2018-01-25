//
//  RHAmendPassWViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/5.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHAmendPassWViewController.h"
#import "Header.h"

@interface RHAmendPassWViewController ()

@end

@implementation RHAmendPassWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self lauoutViews];
}

//处理视图
- (void)lauoutViews {
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.title=@"重置密码";
}


@end
