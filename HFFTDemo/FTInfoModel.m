//
//  FTInfoModel.m
//  HFFTDemo
//
//  Created by hanfeng on 2017/12/11.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "FTInfoModel.h"
#import <YYKit/YYKit.h>

@implementation FTStudent
@end


@implementation FTInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {    
    return @{@"courses" : [FTCourses class]};
}
@end
