//
//  RHAirParameterTableViewCell.h
//  DinQinChuanGan
//
//  Created by malf on 2018/3/29.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHAirParameterTableViewCell : UITableViewCell
@property (nonatomic, strong) UITableView *dateTableView;
@property (nonatomic, strong) UITableView *kindTableView;
@property (nonatomic, copy) NSArray *envirLists;

@end
