//
//  TuNiuIpadViewController.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-1.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "TuNiuIpadViewController.h"
#import "ListViewController.h"
#import "DetailsViewController.h"
#import "LoginAndRegisterView.h"
#import "HJManagedImageV.h"
#import "HJImageUtility.h"
#import "WSTransport.h"
#import "ASIHTTPRequest.h"
#import "SBJson/SBJson.h"
#import "TXASIHttp.h"
#import "WebViewViewController.h"


#define GEOCODER_URL        @"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true"

#define IMAGELEFTTAG 111
#define IMAGERIGHTTAG 222
#define CITYBUTTONTAG 333
#define GERENBUTTONTAG 444

@interface TuNiuIpadViewController ()
@property (nonatomic ,strong) UIPageControl *pageControl;
@end

@implementation TuNiuIpadViewController
@synthesize timer = _timer;
@synthesize leftImage = _leftImage;
@synthesize rightImage = _rightImage;
@synthesize cityButton = _cityButton;
@synthesize cityChangeView = _cityChangeView;
@synthesize gerenChangeView = _gerenChangeView;
@synthesize controlview = _controlview;
//@synthesize searchView = _searchView;
//@synthesize Locmap = _Locmap;
@synthesize loginView = _loginView;
@synthesize mengbanView = _mengbanView;
@synthesize navigatView = _navigatView;
@synthesize shaiXuanVIew = _shaiXuanVIew;
@synthesize sc = _sc;
@synthesize alinkMutableArrary = _alinkMutableArrary;
@synthesize tuiJianalinkMutableArrary = _tuiJianalinkMutableArrary;
@synthesize tuiJianpicMutableArrary = _tuiJianpicMutableArrary;
@synthesize tuijianrightcontrol = _tuijianrightcontrol;
@synthesize tuijianleftcontrol = _tuijianleftcontrol;
@synthesize str1 =_str1;
@synthesize str2 =_str2;
@synthesize str3 =_str3;
@synthesize picMutableArrary = _picMutableArrary;
@synthesize searchView = _searchView;

