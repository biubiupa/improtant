//
//  RHPlaceEquipTableViewCell.h
//  DinQinChuanGan
//
//  Created by malf on 2018/3/27.
//  Copyright © 2018年 DST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHPlaceEquipTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, copy) NSArray *deviceList;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
