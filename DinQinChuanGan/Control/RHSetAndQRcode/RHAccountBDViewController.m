//
//  RHAccountBDViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/3/8.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHAccountBDViewController.h"
#import "Header.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "RHAccountBTableViewCell.h"
#import "RHAccConViewController.h"
#import "RHBandEmilViewController.h"
#import "RHBindAccViewController.h"

@interface RHAccountBDViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *descArr;
@property (nonatomic, copy) NSArray *imgName;
@property (nonatomic, copy) NSArray *accountArr;
@property (nonatomic, copy) NSArray *pictureArr;
@property (nonatomic, copy) NSArray *buttonArr;
@property (nonatomic, copy) NSArray *str;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, strong) RHAccountBTableViewCell *accountCell;
@property (nonatomic, strong) RHBindAccViewController *bindVC;

@end

@implementation RHAccountBDViewController

static NSString *identifier=@"cell";

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self phoneAndEmailRequest];
}

#pragma mark - GUI、布局
- (void)layoutViews {
    self.view.backgroundColor=BACKGROUND_COLOR;
    self.navigationItem.title=@"帐号绑定";
    UIBarButtonItem *backBBI=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backBBI;
    self.accountCell=[RHAccountBTableViewCell new];
    self.bindVC=[RHBindAccViewController new];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - delegate,datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.accountCell=[tableView dequeueReusableCellWithIdentifier:identifier];
    self.accountCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    self.accountCell.desLabel.text=self.descArr[indexPath.row];
    self.accountCell.imgview.image=[UIImage imageNamed:self.imgName[indexPath.row]];
    self.accountCell.accountLabel.text=self.accountArr[indexPath.row];
    return self.accountCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RHAccConViewController *accConVC=[RHAccConViewController new];
    accConVC.imgView.image=[UIImage imageNamed:self.pictureArr[indexPath.row]];
    accConVC.accountLabel.text=[self.str[indexPath.row] stringByAppendingString:self.accountArr[indexPath.row]];
    [accConVC.changeBtn setTitle:self.buttonArr[indexPath.row] forState:UIControlStateNormal];
    if (indexPath.row == 0) {
        if (self.phone.length != 3) {
            accConVC.toolType = 1;
            accConVC.tipStr=@"确认解绑该手机号吗?";
            [self.navigationController pushViewController:accConVC animated:YES];
        }else {
            NSString *number=@"confirm";
            [UserDefaults setObject:number forKey:@"numbers"];
            [UserDefaults synchronize];
            self.bindVC.toolType=1;
            [self.navigationController pushViewController:self.bindVC animated:YES];
        }
        
    }else{
        if (self.email.length != 3) {
            accConVC.toolType = 2;
            accConVC.tipStr=@"确认解绑该邮箱吗?";
            [self.navigationController pushViewController:accConVC animated:YES];
        }else {
            
            NSString *name=@"red";
            [UserDefaults setObject:name forKey:@"numbers"];
            [UserDefaults synchronize];
            self.bindVC.toolType=2;
            [self.navigationController pushViewController:self.bindVC animated:YES];
        }
        
    }
    
}

#pragma mark - 请求邮箱和手机号
- (void)phoneAndEmailRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:USER_API parameters:self.parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",MSG);
        if (STATUS == 0) {
            self.phone=responseObject[@"body"][@"phone"];
            self.email=responseObject[@"body"][@"mailBox"];
            if (!_phone || !_email) {
                if (!_phone) {
                    _phone=@"未绑定";
                }else {
                    _email=@"未绑定";
                }
            }
            self.accountArr=@[_phone, _email];
        }else {
            self.phone=@"未绑定";
            self.email=@"未绑定";
            self.accountArr=@[_phone, _email];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"----%@",error);
    }];
}


#pragma mark - lazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor=BACKGROUND_COLOR;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.rowHeight=41;
        _tableView.contentInset=UIEdgeInsetsMake(10, 0, 0, 0);
        UIView *view=[UIView new];
        view.backgroundColor=BACKGROUND_COLOR;
        _tableView.tableFooterView=view;
        [_tableView registerClass:[RHAccountBTableViewCell class] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (NSArray *)descArr {
    if (!_descArr) {
        _descArr=@[@"手机号", @"邮箱账号"];
    }
    return _descArr;
}

- (NSArray *)imgName {
    if (!_imgName) {
        _imgName=@[@"phone", @"email"];
    }
    return _imgName;
}

//- (NSArray *)accountArr {
//    if (!_accountArr) {
//        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//        NSString *phone=[userDefaults objectForKey:@"phone"];
//        NSString *email=[userDefaults stringForKey:@"mailbox"];
//        if ([phone isEqualToString:@""] || [email isEqualToString:@""]) {
//            if ([phone isEqualToString:@""]) {
//                phone=@"未绑定";
//            }else {
//                email=@"未绑定";
//            }
//        }
//        _accountArr=@[phone,email];
//    }
//    return _accountArr;
//}

- (NSArray *)pictureArr {
    if (!_pictureArr) {
        _pictureArr=@[@"phonegray", @"emailgray"];
    }
    return _pictureArr;
}

- (NSArray *)buttonArr {
    if (!_buttonArr) {
        _buttonArr=@[@"更换手机号", @"更换邮箱账号"];
    }
    return _buttonArr;
}

- (NSArray *)str {
    if (!_str) {
        _str=@[@"当前手机号: ", @"当前邮箱账号: "];
    }
    return _str;
}

- (NSString *)parameter {
    if (!_parameter) {
        NSString *userId=[UserDefaults objectForKey:@"userId"];
        NSDictionary *head=@{
                             @"aid": @"1and6uu",
                             @"ver": @"1.0",
                             @"ln": @"cn",
                             @"mod": @"ios",
                             @"de": @"2017-11-14 00:00:00",
                             @"sync": @1,
                             @"uuid": @"188111",
                             @"cmd": @"10010",
                             @"chcode": @" ef19843298ae8f2134f "
                             };
        NSDictionary *con=@{@"userId":userId};
        NSDictionary *dict=@{@"head":head, @"con":con};
        NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        _parameter=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _parameter;
}

@end
