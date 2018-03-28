//
//  RHMoveAreaEquipViewController.h
//  DinQinChuanGan
//
//  Created by malf on 2018/3/23.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^deleteBlock)(NSString *zeroStr);

@interface RHDeleteAreaEquipViewController : UIViewController
@property (nonatomic, assign) NSInteger areaId;
@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, copy) deleteBlock backBlock;

@end