#pragma mark 初始化一些UI 
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
- (UIView*)navigatView
{
    if (_navigatView == nil) {
        _navigatView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _navigatView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_navigation_bg.png"]];
        
        [_navigatView setClipsToBounds:YES];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, -10, 95+10, 49+10)];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(469, 0, 80, 44)];
        UIButton *cityButton = [UIButton buttonWithType:0];
        UIButton *gerenbutton = [UIButton buttonWithType:0];
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(150, 0, 320, 44)];
        
        
        
        
        searchBar.placeholder = @"搜索";
        searchBar.delegate = self;
        searchBar.backgroundImage = [UIImage imageNamed:@"home_navigation_bg.png"];
        
        
        cityButton.tag = CITYBUTTONTAG;
        cityButton.frame = CGRectMake(560, 8, 90, 31);
        [cityButton setBackgroundImage:[UIImage imageNamed:@"home_navigation_button_bg.png"] forState:UIControlStateNormal];
        [cityButton setTitle:@"长沙" forState:UIControlStateNormal];
        [cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cityButton.titleLabel.font = [UIFont systemFontOfSize:12];
       // [cityButton addTarget:self action:@selector(showBackGroundView:) forControlEvents:UIControlEventTouchUpInside];
        self.cityButton = cityButton;
        
        
        gerenbutton.tag = GERENBUTTONTAG;
        gerenbutton.frame = CGRectMake(560+100, 8, 90, 31);
        [gerenbutton setBackgroundImage:[UIImage imageNamed:@"home_navigation_button_bg.png"] forState:UIControlStateNormal];
        [gerenbutton setTitle:@"个人" forState:UIControlStateNormal];
        [gerenbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        gerenbutton.titleLabel.font = [UIFont systemFontOfSize:12];
       // [gerenbutton addTarget:self action:@selector(showBackGroundView:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        imageView.image = [UIImage imageNamed:@"home_navigation_logo.png"];
        lable.textAlignment = 2;
        lable.textColor = [UIColor whiteColor];
        lable.backgroundColor = [UIColor clearColor];
        lable.font = [UIFont systemFontOfSize:14];
        lable.text = @"出发地";
        
        
        [_navigatView addSubview:imageView];
        [_navigatView addSubview:lable];
        [_navigatView addSubview:cityButton];
        [_navigatView addSubview:gerenbutton];
        [_navigatView addSubview:searchBar];
        
        
        
    }
    
    return _navigatView;
}
- (UIView*)loginView
{
    if (_loginView == nil) {
        _loginView = [[LoginAndRegisterView alloc] init];
        
    }
    return _loginView;
}
- (UIView*)mengbanView
{
    if (_mengbanView == nil) {
        _mengbanView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height)];
        _mengbanView.backgroundColor = [UIColor blackColor];
        _mengbanView.alpha = 0.5;
        UIButton *button = [UIButton buttonWithType:0];
        button.frame = CGRectMake(0, 0, _mengbanView.frame.size.width, _mengbanView.frame.size.height);
        [button addTarget:self action:@selector(hiddeLoginView:) forControlEvents:UIControlEventTouchUpInside];
        [_mengbanView addSubview:button];
        
    }
    return _mengbanView;
}
- (UIView*)cityChangeView
{
    if (_cityChangeView == nil) {        
        
        _cityChangeView = [[UIView alloc] initWithFrame:CGRectMake(469, 63, 185, 460)];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"setting_list_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        imageView.frame = CGRectMake(0, 0, _cityChangeView.frame.size.width, _cityChangeView.frame.size.height);
        _cityChangeView.hidden = YES;
        [_cityChangeView addSubview:imageView];
        [[UIApplication sharedApplication].keyWindow addSubview:_cityChangeView];
        
        NSArray *arrary = [[NSArray alloc] initWithObjects:@"上海",@"北京",@"深圳",@"广州",@"杭州",@"南京",@"苏州",@"成都",@"武汉",@"青岛", nil];
        
        for (int i = 0 ; i < [arrary count]; i++) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 46*i , 185, 46)];
            lable.backgroundColor = [UIColor clearColor];
            lable.textColor = [UIColor whiteColor];
            lable.textAlignment = 1;
            lable.text = [NSString stringWithFormat:@"%@",[arrary objectAtIndex:i]];
            lable.userInteractionEnabled = YES;
            [_cityChangeView addSubview:lable];
            
            
            if (i != 0 ) {
                UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_cell_sep.png"]];
                image.frame = CGRectMake(0, 46*i-2, 185, 2);
                [_cityChangeView addSubview:image];
            }

            UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, lable.frame.size.width, lable.frame.size.height)];
            [control addTarget:self action:@selector(againToSetbuttonTitle:) forControlEvents:UIControlEventTouchUpInside];
            control.tag = i;
            [lable addSubview:control];
            
            
        }
        
        
    }
    return _cityChangeView;
}

