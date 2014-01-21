//
//  BaseViewController.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-1.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_navigation_bg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    UIImageView *imageViewShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_navigation_shadow"]];
    imageViewShadow.frame = CGRectMake(0, 3, self.view.frame.size.width, 12);
    [self.view addSubview:imageViewShadow];
}
- (void)GoBack:(id)sender
{
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
- (void)setAlertViewTitle:(NSString*)title queding:(NSString*)queding quxiao:(NSString*)quxiao
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:title delegate:self cancelButtonTitle:queding otherButtonTitles:quxiao, nil];
    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
