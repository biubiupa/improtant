//
//  RHMoreAreaViewController.h
//  DinQinChuanGan
//
//  Created by malf on 2018/4/24.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHMoreAreaViewController : UIViewController
@property (nonatomic, copy) NSString *textTitle;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *areaList;

@end
