//
//  FTCourses.h
//  HFFTDemo
//
//  Created by hanfeng on 2017/12/11.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTLevel : NSObject
@property (nonatomic, copy) NSString *cambridge;
@property (nonatomic, copy) NSString *cefr_desc_english;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *cefr;
@property (nonatomic, copy) NSString *course;
@property (nonatomic, copy) NSString *cefr_desc;
@end


@interface FTCourse : NSObject
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover_img;
@property (nonatomic, copy) NSString *intro_img;
@property (nonatomic, copy) NSString *sub_title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) FTLevel *level;
@end


@interface FTCourses : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) NSInteger week_times;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger week_count;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger left;

@property (nonatomic, assign) BOOL has_end_report;
@property (nonatomic, assign) BOOL has_middle_report;

@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *week_days;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *start_date;
@property (nonatomic, copy) NSString *endtime;

@property (nonatomic, strong) FTLevel *level;
@property (nonatomic, strong) FTCourse *course;
@end
