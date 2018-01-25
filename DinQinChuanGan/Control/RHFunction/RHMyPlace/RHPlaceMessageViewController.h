//
//  RHPlaceMessageViewController.h
//  DinQinChuanGan
//
//  Created by malf on 2018/1/19.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHPlaceMessageViewController : UIViewController
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placeName;
@property (nonatomic, assign) NSInteger placeArea;
@property (nonatomic, assign) NSInteger deviceNum;
@property (nonatomic, assign) NSInteger placeId;

@end
