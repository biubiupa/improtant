//
//  RHDfaultImageViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/2/2.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHDfaultImageViewController.h"
#import "AFNetworking.h"
#import "Header.h"
#import "Masonry.h"
#import "RHDefaultCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "RHAreaContentViewController.h"

@interface RHDfaultImageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectinView;
@property (nonatomic, copy) NSArray *arr;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIBarButtonItem *rightBBI;
@property (nonatomic, copy) NSDictionary *dict;

@end

@implementation RHDfaultImageViewController

#pragma mark - viewDidLoad
static NSString *identifier=@"itemid";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self defaultImageRequest];
}

#pragma mark - layoutViews
- (void)layoutViews {
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationItem.title=@"选取墙纸";
    self.rightBBI=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneImage)];
    self.rightBBI.tintColor=LightGrayColor;
    self.rightBBI.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightBBI;
    [self.view addSubview:self.collectinView];
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 14));
        make.top.equalTo(self.view).with.offset(20);
        make.left.equalTo(self.view).with.offset(10);
    }];
    
}

#pragma mark - delegate,datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RHDefaultCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSString *str=self.arr[indexPath.row][@"verPicture"];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.rightBBI.tintColor=CONTROL_COLOR;
    self.rightBBI.enabled=YES;
    NSString *str=self.arr[indexPath.row][@"verPicture"];
    self.dict=@{@"imgurl":str};
    
    UICollectionViewCell *cell=[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderWidth=2;
    cell.layer.borderColor=DELETEBTN_COLOR.CGColor;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell=[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderWidth=0;
}


#pragma mark - 事件处理
- (void)defaultImageRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:OTHER_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (STATUS == 0) {
            self.arr=responseObject[@"body"][@"imgList"];
            [self.collectinView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---%@",error);
    }];
}

//选定图片
- (void)doneImage {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"imgurl" object:self userInfo:self.dict];
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[RHAreaContentViewController class]]) {
            [self.navigationController popToViewController:VC animated:YES];
        }
    }
}

#pragma mark - lazyload
- (UICollectionView *)collectinView {
    if (!_collectinView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize=CGSizeMake((SCREEN_WIDTH - 40)/3, 178);
        flowLayout.sectionInset=UIEdgeInsetsMake(0, 10, 0, 10);
        _collectinView=[[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
        _collectinView.backgroundColor=BACKGROUND_COLOR;
        _collectinView.delegate=self;
        _collectinView.dataSource=self;
        _collectinView.contentInset=UIEdgeInsetsMake(50, 0, 0, 0);
        [_collectinView registerClass:[RHDefaultCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    return _collectinView;
}

- (UILabel *)label {
    if (!_label) {
        _label=[[UILabel alloc] init];
        _label.text=@"默认墙纸";
        _label.textAlignment=NSTextAlignmentLeft;
        _label.font=[UIFont systemFontOfSize:15];
    }
    return _label;
}


//参数
- (NSString *)parameter {
    if (!_parameter) {
        NSInteger userid=[UserId integerValue];
        NSDictionary *head=@{
                            @"aid": @"1and6uu",
                            @"ver": @"1.0",
                            @"ln": @"cn",
                            @"mod": @"ios",
                            @"de": @"2017-07-13 00:00:00",
                            @"sync": @1,
                            @"uuid": @"188111",
                            @"cmd": @50002,
                            @"chcode": @" ef19843298ae8f2134f "
                            };
        NSDictionary *con=@{@"userId": @(userid)};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}


@end
