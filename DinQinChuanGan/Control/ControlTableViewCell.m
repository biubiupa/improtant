//
//  ControlTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2017/12/19.
//  Copyright © 2017年 DST. All rights reserved.
//

#import "ControlTableViewCell.h"
#import "Masonry.h"
#import "ControlCollectionViewCell.h"

@interface ControlTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, copy) NSArray *arrName;
@end

@implementation ControlTableViewCell

#pragma mark - setneedslayout
static NSString *identifier=@"identifier";

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView addSubview:self.collectView];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        这种对上下左右添加的集合约束，insets中为绝对值，自动识别下和上（具体看版本）
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(13, 15, 13, 15));
//        这种分散式对上下左右做约束，要用-区别下和上
        make.top.equalTo(self.contentView).with.offset(13);
        make.left.equalTo(self.contentView).with.offset(15);
        make.bottom.equalTo(self.contentView).with.offset(-13);
        make.right.equalTo(self.contentView).with.offset(-15);
    }];
    
}

#pragma mark - 属性初始化
- (UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.estimatedItemSize=CGSizeMake(90, 85);
        flowLayout.minimumLineSpacing=15;
        flowLayout.minimumInteritemSpacing=5;
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        _collectView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//        _collectView.collectionViewLayout=flowLayout;
        _collectView.delegate=self;
        _collectView.dataSource=self;
        _collectView.backgroundColor=[UIColor whiteColor];
        [_collectView registerClass:[ControlCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    return _collectView;
}

- (NSArray *)arrName {
    if (!_arrName) {
        _arrName=@[@"我的场所", @"我的区域", @"我的设备", @"报警", @"在线报修", @"报告", @"用户管理", @"消息", @"帮助", @"商城"];
    }
    return _arrName;
}

#pragma mark - delegate/datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ControlCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    cell.backgroundColor=[UIColor redColor];
    cell.nameLabel.text=self.arrName[indexPath.row];
    return cell;
}


#pragma mark - setSelected
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
