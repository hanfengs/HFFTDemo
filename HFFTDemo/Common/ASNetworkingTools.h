//
//  ASNetworkingTools.h
//  测试03-AFN封装OC
//
//  Created by hanfeng on 16/4/19.
//  Copyright © 2016年 hanfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


//枚举，列出请求的方式，还可以继续添加
typedef enum: NSInteger{
    GET,
    POST,
    
}ASRequestMethod;

typedef void (^ASRequestCallBack)(id result, NSError *error);

@interface ASNetworkingTools : AFHTTPSessionManager

+ (instancetype)sharedTools;

- (void)requestWithMethod:(ASRequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters finished:(ASRequestCallBack)finished;

- (void)requestPUTWithURLString:(NSString *)URLString parameters:(id)parameters finished:(ASRequestCallBack)finished;
@end
