//
//  FTWareController.m
//  HFFTDemo
//
//  Created by hanfeng on 2017/12/11.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "FTWareController.h"

@interface FTWareController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation FTWareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSURL *url = [NSURL URLWithString:@"http://47.95.38.15/gm/login.html"];//http://47.95.38.15/gm/login.html
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [self.webView loadRequest:urlRequest];

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
