//
//  Header.h
//  DinQinChuanGan
//
//  Created by malf on 2017/12/19.
//  Copyright © 2017年 DST. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define RECORD_API      @"http://192.168.2.160:8080/diqin_app/record"
#define USER_API        @"http://192.168.2.160:8080/diqin_app/user"
#define MANAGE_API      @"http://192.168.2.160:8080/diqin_app/manage"
#define ASSETSERVER_API @"http://192.168.2.160:8080/upload_user/file/upload"
#define OTHER_API       @"http://192.168.2.160:8080/diqin_app/other"

#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

#define STATUS  [responseObject[@"head"][@"st"] integerValue]
#define MSG     responseObject[@"head"][@"msg"]
#define RESPONSE_BODY   responseObject[@"body"]

#define UserDefaults    [NSUserDefaults standardUserDefaults]
#define UserId  [UserDefaults stringForKey:@"userId"]


#define SYSTEMFONT(f)           [UIFont systemFontOfSize:(f)]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define WhiteColor  [UIColor whiteColor]
#define GrayColor   [UIColor grayColor]
#define LightGrayColor  [UIColor lightGrayColor]
#define DELETEBTN_COLOR [UIColor colorWithRed:224.0/255.0 green:47.0/255.0 blue:85.0/255.0 alpha:1.0]
#define CONTROL_COLOR [UIColor colorWithRed:114.0/255.0 green:132.0/255.0 blue:235.0/255.0 alpha:1.0]
#define BACKGROUND_COLOR [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0]
//#define DEFAULTCOLOR [UIColor colorWithRed:46.0/255.0 green:128.0/255.0 blue:255.0/255.0 alpha:1.0]

#endif /* Header_h */
