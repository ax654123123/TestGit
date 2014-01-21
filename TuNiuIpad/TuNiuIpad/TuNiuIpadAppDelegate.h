//
//  TuNiuIpadAppDelegate.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-1.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TuNiuIpadViewController;

@interface TuNiuIpadAppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TuNiuIpadViewController *viewController;

@property (strong, nonatomic) NSMutableArray *dateArrary;

@property (strong, nonatomic) NSMutableArray *priceArrary;

@property (strong, nonatomic) NSMutableArray *yuliuArrary;

@property (strong, nonatomic) NSString *keyWord;

@end
