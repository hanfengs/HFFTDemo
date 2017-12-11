//
//  FTInfoModel.h
//  HFFTDemo
//
//  Created by hanfeng on 2017/12/11.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTCourses.h"
#import "FTLesson.h"

@interface FTStudent : NSObject
@property (nonatomic, copy) NSString *head;
@property (nonatomic, copy) NSString *create_date;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *english_name;
@property (nonatomic, copy) NSString *id;
@end


@interface FTInfoModel : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *hours;
@property (nonatomic, copy) NSString *words;
@property (nonatomic, copy) NSString *sentences;

@property (nonatomic, assign) BOOL has_report;
@property (nonatomic, assign) BOOL has_next_lesson;

@property (nonatomic, strong) FTStudent *student;
@property (nonatomic, strong) FTLesson *next_lesson;
@property (nonatomic, strong) NSArray <FTCourses *> *courses;
@end
