//
//  RHEquipMentTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/14.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHEquipMentTableViewCell.h"
#import "Header.h"
#import "RHEquipCollectionViewCell.h"
#import "Masonry.h"

@interface RHEquipMentTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

static NSString *identifier=@"cellid";

@implementation RHEquipMentTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.colorView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(24, 24));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(42);
    }];
    [self.contentView addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 14));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(74);
    }];
    NSString *str=[NSString stringWithFormat:@"%ld",self.deviceList.count];
    if ([str isEqualToString:@"0"]) {
        self.imgView.hidden=NO;
        self.tipsLabel.hidden=NO;
    }else {
        self.imgView.hidden=YES;
        self.tipsLabel.hidden=YES;
    }
}

#pragma mark - delegate,datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *str=[NSString stringWithFormat:@"%ld",self.deviceList.count];
    if ([str isEqualToString:@"0"]) {
        return 0;
    }else {
        return self.deviceList.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RHEquipCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.codeLabel.text=self.deviceList[indexPath.row][@"deviceCode"];
    cell.state=[self.deviceList[indexPath.row][@"state"] integerValue];
    if (cell.state == 1) {
        cell.imageView.image=[UIImage imageNamed:@"online"];
    }else {
        cell.imageView.image=[UIImage imageNamed:@"offline"];
    }
    cell.backgroundColor = BACKGROUND_COLOR;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index=indexPath.row;
    NSDictionary *dict=@{@"index":@(index)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"push" object:self userInfo:dict];
}

#pragma mark - lazyload
- (UIView *)colorView {
    if (!_colorView) {
        _colorView=[[UIView alloc] initWithFrame:CGRectMake(15, 10, 2, 14)];
        _colorView.backgroundColor=CONTROL_COLOR;
    }
    return _colorView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(30, 10, SCREEN_WIDTH - 30, 14)];
        _nameLabel.font=[UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize=CGSizeMake((SCREEN_WIDTH - 40)/3, 87);
        flowLayout.sectionInset=UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH, [self collectionViewHeight]) collectionViewLayout:flowLayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [_collectionView registerClass:[RHEquipCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        _collectionView.backgroundColor=WhiteColor;
    }
    return _collectionView;
}

- (CGFloat)collectionViewHeight {
    if (self.deviceList.count < 4) {
        return 99;
    }else {
        return 186;
    }
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView=[[UIImageView alloc] init];
        _imgView.image=[UIImage imageNamed:@"cry"];
    }
    return _imgView;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel=[[UILabel alloc] init];
        _tipsLabel.text=@"暂无设备~";
        _tipsLabel.font=[UIFont systemFontOfSize:15];
        _tipsLabel.textColor=[UIColor lightGrayColor];
        _tipsLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _tipsLabel;
}



@end
