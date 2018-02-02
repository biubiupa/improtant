//
//  Model.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/29.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "PlaceModel.h"

@implementation PlaceModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.placeId=[dict[@"placeId"] integerValue];
        self.placeName=dict[@"placeName"];
    }
    return self;
}

+ (instancetype)PlaceWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}


@end
