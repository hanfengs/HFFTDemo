//
//  FTLesson.m
//  HFFTDemo
//
//  Created by hanfeng on 2017/12/11.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "FTLesson.h"

@implementation FTWord
@end

@implementation FTWords
@end

@implementation FTSentence
@end

@implementation FTSentences
@end

@implementation FTLesson
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"words" : [FTWords class], @"sentences" : [FTSentences class]};
}

@end
