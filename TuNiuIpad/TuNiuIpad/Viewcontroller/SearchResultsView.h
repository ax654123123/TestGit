//
//  SearchResultsView.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-3.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TuNiuIpadViewController.h"
//@class TuNiuIpadViewController;
@interface SearchResultsView : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* alinkMutableArrary;
@property (strong, nonatomic) NSMutableArray* picMutableArrary;
@property (strong, nonatomic) NSMutableArray* titleMutableArrary;
@property (strong, nonatomic) NSMutableArray* leastpriceMutableArrary;
//@property (strong, nonatomic) TuNiuIpadViewController* tuniuview;
- (void)qingqiuwangluo;
@end
