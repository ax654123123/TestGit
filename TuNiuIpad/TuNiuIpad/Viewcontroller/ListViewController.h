//
//  ListViewController.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-1.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) int numberAre;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* alinkMutableArrary;
@property (strong, nonatomic) NSMutableArray* picMutableArrary;
@property (strong, nonatomic) NSMutableArray* titleMutableArrary;
@property (strong, nonatomic) NSMutableArray* leastpriceMutableArrary;
@property (strong, nonatomic) NSString* keyWord;
@property (nonatomic,assign) BOOL isSearch;
@end
