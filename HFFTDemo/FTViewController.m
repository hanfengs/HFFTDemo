//
//  FTViewController.m
//  HFFTDemo
//
//  Created by hanfeng on 2017/12/9.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "FTViewController.h"
#import "FTMainController.h"
#import "ASNetworkingTools.h"

@interface FTViewController ()

@end

@implementation FTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)clickBtn_login:(UIButton *)sender {
    
    NSDictionary *parameterDic = @{@"phone":@"18102029719",@"pwd":@"123456"};
    
    [[ASNetworkingTools sharedTools] requestWithMethod:POST URLString:@"http://vip.quxueabc.com/quxue/login/" parameters:parameterDic finished:^(id result, NSError *error) {
        
        NSLog(@"===%@===%@",result, result[@"code"]);
    }];
    
//    FTMainController *mainVC = [[FTMainController alloc] init];
//    [self.navigationController pushViewController:mainVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
