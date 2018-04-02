//
//  RHIndexTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/29.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHAirIndexTableViewCell.h"
#import "Header.h"
#import "Masonry.h"
#import "RHJudgeMethod.h"
#import "RHIndexCollectionViewCell.h"

@interface RHAirIndexTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UILabel *airLabel;
@property (nonatomic, strong) UIButton *moreBtn;


@end

@implementation RHAirIndexTableViewCell

static NSString *identifier=@"itemid";

#pragma mark - 初始化，布局
//初始化cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.collectionView];
        [self.contentView addSubview:self.markView];
        [self.contentView addSubview:self.airLabel];
        [self.contentView addSubview:self.moreBtn];
        self.selectionStyle=UITableViewCellSelectionStyleNone;

    }
    
    return self;
}

//布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 202));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(59);
    }];
    [self.markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2, 14));
        make.top.equalTo(self.contentView).with.offset(21);
        make.left.equalTo(self.contentView).with.offset(20);
    }];
    [self.airLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 14));
        make.top.equalTo(self.contentView).with.offset(21);
        make.left.equalTo(self.contentView).with.offset(30);
    }];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.top.equalTo(self.contentView).with.offset(15);
        make.right.equalTo(self.contentView).with.offset(-20);
    }];
}

#pragma mark - delegate,datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RHIndexCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}


#pragma mark - lazyload
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset=UIEdgeInsetsMake(0, 20, 0, 20);
        flowLayout.itemSize=CGSizeMake((SCREEN_WIDTH - 60)/3, 96);
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 202) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor=WhiteColor;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [_collectionView registerClass:[RHIndexCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    return _collectionView;
}

- (UIView *)markView {
    if (!_markView) {
        _markView=[UIView new];
        _markView.backgroundColor=CONTROL_COLOR;
    }
    return _markView;
}

- (UILabel *)airLabel {
    if (!_airLabel) {
        _airLabel=[[UILabel alloc] init];
        _airLabel.textAlignment=NSTextAlignmentLeft;
        _airLabel.font=[UIFont systemFontOfSize:15.0f];
        _airLabel.text=@"空气指数";
    }
    return _airLabel;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        _moreBtn.tintColor=[UIColor blackColor];
    }
    return _moreBtn;
}

@end
