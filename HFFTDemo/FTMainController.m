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
#import "FTWareController.h"

@interface FTMainController ()
@property (weak, nonatomic) IBOutlet UILabel *lbl_info;
@property (weak, nonatomic) IBOutlet UIButton *btn_ware;
@property (weak, nonatomic) IBOutlet UIButton *btn_start;

@property (nonatomic, strong) FTInfoModel *model;

@end

@implementation FTMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getInfo];
}
- (IBAction)cliclBtn_ware:(id)sender {
    
    FTWareController *vc = [[FTWareController alloc] init];
    vc.urlStr = self.model.next_lesson.ware_url;
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)clickBtn_startClass:(id)sender {
    
}


- (void)setModel:(FTInfoModel *)model{
    _model = model;
    
    self.title = model.student.english_name;
    
    if (model.has_next_lesson == YES) {
        self.lbl_info.text = [NSString stringWithFormat:@"您下一次课时间是%@(%@) %@",model.next_lesson.start_date, model.next_lesson.start_day_chinese, model.next_lesson.start_time];
        self.btn_ware.hidden = NO;
        self.btn_start.hidden = NO;
    }
}
- (void)getInfo{
    
    NSDictionary *parameterDic = @{@"phone":self.number};
//    NSDictionary *parameterDic = @{@"phone":@"13810450981"};
    
    //http://vip.quxueabc.com/quxue/info?phone=13810450981
    
    [[ASNetworkingTools sharedTools] requestWithMethod:GET URLString:@"http://vip.quxueabc.com/quxue/info" parameters:parameterDic finished:^(id result, NSError *error) {
        
        FTInfoModel *data = [FTInfoModel modelWithJSON:result];
        
        NSLog(@"===%@===%@", data.student.name, result[@"code"]);
//        NSInteger code = [result[@"code"] integerValue];
        
        NSInteger code = [data.code integerValue];
        if (code == 0) {
            self.model = data;
            
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
