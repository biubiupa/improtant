//
//  RHMoveTwoStepViewController.h
//  DinQinChuanGan
//
//  Created by malf on 2018/3/22.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHMoveTwoStepViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *areaList;
@property (nonatomic, copy) NSString *placeName;
@property (nonatomic, assign) NSInteger areaId;

@end
