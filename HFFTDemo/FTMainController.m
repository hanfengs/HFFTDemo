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
#import "FTHelpView.h"

#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define KMainScreenHeight [UIScreen mainScreen].bounds.size.height

@interface FTMainController ()<MobileRTCMeetingServiceDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbl_info;
@property (weak, nonatomic) IBOutlet UIButton *btn_ware;
@property (weak, nonatomic) IBOutlet UIButton *btn_start;

@property (nonatomic, strong) FTInfoModel *model;
@property (nonatomic, strong) UIButton *btn_help;
@property (nonatomic, strong) FTHelpView *view_help;

@end

@implementation FTMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [self getInfo];
}

- (void)OrientationDidChange:(NSNotification *)notification{
    
    CGFloat x = [UIScreen mainScreen].bounds.size.width - 80;
    self.btn_help.frame = CGRectMake(x, 20, 80, 50);

    self.view_help.frame = CGRectMake(kMainScreenWidth - 200, 20, 200, KMainScreenHeight - 64 - 49);
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
    
//    [[MobileRTC sharedRTC] getMeetingSettings].meetingShareHidden = YES;
//    [[MobileRTC sharedRTC] getMeetingSettings].meetingParticipantHidden = YES;
    
    [[MobileRTC sharedRTC] getMeetingSettings].topBarHidden = NO;
    [[MobileRTC sharedRTC] getMeetingSettings].bottomBarHidden = YES;
    
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
        
        //@"用户结束了视频";
        self.lbl_info.text = [NSString stringWithFormat:@"用户%@,%@结束了视频", self.model.student.name, [self getCurrentTime]];
        
    }else if (state == MobileRTCMeetingState_InMeeting){
        MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
        UIView *view = [ms meetingView];
        
        CGFloat x = [UIScreen mainScreen].bounds.size.width - 80;
        
        UIButton *helpBtn = [[UIButton alloc] initWithFrame:CGRectMake(x, 20, 80, 50)];
        [helpBtn setTitle:@"HELP" forState:UIControlStateNormal];
        if (@available(iOS 11.0, *)) {
            helpBtn.backgroundColor = [UIColor colorNamed:@"help_color"];
        } else {
            // Fallback on earlier versions
        }
        [helpBtn addTarget:self action:@selector(clickBtn_help) forControlEvents:UIControlEventTouchUpInside];
        self.btn_help = helpBtn;
        [view addSubview:helpBtn];
        
    }else if (state == MobileRTCMeetingState_Connecting){
    }
    
}
- (void)clickBtn_help{

    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    UIView *view = [ms meetingView];
    
    [view addSubview:self.view_help];
}

- (FTHelpView *)view_help{

    if(_view_help == nil){
        _view_help = [[[NSBundle mainBundle] loadNibNamed:@"FTHelpView" owner:nil options:nil] lastObject];
        if (@available(iOS 11.0, *)) {
            _view_help.backgroundColor = [UIColor colorNamed:@"help_color"];
        } else {
            // Fallback on earlier versions
        }
        _view_help.frame = CGRectMake(kMainScreenWidth - 200, 20, 200, KMainScreenHeight - 64 - 49);
    }
    return _view_help;
}

- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    [formatter setDateFormat:@"EEEE yyyy-MM-dd hh:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

#pragma mark-

//全球拨入国家,在邀请邮件中显示国际号码链接,Dial-in 
- (void)onDialOutStatusChanged:(DialOutStatus)status{
    NSLog(@"=======%u", status);
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
