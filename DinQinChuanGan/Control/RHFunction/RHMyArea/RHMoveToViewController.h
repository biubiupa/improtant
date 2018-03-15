//
//  RHMoveToViewController.h
//  DinQinChuanGan
//
//  Created by malf on 2018/3/13.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^callBackBlock)(NSString *placeName, NSInteger placeId);

@interface RHMoveToViewController : UIViewController
@property (nonatomic, copy) callBackBlock block;

@end
