//
//  RiLiViewController.h
//  TuNiuIpad
//
//  Created by ChenJie on 13-7-27.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSLCalendarView.h"
@protocol RiLiViewControllerDelegate;

@interface RiLiViewController : UIViewController <DSLCalendarViewDelegate>
@property (nonatomic, strong) IBOutlet DSLCalendarView *calendarView;
@property (nonatomic, weak) id<RiLiViewControllerDelegate>delegate;
@end

@protocol RiLiViewControllerDelegate <NSObject>

@optional
- (void)dianjitilipush:(NSDate*)date;

@end