- (UIView*)gerenChangeView
{
    if (_gerenChangeView == nil) {
        
        _gerenChangeView = [[UIView alloc] initWithFrame:CGRectMake(469+100, 63, 185, 276)];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"setting_list_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        imageView.frame = CGRectMake(0, 0, _gerenChangeView.frame.size.width, _gerenChangeView.frame.size.height);
        _gerenChangeView.hidden = YES;
        [_gerenChangeView addSubview:imageView];
        [[UIApplication sharedApplication].keyWindow addSubview:_gerenChangeView];
        
        NSArray *arrary = [[NSArray alloc] initWithObjects:@"订单",@"优惠券",@"收藏",@"意见反馈",@"V1.0",@"登陆", nil];
        
        for (int i = 0 ; i < [arrary count]; i++) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 46*i , 185, 46)];
            lable.backgroundColor = [UIColor clearColor];
            lable.textColor = [UIColor whiteColor];
            lable.textAlignment = 0;
            lable.text = [NSString stringWithFormat:@"%@",[arrary objectAtIndex:i]];
            lable.userInteractionEnabled = YES;
            [_gerenChangeView addSubview:lable];
            
            
            if (i != 0 ) {
                UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_cell_sep.png"]];
                image.frame = CGRectMake(0, 46*i-2, 185, 2);
                [_gerenChangeView addSubview:image];
            }
            
            UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, lable.frame.size.width, lable.frame.size.height)];
            [control addTarget:self action:@selector(goToLong:) forControlEvents:UIControlEventTouchUpInside];
            control.tag = i;
            [lable addSubview:control];
            
            
        }
        
    }
    return _gerenChangeView;
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
#pragma mark button 响应方法
- (void)GoToDelitetuijian:(id)sender
{
    UIControl * control = (UIControl *)sender;
    WebViewViewController *detail = [[WebViewViewController alloc] init];
    if (control.tag == 0) {
        detail.htmlString = LIFTTUIJIAN_URL;
    } else if (control.tag == 2) {
        detail.htmlString = RIGHTTUIJIAN_URL;
    }
    [self.navigationController pushViewController:detail animated:YES];
    
    
}
- (void)GoToDelite:(id)sender
{
    UIControl * control = (UIControl *)sender;
    DetailsViewController *detail = [[DetailsViewController alloc] init];
    detail.alinkId = [self.alinkMutableArrary objectAtIndex:control.tag];
    detail.isSearchInto = NO;
    [self.navigationController pushViewController:detail animated:YES];
//    UIControl * control = (UIControl *)sender;
//    WebViewViewController *detail = [[WebViewViewController alloc] init];
//    detail.htmlString = TEST_URL;
//    [self.navigationController pushViewController:detail animated:YES];

}
- (void)GoToList:(id)sender
{
    
    UIControl *control = (UIControl*)sender;
    ListViewController *list = [[ListViewController alloc] init];
    list.numberAre = control.tag - 1;
    list.isSearch = NO;
    [self.navigationController pushViewController:list animated:YES];

}
- (void)againToSetbuttonTitle:(id)sender
{
    UIControl *control = (UIControl*)sender;
    NSArray *arrary = [[NSArray alloc] initWithObjects:@"上海",@"北京",@"深圳",@"广州",@"杭州",@"南京",@"苏州",@"成都",@"武汉",@"青岛", nil];
    [self.cityButton setTitle:[NSString stringWithFormat:@"%@",[arrary objectAtIndex:control.tag]] forState:UIControlStateNormal];
    self.cityChangeView.hidden = YES;
    self.controlview.hidden = YES;
}
- (void)hiddeChangeView:(id)sender
{

    self.cityChangeView.hidden = YES;
    self.gerenChangeView.hidden = YES;
    self.controlview.hidden = YES;
}
- (void)showBackGroundView:(id)sender
{
    
    UIButton *button = (UIButton*)sender;
    if (button.tag == CITYBUTTONTAG) {
        if (self.cityChangeView.hidden) {
            self.cityChangeView.hidden = NO;
            self.controlview.hidden = NO;
            self.gerenChangeView.hidden = YES;
        }else{
            self.cityChangeView.hidden = YES;
            self.controlview.hidden = YES;
            self.gerenChangeView.hidden = YES;
        }
    }else if (button.tag == GERENBUTTONTAG){
        if (self.gerenChangeView.hidden) {
            self.gerenChangeView.hidden = NO;
            self.controlview.hidden = NO;
            self.cityChangeView.hidden = YES;
        }else{
            self.gerenChangeView.hidden = YES;
            self.controlview.hidden = YES;
            self.cityChangeView.hidden = YES;
        }
    
    
    }

}
int number = 1;
- (void)timerFired:(NSTimer*)timer
{
    NSLog(@"%d",number++);
    
    if ((number % 2) == 0) {
        
        self.leftImage.alpha = 0;
        int cout = [self.tuiJianpicMutableArrary count];
        int llinde =   (arc4random() % (cout + 1));
        
        if (llinde < cout) {
            NSString *url = [self.tuiJianpicMutableArrary objectAtIndex:llinde];
            [HJImageUtility queueLoadImageFromUrl:url imageView:self.leftImage];
            self.tuijianleftcontrol.tag = llinde;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1.5];
            self.leftImage.alpha = 1;
            [UIView commitAnimations];

        }
        
    }else{
    
        self.rightImage.alpha = 0;

        
        int cout = [self.tuiJianpicMutableArrary count];
        int rrinde =   (arc4random() % (cout + 1));
        if (rrinde < cout) {
            NSString *url = [self.tuiJianpicMutableArrary objectAtIndex:rrinde];
            [HJImageUtility queueLoadImageFromUrl:url imageView:self.rightImage];
            self.tuijianrightcontrol.tag = rrinde;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1.5];
            self.rightImage.alpha = 1;
            [UIView commitAnimations];
        }
        
    
    }
    

}
- (void)goToLong:(id)sender
{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.loginView];
    [self.loginView.nameField becomeFirstResponder];
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanView];
    self.mengbanView.hidden = NO;
    
    [self.view addSubview:self.navigatView];
    

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.view.frame = CGRectMake(0, 180, self.view.frame.size.width, 1024);
    
    self.navigatView.frame = CGRectMake(0, -44, self.view.frame.size.width, 44);
    
    CGRect rect = self.gerenChangeView.frame;
    rect.origin.y = self.gerenChangeView.frame.origin.y + 180;
    self.gerenChangeView.frame = rect;
    
    self.loginView.frame = CGRectMake(0, 0, 768*2, 200);
    [UIView commitAnimations];
    

}
- (void)hiddeLoginView:(id)sender
{
    self.mengbanView.hidden = YES;
    self.gerenChangeView.hidden = YES;
    self.controlview.hidden = YES;
    [self.loginView.nameField resignFirstResponder];
    [self.loginView.passWordField resignFirstResponder];
    [self.loginView.zhucenameField resignFirstResponder];
    [self.loginView.zhucenameField resignFirstResponder];
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 1024);
    
    self.navigatView.frame = CGRectMake(0, -44,self.view.frame.size.width, 0);
    
    CGRect rect = self.gerenChangeView.frame;
    rect.origin.y = self.gerenChangeView.frame.origin.y - 180;
    self.gerenChangeView.frame = rect;
    
    self.loginView.frame = CGRectMake(0, 0, 768*2, 0);
    [UIView commitAnimations];
}
#pragma mark 初始化界面控件
- (void)loadNavigationBar
{
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, -10, 95+10, 49+10)];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(469, 0, 80, 44)];
    UIButton *cityButton = [UIButton buttonWithType:0];
    UIButton *gerenbutton = [UIButton buttonWithType:0];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(150, 0, 320, 44)];
    
    
    
    
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    searchBar.backgroundImage = [UIImage imageNamed:@"ssss.jpg"];
    
    
    cityButton.tag = CITYBUTTONTAG;
    cityButton.frame = CGRectMake(560, 8, 90, 31);
    [cityButton setBackgroundImage:[UIImage imageNamed:@"home_navigation_button_bg.png"] forState:UIControlStateNormal];
    [cityButton setTitle:@"长沙" forState:UIControlStateNormal];
    [cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cityButton.titleLabel.font = [UIFont systemFontOfSize:15];
   // [cityButton addTarget:self action:@selector(showBackGroundView:) forControlEvents:UIControlEventTouchUpInside];
    self.cityButton = cityButton;
    
    
    gerenbutton.tag = GERENBUTTONTAG;
    gerenbutton.frame = CGRectMake(560+100, 8, 90, 31);
    [gerenbutton setBackgroundImage:[UIImage imageNamed:@"home_navigation_button_bg.png"] forState:UIControlStateNormal];
    [gerenbutton setTitle:@"个人" forState:UIControlStateNormal];
    [gerenbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    gerenbutton.titleLabel.font = [UIFont systemFontOfSize:15];
   // [gerenbutton addTarget:self action:@selector(showBackGroundView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    imageView.image = [UIImage imageNamed:@"home_navigation_logo.png"];
    lable.textAlignment = 2;
    lable.textColor = [UIColor whiteColor];
    lable.backgroundColor = [UIColor clearColor];
    lable.font = [UIFont systemFontOfSize:14];
    lable.text = @"出发地";
    
    
    [titleView addSubview:imageView];
    [titleView addSubview:lable];
    [titleView addSubview:cityButton];
    [titleView addSubview:gerenbutton];
    [titleView addSubview:searchBar];
    
    
    self.navigationItem.titleView = titleView;
    
    
    self.navigationItem.hidesBackButton = YES;
    


}
- (void)loadUpViewScrollView
{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(14, 14, self.view.frame.size.width - 28, 557)];
    sc.backgroundColor = [UIColor clearColor];
    sc.pagingEnabled = YES;
    sc.showsVerticalScrollIndicator = NO;
    sc.showsHorizontalScrollIndicator = NO;
    sc.delegate = self;
    [self.view addSubview:sc];
    self.sc = sc;
    
   UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    pageControl.frame = CGRectMake(0, 527, 768, 20);
    
    
    pageControl.currentPage = 0;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];

}
- (void)loadDownView
{
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(14, 557+14, self.view.frame.size.width - 28, self.view.frame.size.height - 557 - 28 -44)];
    downView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:240.0/255.0 blue:235.0/255.0 alpha:1.0];
    [self.view addSubview:downView];
    
    NSArray *arrary = [NSArray arrayWithObjects:@"周边旅游精选",@"国内旅游精选",@"出境旅游精选", nil];
    for (int i = 1; i < 4; i ++) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"menu%d.jpg",i ]]];
        image.frame = CGRectMake(245*(i-1) +10 , 10, 230, 129);
        image.userInteractionEnabled = YES;
        [downView addSubview:image];
        
        UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, image.frame.size.width, image.frame.size.height)];
        [control addTarget:self action:@selector(GoToList:) forControlEvents:UIControlEventTouchUpInside];
        control.tag = i;
        [image addSubview:control];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(245*(i-1) +10, 150, 230, 20)];
        lable.backgroundColor = [UIColor clearColor];
        lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        lable.textColor = [UIColor darkGrayColor];
        lable.text = [arrary objectAtIndex:i-1];
        [downView addSubview:lable];
        
        UIImageView *imageNumber = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_center_number_grey.png"]];
        imageNumber.frame = CGRectMake(245*(i-1) +10 , 180, 65, 25);
        [downView addSubview:imageNumber];
        
        UILabel *lableNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
        lableNumber.backgroundColor = [UIColor clearColor];
        lableNumber.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        lableNumber.textColor = [UIColor darkGrayColor];
        lableNumber.textAlignment = 1;
        if (i == 1) {
            lableNumber.text = self.str1;
            self.lableNumber1 = lableNumber;
        } else if (i == 2){
       
            lableNumber.text = self.str2;
            self.lableNumber2 = lableNumber;
        
        }else{
            self.lableNumber3 =lableNumber;
            lableNumber.text = self.str3;
        }
        [imageNumber addSubview:lableNumber];
        
        UIImageView *imagearrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_center_arrow.png"]];
        imagearrow.frame = CGRectMake((230-42)*i + 60*(i-1), 150, 42, 47);
        [downView addSubview:imagearrow];
        
        UIImageView *imageline = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_center_sep_bg.png"]];
        imageline.frame = CGRectMake((self.view.frame.size.width - 28-740)/2, 215, 740, 9);
        [downView addSubview:imageline];
        
        if (i == 2) {
            
            UIImageView *lastimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bottom_image.png"]];
            lastimage.frame = CGRectMake(225*(i-1) +30 , 236+35, 233, 55);
            [downView addSubview:lastimage];
            
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 233, 55)];
            lable.backgroundColor = [UIColor clearColor];
            lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
            lable.textColor = [UIColor whiteColor];
            lable.textAlignment = 1;
            lable.text = @"华天推荐路线";
            [lastimage addSubview:lable];
            
        }else{
//            HJManagedImageV *lastimage = [[HJManagedImageV alloc] init];
//            lastimage.frame = CGRectMake(245*(i-1) +10 , 236, 230, 129);
//            lastimage.userInteractionEnabled = YES;
//            [downView addSubview:lastimage];
            
            
            if (i == 1) {
                UIImageView *lastimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bottom_image.png"]];
                lastimage.frame = CGRectMake(245*(i-1) +10 , 236, 233, 129);
                lastimage.userInteractionEnabled = YES;
                [downView addSubview:lastimage];
                
                UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, lastimage.frame.size.width, lastimage.frame.size.height)];
                control.tag = 0;
                self.tuijianleftcontrol = control;
                [control addTarget:self action:@selector(GoToDelitetuijian:) forControlEvents:UIControlEventTouchUpInside];
                [lastimage addSubview:control];

                lastimage.image = [UIImage imageNamed:@"ipad-(3).png"];
            }else{
                UIImageView *lastimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bottom_image.png"]];
                lastimage.frame = CGRectMake(245*(i-1) +10 , 236, 233, 129);
                lastimage.userInteractionEnabled = YES;
                [downView addSubview:lastimage];
                
                UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, lastimage.frame.size.width, lastimage.frame.size.height)];
                control.tag = 2;
                self.tuijianrightcontrol = control;
                [control addTarget:self action:@selector(GoToDelitetuijian:) forControlEvents:UIControlEventTouchUpInside];
                [lastimage addSubview:control];

                lastimage.image = [UIImage imageNamed:@"ipad-(4).png"];
            }
        }
    }
}

