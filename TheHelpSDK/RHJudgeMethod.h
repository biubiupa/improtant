//
//  RHJudgeMethod.h
//  DinQinChuanGan
//
//  Created by malf on 2018/3/9.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHJudgeMethod : UIView




//判断手机号是否合法
+ (BOOL)checkPhone:(NSString *)phoneNumber;

//邮箱是否合法
+ (BOOL)checkEmail:(NSString *)email;







@end
