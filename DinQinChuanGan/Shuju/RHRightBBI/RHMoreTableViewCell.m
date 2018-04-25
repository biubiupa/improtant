//
//  RHMoreTableViewCell.m
//  DinQinChuanGan
//
//  Created by malf on 2018/4/24.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHMoreTableViewCell.h"
#import "Header.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface RHMoreTableViewCell()
@property (nonatomic, strong) UILabel *areaNaLab;
@property (nonatomic, strong) UIImageView *bacImgView;

@end

@implementation RHMoreTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bacImgView];
        [self.bacImgView addSubview:self.areaNaLab];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //    背景图片
    [self.bacImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 6, 0, 6));
    }];
//    区域名称
    [self.areaNaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 23));
        make.centerX.equalTo(self.bacImgView);
        make.top.equalTo(self.bacImgView).with.offset(50);
    }];
    

    
    if (self.lists) {
        self.areaNaLab.text=[NSString stringWithFormat:@"%@",self.lists[self.aindex][@"areaName"]];
        NSString *urlString=[NSString stringWithFormat:@"%@",self.lists[self.aindex][@"picture"]];
        [self.bacImgView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }
    
}



#pragma mark - lazyload
//区域名称
- (UILabel *)areaNaLab {
    if (!_areaNaLab) {
        _areaNaLab=[[UILabel alloc] init];
        _areaNaLab.textAlignment=NSTextAlignmentCenter;
        _areaNaLab.font=[UIFont systemFontOfSize:24];
        _areaNaLab.textColor=WhiteColor;
        _areaNaLab.text=@"--";
    }
    return _areaNaLab;
}

//图片背景view
- (UIImageView *)bacImgView {
    if (!_bacImgView) {
        _bacImgView=[[UIImageView alloc] init];
        _bacImgView.clipsToBounds=YES;
        _bacImgView.layer.cornerRadius=7;
        _bacImgView.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _bacImgView;
}

@end
