//
//  RHJudgeMethod.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/9.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHJudgeMethod.h"

@implementation RHJudgeMethod


//判断手机号是否合法
+ (BOOL)checkPhone:(NSString *)phoneNumber

{
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([pred evaluateWithObject:phoneNumber])
    {
        return YES;
    }else {
        return NO;
    }
}

//邮箱是否合法
+ (BOOL)checkEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}



@end
