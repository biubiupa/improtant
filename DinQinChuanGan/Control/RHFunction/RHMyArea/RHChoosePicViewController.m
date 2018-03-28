//
//  RHChoosePicViewController.m
//  DinQinChuanGan
//
//  Created by malf on 2018/1/31.
//  Copyright © 2018年 DST. All rights reserved.
//

#import "RHChoosePicViewController.h"
#import "Header.h"
#import "RHDfaultImageViewController.h"
#import "RHAddAreaViewController.h"
#import "RHJudgeMethod.h"


@interface RHChoosePicViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *arr;

@end

@implementation RHChoosePicViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

#pragma mark - 控件、视图
- (void)layoutViews {
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationItem.title=@"选取墙纸";
    [self.view addSubview:self.tableView];
    UIBarButtonItem *backBBI=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backBBI;

    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=self.arr[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - didSelectRow
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIImagePickerController *imagePC=[[UIImagePickerController alloc] init];
    imagePC.delegate=self;
    imagePC.allowsEditing=YES;
//        从相册选取图片
    if (indexPath.row == 2) {
        imagePC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePC animated:YES completion:nil];
//        拍照选取图片
    }else if (indexPath.row == 1) {
        if ([self isFrantCameraAvailable] || [self isRearCameraAvailable]) {
            imagePC.sourceType=UIImagePickerControllerSourceTypeCamera;
            imagePC.showsCameraControls=YES;
            [self presentViewController:imagePC animated:YES completion:nil];
            
        }else {
            NSLog(@"没有摄像头可用！");
        }
    }else {
//        默认墙纸
        self.navigationItem.backBarButtonItem=[RHJudgeMethod creatBBIWithTitle:@"返回" Color:CONTROL_COLOR];
        RHDfaultImageViewController *defaultVC=[RHDfaultImageViewController new];
        [self.navigationController pushViewController:defaultVC animated:YES];
    }
}
//判断相机是否可用
- (BOOL)isFrantCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
- (BOOL)isRearCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
//选取照片代理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *original=[info objectForKey:UIImagePickerControllerOriginalImage];
    self.block(image);
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(original, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }

    [self.navigationController popViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];

}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        NSLog(@"成功保存图片");
    }
    else{
        ///图片未能保存到本地
    }
}
#pragma mark - 控件初始化
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        UIView *view=[UIView new];
        _tableView.tableFooterView=view;
    }
    return _tableView;
}

- (NSArray *)arr {
    if (!_arr) {
        _arr=@[@"默认墙纸", @"拍照", @"从相册选择"];
    }
    return _arr;
}

@end
