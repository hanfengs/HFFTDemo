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

#import <MobileRTC/MobileRTC.h>

@interface FTMainController ()<MobileRTCMeetingServiceDelegate>
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

#pragma mark-
- (IBAction)cliclBtn_ware:(id)sender {
    
    FTWareController *vc = [[FTWareController alloc] init];
    vc.urlStr = self.model.next_lesson.ware_url;
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)clickBtn_startClass:(id)sender {
    
    [self joinMeeting:self.model.next_lesson.meeting_id WithUserName:self.model.student.english_name];
}

#pragma mark-
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

#pragma mark-
- (void)joinMeeting:(NSString*)meetingNo WithUserName:(NSString *)userName{
    if (![meetingNo length])
    return;
    
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms){
        
        NSString *title = [NSString stringWithFormat:@"房间号：%@",meetingNo];
        [ms customizeMeetingTitle:title];
        ms.delegate = self;
        
        NSDictionary *paramDict = @{
                                    kMeetingParam_Username:userName,
                                    kMeetingParam_MeetingNumber:meetingNo,
                                    
                                    };
        
        MobileRTCMeetError ret = [ms joinMeetingWithDictionary:paramDict];
        NSLog(@"onJoinaMeeting ret:%d", ret);
        
        //        UIView *meetView = [ms meetingView];
        //        meetView.frame = CGRectMake(0, 0, 200, 200);
        //        [self.view addSubview:meetView];
    }
}


#pragma mark- delegate

//- (void)onJBHWaitingWithCmd:(JBHCmd)cmd{
//
//    NSLog(@"%d",JBHCmd_Hide);
//}

- (void)onClickedInviteButton:(UIViewController*)parentVC{
    
    NSLog(@"%@",parentVC);
}

- (void)onAppShareSplash{
    
}

- (void)onClickedShareButton{
    
}

- (void)onMeetingStateChange:(MobileRTCMeetingState)state{
    
    NSLog(@"======%u",state);
    
    if (state == MobileRTCMeetingState_Idle) {
        //        [self showAlert];
        
        self.lbl_info.text = [NSString stringWithFormat:@"用户%@,%@结束了视频", self.model.student.name, [self getCurrentTime]];//@"用户结束了视频";
    }
}

- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
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
