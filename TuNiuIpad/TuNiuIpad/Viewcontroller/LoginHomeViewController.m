//
//  LoginHomeViewController.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-10-25.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "LoginHomeViewController.h"
#import "TuNiuIpadViewController.h"
#import "DetailsViewController.h"
#import "WebViewViewController.h"

@interface LoginHomeViewController ()

@end

@implementation LoginHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.isPopToHome = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.dengluPress addTarget:self action:@selector(dengluPress:) forControlEvents:UIControlEventTouchUpInside];
//    [self.chongzhiPress addTarget:self action:@selector(chongzhiPress:) forControlEvents:UIControlEventTouchUpInside];
    self.loginPassWordTextField.secureTextEntry = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dengluPress:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";
    [self.loginPassWordTextField resignFirstResponder];
    [self.loginUserTextField resignFirstResponder];
	if ((self.loginUserTextField.text == nil || [self.loginUserTextField.text isEqualToString:@""]) && (self.loginPassWordTextField.text == nil || [self.loginPassWordTextField.text isEqualToString:@""])) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];
        TuNiuIpadViewController* tuNiuIpadViewController = [[TuNiuIpadViewController alloc] initWithNibName:@"TuNiuIpadViewController" bundle:nil];
        [self.navigationController pushViewController:tuNiuIpadViewController animated:NO];

		return;
	}
//	if ([self.loginUserTextField.text isEqualToString:@"admin"] && (self.loginPassWordTextField.text == nil || [self.loginPassWordTextField.text isEqualToString:@""])) {
//		[MBProgressHUD hideHUDForView:self.view animated:YES];
//        TuNiuIpadViewController* tuNiuIpadViewController = [[TuNiuIpadViewController alloc] initWithNibName:@"TuNiuIpadViewController" bundle:nil];
//        [self.navigationController pushViewController:tuNiuIpadViewController animated:NO];
//		return;
//	}
    if (self.loginUserTextField.text != nil && self.loginPassWordTextField.text != nil && ![self.loginUserTextField.text isEqualToString:@""]&& ![self.loginUserTextField.text isEqualToString:@""]) {
        NSDictionary *parm1 = @{@"username": self.loginUserTextField.text ,@"password" : self.loginPassWordTextField.text};
        [TXASIHttp ytxASIHTTPRequest:@"ipad_login.action" viewController:self parm:parm1];
		return;
    }
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入账号或者密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
	[ale show];
	return;


}
- (IBAction)chongzhiPress:(id)sender
{
    self.loginUserTextField.text = @"";
    self.loginPassWordTextField.text = @"";
    [self.loginPassWordTextField resignFirstResponder];
    [self.loginUserTextField resignFirstResponder];
}
#pragma mark - ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSDictionary *dic =  [TXASIHttp requestJson:request];
    
    NSLog(@"ASIHTTPRequest-----------%@",dic);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([[dic objectForKey:@"status"] isEqualToString:@"1"]) {
        [Global shared].sessionid = [dic objectForKey:@"value"];
		if (self.isPopToHome) {
//			[((DetailsViewController*)self.delegate) huidioafangfa];
            if ([Global shared].sessionid != nil && ![[Global shared].sessionid isEqualToString:@""]) {
                WebViewViewController *detail = [[WebViewViewController alloc] init];
                NSString *strUrl = [NSString stringWithFormat:@"%@teamcode=%@&sessionid=%@",TEST_URL,[Global shared].jzluid,[Global shared].sessionid];
                detail.htmlString = strUrl;
                detail.isFromLogin = YES;
                [self.navigationController pushViewController:detail animated:YES];
            }
		}else {
			TuNiuIpadViewController* tuNiuIpadViewController = [[TuNiuIpadViewController alloc] initWithNibName:@"TuNiuIpadViewController" bundle:nil];
			[self.navigationController pushViewController:tuNiuIpadViewController animated:NO];
		}


    }else{
        UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账号或者密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [ale show];
//        TuNiuIpadViewController* tuNiuIpadViewController = [[TuNiuIpadViewController alloc] initWithNibName:@"TuNiuIpadViewController" bundle:nil];
//        [self.navigationController pushViewController:tuNiuIpadViewController animated:NO];
    }
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request

{
    UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账号或者密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [ale show];
//    TuNiuIpadViewController* tuNiuIpadViewController = [[TuNiuIpadViewController alloc] initWithNibName:@"TuNiuIpadViewController" bundle:nil];
//    [self.navigationController pushViewController:tuNiuIpadViewController animated:NO];
//    [self.view removeFromSuperview];
    
}
@end
