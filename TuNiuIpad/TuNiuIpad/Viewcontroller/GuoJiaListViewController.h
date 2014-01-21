//
//  GuoJiaListViewController.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-11-18.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuoJiaListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *zongArr;
@property (nonatomic, strong) UIView *subView;
- (void)shuaxintabView;
@end