#pragma mark loadview
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code
      TuNiuIpadAppDelegate *app = (TuNiuIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
        app.viewController =self;
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    self.iiii=0;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];
    
    
    [self loadNavigationBar];
    [self loadUpViewScrollView];
    [self loadDownView];
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setValue:@"220066" forKey:@"adtype"];
    [TXASIHttp ytxASIHTTPRequest:@"ipad_queryAdPic.action" viewController:self parm:parm];
    
    NSMutableDictionary *parm1 = [[NSMutableDictionary alloc] init];
    [parm1 setValue:@"220067" forKey:@"adtype"];
    [TXASIHttp ytxASIHTTPRequest:@"ipad_queryAdPic.action" viewController:self parm:parm1];
    
    NSMutableDictionary *parm2 = [[NSMutableDictionary alloc] init];
    
        [parm2 setValue:[NSString stringWithFormat:@"1"] forKey:@"isnative"];
    [TXASIHttp ytxASIHTTPRequest:@"ipad_queryTourLine.action" viewController:self parm:parm2 tag:111];
    
        NSMutableDictionary *parm3 = [[NSMutableDictionary alloc] init];
        [parm3 setValue:[NSString stringWithFormat:@"2"] forKey:@"isnative"];
    [TXASIHttp ytxASIHTTPRequest:@"ipad_queryTourLine.action" viewController:self parm:parm3 tag:222];
    
    NSMutableDictionary *parm4 = [[NSMutableDictionary alloc] init];
    [parm4 setValue:[NSString stringWithFormat:@"4"] forKey:@"isnative"];
    
    [TXASIHttp ytxASIHTTPRequest:@"ipad_queryTourLine.action" viewController:self parm:parm4 tag:333];
    
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.timer  = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    UIControl* controlview = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    [controlview addTarget:self action:@selector(hiddeChangeView:) forControlEvents:UIControlEventTouchUpInside];
    controlview.hidden = YES;
    self.controlview = controlview;
    [self.view addSubview:controlview];
    
