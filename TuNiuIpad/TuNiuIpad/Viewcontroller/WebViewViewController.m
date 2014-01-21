//
//  WebViewViewController.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-10-22.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "WebViewViewController.h"
#import "DetailsViewController.h"
#import "SearchBar.h"

@interface WebViewViewController ()
@property(nonatomic,strong) SearchBar* titleView;
@end

@implementation WebViewViewController
@synthesize webView = _webView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)GoBack:(id)sender
{
    [self.titleView quxiaoyemian];
    if (self.isFromLogin) {
        NSArray *arr = self.navigationController.viewControllers;
        if ([arr count] > 3) {
            DetailsViewController *detail = (DetailsViewController *)[self.navigationController.viewControllers objectAtIndex:[arr count]-3];
            [self.navigationController popToViewController:detail animated:YES];
        }

    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)setBackButton
{
    UIButton* button = [UIButton buttonWithType:0];
    [button setBackgroundImage:[UIImage imageNamed:@"home_navigation_button_bg.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(15, 0, 90, 31)];
    [button addTarget:self action:@selector(GoBack:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem * leftbutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftbutton;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
	// Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height-44)];
    NSURL *url =[NSURL URLWithString:self.htmlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
//    [self.webView loadHTMLString:self.htmlString baseURL:nil];
    self.webView.delegate = self;
    self.webView.opaque = NO;
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.webView.allowsInlineMediaPlayback = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;
    
    [self.view addSubview:self.webView];
    
    [self setBackButton];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    UIBarButtonItem* barbutton = [[UIBarButtonItem alloc] initWithCustomView:view];
    for (int i = 0; i < 2; i++) {
        UIButton* button = [UIButton buttonWithType:0];
        button.frame = CGRectMake( 60*i , 5, 60, 35);
        if (i == 0) {
            button.tag = 0;
//            [button setBackgroundImage:[UIImage imageNamed:@"detail_ previous_button.png"] forState:UIControlStateNormal];
            [button setTitle:@"上一级" forState:UIControlStateNormal];
        }else{
            button.tag = 1;
//            [button setBackgroundImage:[UIImage imageNamed:@"detail_next_button.png"] forState:UIControlStateNormal];
            [button setTitle:@"下一级" forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(webviewpress:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    self.navigationItem.rightBarButtonItem = barbutton;
    
//    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-44-50 , 768, 50)];
//    downView.backgroundColor = [UIColor blackColor];
//    downView.alpha = 0.7;
//    
//    UIButton *button_left = [UIButton buttonWithType:0];
//    [button_left setBackgroundImage:[UIImage imageNamed:@"loginLeft.png"] forState:UIControlStateNormal];
//    button_left.frame = CGRectMake(200+150, 7, 36, 36);
//    button_left.tag = 0;
//    [button_left addTarget:self action:@selector(webviewpress:) forControlEvents:UIControlEventTouchUpInside];
//    [downView addSubview:button_left];
//    
//    UIButton *button_right = [UIButton buttonWithType:0];
//    [button_right setBackgroundImage:[UIImage imageNamed:@"loginRight.png"] forState:UIControlStateNormal];
//    button_right.frame = CGRectMake(300+150, 7, 36, 36);
//    button_right.tag = 1;
//    [button_right addTarget:self action:@selector(webviewpress:) forControlEvents:UIControlEventTouchUpInside];
//    [downView addSubview:button_right];
//    
//    [self.view addSubview:downView];
    SearchBar* titleView = [[SearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    self.titleView = titleView;
    self.navigationItem.titleView = titleView;

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webviewpress:(UIButton*)button
{

    if (button.tag == 0) {
        [self.webView goBack];
    }else {
        [self.webView goForward];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
