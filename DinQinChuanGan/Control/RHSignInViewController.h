//
//  RHSignInViewController.h
//  DinQinChuanGan
//
//  Created by malf on 2017/12/28.
//  Copyright © 2017年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlViewController.h"

typedef void(^boolBlock)(BOOL hiden, NSString *accText, NSString *userID);

@interface RHSignInViewController : UIViewController
@property (nonatomic, strong) boolBlock callbackBlock;
@end
