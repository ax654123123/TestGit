//
//  MoreShaiXuan.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-10-28.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreShaiXuan : UIView <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *yuefenArr;
@property (nonatomic, strong) NSArray *leixingArr;
@property (nonatomic, strong) NSArray *guojiaArr;
@property (nonatomic, strong) NSArray *zongArr;
@property (nonatomic, strong) UIDatePicker *picker;
@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, strong) UIButton *wanchengbutton;
@property (nonatomic, strong) UIView *topView;
@end
