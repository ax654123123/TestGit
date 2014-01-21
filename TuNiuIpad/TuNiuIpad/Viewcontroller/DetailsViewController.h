//
//  DetailsViewController.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-3.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PlaceOrderView.h"
#import "RiLiViewController.h"
@interface DetailsViewController : BaseViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,RiLiViewControllerDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *firstTopView;
@property (strong, nonatomic) UIView *secondDownView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) PlaceOrderView *placOrder;
@property (strong, nonatomic) NSString *alinkId;
@property (strong, nonatomic) NSArray *timeArrary;
@property (strong, nonatomic) NSDictionary *dicDetaile;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) HJManagedImageV *topImage;
@property (assign, nonatomic) BOOL isSearchInto;
@property (strong, nonatomic) UITextView *textView1;
@property (strong, nonatomic) UITextView *jieshaotextView;
@property (strong, nonatomic) SearchBar* titleView;
- (void)huidioafangfa;
@end
