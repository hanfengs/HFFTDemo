//
//  FTWareController.m
//  HFFTDemo
//
//  Created by hanfeng on 2017/12/11.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "FTWareController.h"
#import <QuickLook/QuickLook.h>
#import "AFNetworking.h"

@interface FTWareController ()<QLPreviewControllerDelegate, QLPreviewControllerDataSource>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation FTWareController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课件";
    
//    NSURL *url = [NSURL URLWithString:@"http://47.95.38.15/gm/login.html"];//http://47.95.38.15/gm/login.html
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
//    [self.webView loadRequest:urlRequest];

    [self URLDocument];
}

- (void)URLDocument{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileName = @"New_level_2_lesson_5_my_grandpas_farm_f0eMIHc.pdf";//@"79262309-b0db-4039-bdcf-2cabdd04f0f7.docx";//New_level_2_lesson_5_my_grandpas_farm_f0eMIHc.pdf
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];//@"Reader.pdf";
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if (exist) {
        NSLog(@"直接打开");
        QLPreviewController *previewController = [[QLPreviewController alloc] init];
        previewController.dataSource = self;
        previewController.delegate = self;
        [self presentViewController:previewController animated:YES completion:nil];
    } else {
        NSLog(@"开始下载");
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString *wordPath = self.urlStr;//@"http://uqg-test.img-cn-beijing.aliyuncs.com/CompanyData/Attachment/UQG_FreeTrail_4/2016/8/8/79262309-b0db-4039-bdcf-2cabdd04f0f7.docx";
        NSURL *URL = [NSURL URLWithString:wordPath];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            //这里已经写入本地了
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            //在这里你可以获取到文件名以及路径
            NSLog(@"File downloaded to: %@", filePath);
            if (!error) {
                QLPreviewController *previewController = [[QLPreviewController alloc] init];
                previewController.dataSource = self;
                previewController.delegate = self;
                [self presentViewController:previewController animated:YES completion:nil];
            } else {
                NSLog(@"下载失败");
            }
        }];
        [downloadTask resume];
    }
}

#pragma mark - QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileName = @"课件";//@"79262309-b0db-4039-bdcf-2cabdd04f0f7.docx";//@"保存时候的文件名，一般是url地址的最后面的文件名";
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    
    return [NSURL fileURLWithPath:filePath];
}

- (void)previewControllerWillDismiss:(QLPreviewController *)controller {
    NSLog(@"视图即将dismiss");
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
