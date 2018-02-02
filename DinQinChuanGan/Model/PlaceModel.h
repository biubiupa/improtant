//
//  Model.h
//  DinQinChuanGan
//
//  Created by malf on 2018/1/29.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceModel : NSObject
@property (nonatomic, assign) NSInteger placeId;
@property (nonatomic, copy) NSString *placeName;


- (instancetype)initWithDictionary: (NSDictionary *)dict;
+ (instancetype)PlaceWithDictionary: (NSDictionary *)dict;

@end
