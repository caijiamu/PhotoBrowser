//
//  ViewController.m
//  图片浏览demo
//
//  Created by caijiamu on 16/6/21.
//  Copyright © 2016年 cloud.wood-group. All rights reserved.
//

#import "ViewController.h"
#import "ZBPhotoBrowserViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    NSArray *arr = @[@"http://files.mucaibang.cn/data/wood/android/picture1a6362fc787b4d8f8a1f17836d949d65.jpg",@"http://files.mucaibang.cn/data/wood/android/picture1156dbee9b434c14943659b519d74d32.jpg",@"http://files.mucaibang.cn/data/wood/android/picturee70304823f63495da4bfd3c1e7ab3ca8.jpg"];
    ZBPhotoBrowserViewController *photoBrowser = [[ZBPhotoBrowserViewController alloc]initWithDataSourceArr:arr sourceType:ZBPhotoBrowserDefault imageIndex:1];
    [self presentViewController:photoBrowser animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
