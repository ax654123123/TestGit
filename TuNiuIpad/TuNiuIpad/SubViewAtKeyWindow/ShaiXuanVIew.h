//
//  ShaiXuanVIew.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-8.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreShaiXuan.h"
@interface ShaiXuanVIew : UIView<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UIView *oneView;
@property (strong, nonatomic) UIView *twoView;
@property (strong, nonatomic) UIView *threeView;

@property (strong, nonatomic) UIView *moreview;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *yuefenArr;
@property (nonatomic, strong) NSArray *leixingArr;
@property (nonatomic, strong) NSArray *guojiaArr;
@property (nonatomic, strong) NSArray *zongArr;
@property (nonatomic, strong) UIDatePicker *picker;
@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, strong) UIButton *wanchengbutton;
@property (nonatomic, strong) UIButton *qingkongbutton;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *adView;
- (IBAction)xianshiheikuang:(id)sender;
@end
