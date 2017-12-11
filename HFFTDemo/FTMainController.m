//
//  FTMainController.m
//  HFFTDemo
//
//  Created by hanfeng on 2017/12/9.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "FTMainController.h"
#import "ASNetworkingTools.h"
#import "FTInfoModel.h"
#import <NSObject+YYModel.h>

@interface FTMainController ()

@end

@implementation FTMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getInfo];
}

- (void)getInfo{
    
    
    NSDictionary *parameterDic = @{@"phone":self.number};
//    NSDictionary *parameterDic = @{@"phone":@"13810450981"};
    
    //http://vip.quxueabc.com/quxue/info?phone=13810450981
    
    [[ASNetworkingTools sharedTools] requestWithMethod:GET URLString:@"http://vip.quxueabc.com/quxue/info" parameters:parameterDic finished:^(id result, NSError *error) {
        
        FTInfoModel *data = [FTInfoModel modelWithJSON:result];
        
        NSLog(@"===%@===%@", data.student.name, result[@"code"]);
        NSInteger code = [result[@"code"] integerValue];
        
        if (code == 0) {
            
            self.title = data.student.english_name;
            
        }else if (code == 1001){
            
        }else if (code == 1002){
            
        }else{
            
        }
    }];
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
