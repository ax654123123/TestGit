//
//  TuNiuIpadViewController.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-1.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BaseViewController.h"
#import "SearchResultsView.h"
#import "LoginAndRegisterView.h"
#import "ShaiXuanVIew.h"

@interface TuNiuIpadViewController : BaseViewController<UISearchBarDelegate,MKMapViewDelegate,UIScrollViewDelegate>


@property (strong, nonatomic) NSTimer* timer;
@property (strong, nonatomic) HJManagedImageV* leftImage;
@property (strong, nonatomic) HJManagedImageV* rightImage;
@property (strong, nonatomic) UIButton* cityButton;
@property (strong, nonatomic) UIView* cityChangeView;
@property (strong, nonatomic) UIView* gerenChangeView;
@property (strong, nonatomic) UIControl* controlview;
@property (strong, nonatomic) SearchResultsView *searchView;
//@property (strong, nonatomic) SearchResultsView *searchView;
//@property (strong, nonatomic) MKMapView* Locmap;
@property (strong, nonatomic) LoginAndRegisterView *loginView;
@property (strong, nonatomic) UIView* mengbanView;
@property (strong, nonatomic) UIView* navigatView;
@property (strong, nonatomic) ShaiXuanVIew* shaiXuanVIew;
@property (strong, nonatomic) UIScrollView *sc;
@property (strong, nonatomic) NSMutableArray* alinkMutableArrary;
@property (strong, nonatomic) NSMutableArray* tuiJianpicMutableArrary;
@property (strong, nonatomic) NSMutableArray* tuiJianalinkMutableArrary;
@property (strong, nonatomic) UIControl* tuijianleftcontrol;
@property (strong, nonatomic) UIControl* tuijianrightcontrol;
@property (strong, nonatomic) NSString* str1;
@property (strong, nonatomic) NSString* str2;
@property (strong, nonatomic) NSString* str3;
@property (strong, nonatomic) UILabel *lableNumber1;
@property (strong, nonatomic) UILabel *lableNumber2;
@property (strong, nonatomic) UILabel *lableNumber3;
@property (strong, nonatomic) NSMutableArray* picMutableArrary;
@property (nonatomic, assign) int iiii;
@end
