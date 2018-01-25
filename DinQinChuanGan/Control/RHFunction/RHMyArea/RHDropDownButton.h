//
//  RHDropDownButton.h
//  DinQinChuanGan
//
//  Created by malf on 2018/1/22.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHDropDownButton : UIButton
@property (nonatomic, copy) NSArray *list;
@property (nonatomic, copy) NSString *title;


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title list:(NSArray *)list;
@end



