//
//  RHIHAITableViewCell.h
//  DinQinChuanGan
//
//  Created by malf on 2018/3/29.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHIHAITableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *corLabel;
@property (nonatomic, strong) UILabel *ihaiLabel;
@property (nonatomic, strong) UILabel *sPMLabel;
@property (nonatomic, strong) UILabel *hPMLabel;
@property (nonatomic, strong) CAShapeLayer *bacShapeLayer;
@property (nonatomic, strong) CAShapeLayer *frontShapeLayer;
@property (nonatomic, copy) NSDictionary *dataDict;


@end