//    _Locmap = [[MKMapView alloc] init];
//    [_Locmap setShowsUserLocation:YES];
//    _Locmap.delegate = self;
    

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width-10, 44);
    searchBar.showsCancelButton = YES;
    self.searchView.view.hidden = NO;
    self.shaiXuanVIew.hidden = NO;
    self.shaiXuanVIew.frame = CGRectMake(0, 44+20, 768, 100+150);
//    [self.view addSubview:self.shaiXuanVIew];

    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    searchBar.frame = CGRectMake(150, 0, 320, 44);
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
#pragma mark - 拿到数据后 赋值
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{



}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x <= 0) {
        self.pageControl.currentPage = 0;
        return;
    }
    int page = scrollView.contentOffset.x / 768;
    self.pageControl.currentPage = page+1;

    
}
- (void)setValueToSc:(NSDictionary*)dic
{
    NSMutableArray* picMutableArrary = [[NSMutableArray alloc] init];
    NSMutableArray* titleMutableArrary = [[NSMutableArray alloc] init];
    NSMutableArray* alinkMutableArrary = [[NSMutableArray alloc] init];
    if ([[dic objectForKey:@"status"] isEqualToString:@"1"]) {
        
        NSArray *arrary = [dic objectForKey:@"value"];
        _sc.contentSize = CGSizeMake((self.view.frame.size.width - 28)*[arrary count], 0);
        self.pageControl.numberOfPages = [arrary count];
        for (NSDictionary *litDictionary in arrary){
            
            NSString * picuri = [litDictionary objectForKey:@"picuri"];
            NSString * picurl = [NSString stringWithFormat:@"http://ipad.htyou.com/%@",picuri];
            [picMutableArrary addObject:picurl];
            
            NSString * text = [litDictionary objectForKey:@"text"];
            [titleMutableArrary addObject:text];
            
            
            NSString * alink = [litDictionary objectForKey:@"alink"];
            [alinkMutableArrary addObject:alink];
            
            
        }
        self.alinkMutableArrary = alinkMutableArrary;
        self.picMutableArrary = picMutableArrary;
//        NSString *url = [self.picMutableArrary objectAtIndex:0 ];
//        [HJImageUtility queueLoadImageFromUrl:url imageView:self.leftImage];
//        NSString *url1 = [self.picMutableArrary objectAtIndex:2 ];
//        [HJImageUtility queueLoadImageFromUrl:url1 imageView:self.rightImage];
        
        for (int i = 0; i < [arrary count]; i ++) {
            
            
            HJManagedImageV *image = [[HJManagedImageV alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 28)*i , 0, self.view.frame.size.width - 28, 557)];
            image.userInteractionEnabled = YES;
            
            NSString *url = [picMutableArrary objectAtIndex:i ];
            [HJImageUtility queueLoadImageFromUrl:url imageView:image];
            [_sc addSubview:image];
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_name_bg"]];
            imageView.frame = CGRectMake(0, 557 - 110, self.view.frame.size.width, 107);
            imageView.alpha = 0.8;
            [image addSubview:imageView];
            
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
            lable.backgroundColor = [UIColor clearColor];
            lable.text = [titleMutableArrary objectAtIndex:i];//@"长滩岛逍遥五日游";
            lable.textColor = [UIColor whiteColor];
            lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:45];
            lable.textAlignment = 1;
            [imageView addSubview:lable];
            
            UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, image.frame.size.width, image.frame.size.height)];
            control.tag = i;
            [control addTarget:self action:@selector(GoToDelite:) forControlEvents:UIControlEventTouchUpInside];
            [image addSubview:control];
        }
    }
}
- (void)setValueToTuiJianRode:(NSDictionary*)dic
{

    NSMutableArray* picMutableArrary = [[NSMutableArray alloc] init];
    NSMutableArray* alinkMutableArrary = [[NSMutableArray alloc] init];
    NSArray *arrary = [dic objectForKey:@"value"];
    for (NSDictionary *litDictionary in arrary){
        
        NSString * picuri = [litDictionary objectForKey:@"picuri"];
        NSString * picurl = [NSString stringWithFormat:@"http://ipad.htyou.com/%@",picuri];
        [picMutableArrary addObject:picurl];
        
        NSString * alink = [litDictionary objectForKey:@"alink"];
        [alinkMutableArrary addObject:alink];
        
    }
    self.tuiJianpicMutableArrary = picMutableArrary;
    self.tuiJianalinkMutableArrary = alinkMutableArrary;
}

