//
//  SearchBar.h
//  TuNiuIpad
//
//  Created by ChenJie on 13-11-30.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShaiXuanVIew.h"
#import "SearchResultsView.h"

@interface SearchBar : UIView <UISearchBarDelegate>
@property (strong, nonatomic) ShaiXuanVIew* shaiXuanVIew;
@property (strong, nonatomic) SearchResultsView *searchView;
@property (strong, nonatomic) UISearchBar *searchBar;
- (void)quxiaoyemian;
@end
