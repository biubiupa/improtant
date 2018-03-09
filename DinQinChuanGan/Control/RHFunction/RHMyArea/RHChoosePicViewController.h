//
//  RHChoosePicViewController.h
//  DinQinChuanGan
//
//  Created by malf on 2018/1/31.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myBlock)(UIImage *image);

@interface RHChoosePicViewController : UIViewController
@property (nonatomic, copy)myBlock block;

@end