#pragma mark - ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSDictionary *dic =  [TXASIHttp requestJson:request];
    
    NSLog(@"ASIHTTPRequest-----------%@",dic);
    if ([[dic objectForKey:@"status"] isEqualToString:@"1"]) {
        
   
        NSString *type = [[[dic objectForKey:@"value"] objectAtIndex:0] objectForKey:@"type"];

   
        if ([type isEqualToString:@"220066"]) {
        
            [self setValueToSc:dic];
  
        }else if ([type isEqualToString:@"220067"]){
    
       
            [self setValueToTuiJianRode:dic];
    
   
        }else{
            self.iiii ++;
            NSLog(@"self.iiii-=-----==%d",self.iiii);
            
            if (request.tag == 111) {
                NSArray *arrary = [dic objectForKey:@"value"];
                NSString* str1 = [NSString stringWithFormat:@"%d",[arrary count]];
                self.lableNumber1.text = str1;
                self.str1 = str1;
            }else if (request.tag == 222) {
                NSArray *arrary = [dic objectForKey:@"value"];
                NSString* str2 = [NSString stringWithFormat:@"%d",[arrary count]];
                self.lableNumber2.text = str2;
                self.str2 = str2;
            }
           else if (request.tag == 333) {
               NSArray *arrary = [dic objectForKey:@"value"];
               NSString* str3 = [NSString stringWithFormat:@"%d",[arrary count]];
               self.lableNumber3.text = str3;
               self.str3 = str3;
               
//               [self loadDownView];
           }         
        }
    
   
    }else {

            self.iiii ++;
        if (request.tag == 111) {
            NSString* str1 = @"0";
            self.lableNumber1.text = str1;
            self.str1 = str1;
        }else if (request.tag == 222) {
            NSString* str2 = @"0";
            self.lableNumber2.text = str2;
            self.str2 = str2;
        }
        else if (request.tag == 333) {
            NSString* str3 = @"0";
            self.lableNumber3.text = str3;
            self.str3 = str3;
            
            //               [self loadDownView];
        }
    }
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    
}
@end
