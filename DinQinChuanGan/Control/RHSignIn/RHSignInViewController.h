//
//  RHSignInViewController.h
//  DinQinChuanGan
//
//  Created by malf on 2017/12/28.
//  Copyright © 2017年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHControlViewController.h"

typedef void(^boolBlock)(BOOL hiden, NSString *accText, NSString *corporationNum);

@interface RHSignInViewController : UIViewController
@property (nonatomic, strong) boolBlock callbackBlock;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *st;
@end


