//
//  SearchBar.m
//  TuNiuIpad
//
//  Created by ChenJie on 13-11-30.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar

@synthesize searchView = _searchView;
@synthesize shaiXuanVIew = _shaiXuanVIew;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        searchBar.placeholder = @"搜索";
        searchBar.delegate = self;
        searchBar.backgroundImage = [UIImage imageNamed:@"home_navigation_bg.png"];
        self.searchBar = searchBar;
        [self addSubview:searchBar];
    }
    return self;
}
- (ShaiXuanVIew*)shaiXuanVIew
{
    if (_shaiXuanVIew == nil) {
        
        _shaiXuanVIew = [[ShaiXuanVIew alloc] init];
        //        _shaiXuanVIew.backgroundColor = [UIColor clearColor];
        
        //        _shaiXuanVIew.alpha = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:_shaiXuanVIew];
        
    }
    return _shaiXuanVIew;
}
- (SearchResultsView*)searchView
{
    if (_searchView == nil) {
        
        _searchView = [[SearchResultsView alloc] init];
        _searchView.view.frame = CGRectMake(0, 164+150, 1000, 1000);
        _searchView.view.hidden = YES;
        //        _searchView.tuniuview = self;
        //        _searchView.view.alpha = 0.5;
        _searchView.view.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_searchView.view];
        //        [self.view addSubview:_searchView.view];
    }
    return _searchView;
}
#pragma mark UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.frame = CGRectMake(0, 0, self.frame.size.width-10, 44);
    searchBar.showsCancelButton = YES;
    self.searchView.view.hidden = NO;
    self.shaiXuanVIew.hidden = NO;
    self.shaiXuanVIew.frame = CGRectMake(0, 44+20, 768, 100+150);
    //    [self.view addSubview:self.shaiXuanVIew];
    
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    TuNiuIpadAppDelegate* dele = [UIApplication sharedApplication].delegate;
    dele.keyWord = @"";
    searchBar.frame = CGRectMake(0, 0, 320, 44);
    searchBar.showsCancelButton = NO;
    self.searchView.view.hidden = YES;
    self.shaiXuanVIew.hidden = YES;
    self.shaiXuanVIew.oneView.hidden = YES;
    self.shaiXuanVIew.twoView.hidden = YES;
    self.shaiXuanVIew.threeView.hidden = YES;
    [searchBar resignFirstResponder];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //    searchBar.frame = CGRectMake(150, 0, 320, 44);
    //    searchBar.showsCancelButton = NO;
    //    self.searchView.view.hidden = YES;
    //    self.shaiXuanVIew.hidden = YES;
    [searchBar resignFirstResponder];
    //    searchBar.showsCancelButton = YES;
    TuNiuIpadAppDelegate* dele = [UIApplication sharedApplication].delegate;
    dele.keyWord = searchBar.text;
    self.shaiXuanVIew.oneView.hidden = YES;
    self.shaiXuanVIew.twoView.hidden = YES;
    self.shaiXuanVIew.threeView.hidden = YES;
    [self.searchView qingqiuwangluo];
    //    ListViewController *list = [[ListViewController alloc] init];
    //    list.isSearch = YES;
    //    list.keyWord = searchBar.text;
    //    [self.navigationController pushViewController:list animated:YES];
    
}
- (void)quxiaoyemian
{
    TuNiuIpadAppDelegate* dele = [UIApplication sharedApplication].delegate;
    dele.keyWord = @"";
    self.searchBar.frame = CGRectMake(0, 0, 320, 44);
    self.searchBar.showsCancelButton = NO;
    self.searchView.view.hidden = YES;
    self.shaiXuanVIew.hidden = YES;
    self.shaiXuanVIew.oneView.hidden = YES;
    self.shaiXuanVIew.twoView.hidden = YES;
    self.shaiXuanVIew.threeView.hidden = YES;
    [self.searchBar resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
