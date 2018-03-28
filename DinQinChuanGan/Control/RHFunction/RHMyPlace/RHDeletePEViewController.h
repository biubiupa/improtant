//
//  RHDeletePEViewController.h
//  DinQinChuanGan
//
//  Created by malf on 2018/3/27.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^placeEquipBlock) (NSString *string);

@interface RHDeletePEViewController : UIViewController
@property (nonatomic, assign) NSInteger placeId;
@property (nonatomic, copy) NSString *stringTitle;
@property (nonatomic, copy) placeEquipBlock placeBlock;

@end
