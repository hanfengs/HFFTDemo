//
//  ASNetworkingTools.m
//  测试03-AFN封装OC
//
//  Created by hanfeng on 16/4/19.
//  Copyright © 2016年 hanfeng. All rights reserved.
//

#import "ASNetworkingTools.h"

@protocol ASNetworkingToolsProxy <NSObject>
/*
    这个方法实际是AFN中GET,POST调用的方法 －dataTaskWithHTTPMethod
    但是，Xcode不提示，可以设计一个协议，提示这个方法，并使编译通过
    这个方法，可以去AFN代码中直接复制过来
 */
@optional

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end

@interface ASNetworkingTools ()<ASNetworkingToolsProxy>

@end

@implementation ASNetworkingTools

//网络工具的类方法，单例模式
+(instancetype)sharedTools{
    
    static ASNetworkingTools *sharedTools;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //http://device-tcp.adonging.com:8002/status/
        //http://httpbin.org/
        NSURL *baseUrl = [NSURL URLWithString:@"http://httpbin.org/"];
        sharedTools = [[self alloc] initWithBaseURL:baseUrl];
        
    });
    return sharedTools;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        }];
        [self.reachabilityManager startMonitoring];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
        [(AFJSONResponseSerializer *)self.responseSerializer setRemovesKeysWithNullValues:YES];
    }
    return self;
}

#pragma mark - 封装 AFN 网络访问方法
/// 发起网络请求
///
/// @param method     GET / POST
/// @param URLString  URLString
/// @param parameters 请求参数字典
/// @param finished   完成回调
- (void)requestWithMethod:(ASRequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters finished:(ASRequestCallBack)finished {
    //打印链接，可注掉，勿删！
    NSMutableString *loadingUrl = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@?",URLString]];
    NSDictionary *paDic = (NSDictionary *)parameters;
    for (NSString *key in paDic.allKeys) {
        [loadingUrl appendFormat:@"%@=%@&",key,paDic[key]];
    }
    [loadingUrl deleteCharactersInRange:NSMakeRange(loadingUrl.length-1, 1)];
    NSLog(@"%@",loadingUrl);
    
    
    NSString *methodName = (method == GET) ? @"GET" : @"POST";
    
    [[self dataTaskWithHTTPMethod:methodName URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        finished(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"网络请求错误 %@", error.localizedDescription);
        
        finished(nil, error);
    }] resume];
}

- (void)requestPUTWithURLString:(NSString *)URLString parameters:(id)parameters finished:(ASRequestCallBack)finished{
    
    [self PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finished(nil, error);
    }];
}
#pragma mark- 有问题方法，废弃
//封装的对象方法，把AFN方法封装为 自己的 －request（参数1，参数2，参数3，参数4）方法使用在项目中
-(void)request:(ASRequestMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id, NSError *))finished{}
@end
