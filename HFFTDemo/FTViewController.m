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

@property (weak, nonatomic) IBOutlet UITextField *tf_account;
@property (weak, nonatomic) IBOutlet UITextField *tf_pwd;

@end

@implementation FTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)clickBtn_login:(UIButton *)sender {
    
//    NSDictionary *parameterDic = @{@"phone":@"18102029719",@"pwd":@"123456"};
    NSDictionary *parameterDic = @{@"phone":self.tf_account.text,@"pwd":self.tf_pwd.text};
    
    [[ASNetworkingTools sharedTools] requestWithMethod:POST URLString:@"http://vip.quxueabc.com/quxue/login/" parameters:parameterDic finished:^(id result, NSError *error) {
        
        NSLog(@"===%@===%@",result, result[@"code"]);
        NSInteger code = [result[@"code"] integerValue];
        
        if (code == 0) {
            
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
            
            [self.navigationItem setBackBarButtonItem:backItem];
            
            FTMainController *mainVC = [[FTMainController alloc] init];
            mainVC.number = self.tf_account.text;
            
            [self.navigationController pushViewController:mainVC animated:YES];
            
        }else if (code == 1001){
            
        }else if (code == 1002){
            
        }else{
            
        }
    }];
    
}

#pragma mark-

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
