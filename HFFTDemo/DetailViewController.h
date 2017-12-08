//
//  DetailViewController.h
//  HFFTDemo
//
//  Created by hanfeng on 2017/12/8.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

