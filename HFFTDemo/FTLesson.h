//
//  FTLesson.h
//  HFFTDemo
//
//  Created by hanfeng on 2017/12/11.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTWord : NSObject
@property (nonatomic, copy) NSString *audio;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *chinese;
@property (nonatomic, copy) NSString *english;
@end


@interface FTWords : NSObject
@property (nonatomic, strong) FTWord *word;
@end


@interface FTSentence : NSObject
@property (nonatomic, copy) NSString *audio;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *chinese;
@property (nonatomic, copy) NSString *english;
@end


@interface FTSentences : NSObject
@property (nonatomic, strong) FTSentence *sentence;
@end


@interface FTLesson : NSObject
@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *start_day;
@property (nonatomic, copy) NSString *teacher_img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *meeting_id;
@property (nonatomic, copy) NSString *room_name;
@property (nonatomic, copy) NSString *last_min;
@property (nonatomic, copy) NSString *start_day_chinese;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *start_date;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *types;
@property (nonatomic, copy) NSString *ware_url;

@property (nonatomic, strong) NSArray<FTWords *> *words;
@property (nonatomic, strong) NSArray<FTSentences *> *sentences;
@end
