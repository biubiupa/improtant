//
//  RHEquipMessageViewController.h
//  DinQinChuanGan
//
//  Created by malf on 2018/3/2.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHEquipMessageViewController : UIViewController
@property (nonatomic, copy) NSArray *totalArr;
@property (nonatomic, copy) NSArray *basiclistArr;
@property (nonatomic, copy) NSArray *spelistArr;
@property (nonatomic, copy) NSArray *acclistArr;
@property (nonatomic, copy) NSArray *listArr;
@property (nonatomic, copy) NSString *deviceCode;
@property (nonatomic, copy) NSString *wifiAdderss;
@property (nonatomic, assign) NSInteger deviceId;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, copy) NSString *numberDaty;

@end
