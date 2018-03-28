//
//  RHDeleteEquipTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/26.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHDeleteEquipTableViewCell.h"
#import "Header.h"
#import "RHDeleteEquipCollectionViewCell.h"
#import "Masonry.h"

@interface RHDeleteEquipTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation RHDeleteEquipTableViewCell

static NSString *identifier=@"itemid";
//初始化子视图
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        根据item数量自适应collectionView的高度
        self.arr=[UserDefaults objectForKey:@"item"];
        [self.contentView addSubview:self.collectionView];
        _collectionView.frame=CGRectMake(0, 0, SCREEN_WIDTH, _collectionView.collectionViewLayout.collectionViewContentSize.height);
        self.frame=_collectionView.frame;
        

    }
    return self;
    
}

//布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - delegate,datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RHDeleteEquipCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.codeLabel.text=self.arr[indexPath.row][@"deviceCode"];
    cell.state=[self.arr[indexPath.row][@"state"] integerValue];
    if (cell.state == 1) {
        cell.imageView.image=[UIImage imageNamed:@"online"];
    }else {
        cell.imageView.image=[UIImage imageNamed:@"offline"];
    }
    cell.backgroundColor=BACKGROUND_COLOR;
    
    return cell;
}

#pragma mark - lazyload
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize=CGSizeMake((SCREEN_WIDTH - 40)/3, 87);
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) collectionViewLayout:flowLayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor=WhiteColor;
        [_collectionView registerClass:[RHDeleteEquipCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    return _collectionView;
}

@end
