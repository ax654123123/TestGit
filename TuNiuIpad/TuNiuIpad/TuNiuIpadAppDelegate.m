//
//  TuNiuIpadAppDelegate.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-1.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//
#import "CHKeychain.h"
#import "TuNiuIpadAppDelegate.h"
#import "TuNiuIpadViewController.h"
#import "UIDevice+IdentifierAddition.h"
#import "NSString+MD5Addition.h"
#import "LoginHomeViewController.h"

#define IMAGEURL @"imageURL"

@implementation TuNiuIpadAppDelegate
@synthesize dateArrary = _dateArrary;
@synthesize priceArrary = _priceArrary;
@synthesize yuliuArrary = _yuliuArrary;
@synthesize keyWord = _keyWord;
- (void)removebuttonFromSuperview:(id)sender
{

    [self removeself];
    UIButton *button = (UIButton*)[self.window viewWithTag:990];
    [button removeFromSuperview];
    UIImageView *image = (UIImageView*)[self.window viewWithTag:991];
    [image removeFromSuperview];
}
- (void)removeself
{
    UIImageView *imageview = (UIImageView*)[self.window viewWithTag:1000];
    [imageview removeFromSuperview];
    
    UIView *view = (UIView*)[self.window viewWithTag:111111];
    [view removeFromSuperview];
    
//    LoginHomeViewController *login = [[LoginHomeViewController alloc] init];
//    login.view.frame = CGRectMake(0, 0, 768, 1004);
//    [self.window addSubview:login.view];
    

}
- (void)removeself1
{
   UIImageView *imageview = (UIImageView*)[self.window viewWithTag:1000];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    imageview.alpha = 0;
    [UIView setAnimationDelay:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeself)];
    [UIView commitAnimations];
    
    UIButton *button = (UIButton*)[self.window viewWithTag:990];
    [button removeFromSuperview];
    UIImageView *image = (UIImageView*)[self.window viewWithTag:991];
    [image removeFromSuperview];

}

- (void)enterViewControllerAnimations
{

    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 960, 1004)];
    
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] dataForKey:IMAGEURL]);
    if ([[NSUserDefaults standardUserDefaults] dataForKey:IMAGEURL] ) {
        NSData *imgData = [[NSUserDefaults standardUserDefaults] dataForKey:IMAGEURL];
        UIImage *image = [[UIImage alloc] initWithData:imgData];
        imageView.image = image;
    }else {
        imageView.image = [UIImage imageNamed:@"start_image01.jpg"];
    }

    imageView.userInteractionEnabled = NO;
    imageView.tag = 1000;
    [self.window addSubview:imageView];
    

    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:10];
    imageView.frame = CGRectMake(768-960, 20, 960, 1004);
    [UIView setAnimationDelay:10];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeself1)];
    
    [UIView commitAnimations];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    
    LoginHomeViewController* tuNiuIpadViewController = [[LoginHomeViewController alloc] initWithNibName:@"LoginHomeViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tuNiuIpadViewController];
    self.window.rootViewController = nav;
//    TuNiuIpadViewController* tuNiuIpadViewController = [[TuNiuIpadViewController alloc] initWithNibName:@"TuNiuIpadViewController" bundle:nil];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tuNiuIpadViewController];
//    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    // 此view 解决开机动画时 点击响应问题
    UIView* view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor clearColor];
    view.tag = 111111;
    [self.window addSubview:view];
    
    [self enterViewControllerAnimations];
    
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(768-100, 1024/2-75, 75, 75);
    [button setBackgroundImage:[UIImage imageNamed:@"start_next.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(removebuttonFromSuperview:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 990;
    [self.window addSubview:button];
    
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 320, 55)];
    imageView.image = [UIImage imageNamed:@"start_logo.png"];
    imageView.userInteractionEnabled = NO;
    imageView.tag = 991;
    [self.window addSubview:imageView];
    
    NSString* uuid =  [self uniqueDeviceIdentifier];

    
    
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[CHKeychain load:@"uuidnum"];
    NSString *ss = [usernamepasswordKVPairs objectForKey:@"uuid"];
    NSString *num = [usernamepasswordKVPairs objectForKey:@"num"];
    
//    if ([num intValue] > 30) {
//        exit(0);
//    }
    if ([ss isEqualToString:uuid]) {
        //        i ++
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",[num intValue]+1] forKey:@"num"];
    }else{
        
        NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        [usernamepasswordKVPairs setObject:uuid forKey:@"uuid"];
        [usernamepasswordKVPairs setObject:@"0" forKey:@"num"];
        [CHKeychain save:@"uuidnum" data:usernamepasswordKVPairs];
        
    }
    
    NSString* url_str = [[NSString stringWithFormat:@"http://www.justgo.cc:9080/AppManager/servlet/MyApp?appName=huatian"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:url_str];
    NSLog(@"----------%@",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTag:321321];
    [request setDelegate:self];
    
    [request startAsynchronous];
//    106.186.18.41/AppManager/servlet/MyApp?appName=huatian


//    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToShare" object:nil];
    NSDictionary *parm = @{@"adtype": @"220068"};
    [TXASIHttp ytxASIHTTPRequest:@"ipad_queryAdPic.action" viewController:self parm:parm];
    return YES;
}
#pragma mark - ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag == 321321) {
        NSLog(@"%@",[request responseString]);
        NSDictionary *dic =  [TXASIHttp requestJson:request];
        if (![[dic objectForKey:@"ret"] isEqualToString:@"ture"]) {
            UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请联系开发商" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [ale show];
        }
    }else{
    NSDictionary *dic =  [TXASIHttp requestJson:request];
    if ([[dic objectForKey:@"status"] isEqualToString:@"1"]) {
        if ([[dic objectForKey:@"value"] count] > 0) {
           
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),  ^{
            // This runs in background
            NSString * picuri = [[[dic objectForKey:@"value"] objectAtIndex:0] objectForKey:@"picuri"];
            NSString * picurl = [NSString stringWithFormat:@"http://ipad.htyou.com/%@",picuri];
            NSData *imgData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:picurl]];
//            UIImage *image = [[UIImage alloc] initWithData:imgData];
            [[NSUserDefaults standardUserDefaults] setObject:imgData forKey:IMAGEURL];
            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //This block runs on main thread, so update UI
//                                
//            });
        });
    }
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request

{

    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        exit(0);
    }

}
#pragma mark - -------
- (NSString *) uniqueDeviceIdentifier{
    NSString *macaddress = [[UIDevice currentDevice] macaddress];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString *stringToHash = [NSString stringWithFormat:@"%@%@",macaddress,bundleIdentifier];
    NSString *uniqueIdentifier = [stringToHash stringFromMD5];
    
    return uniqueIdentifier;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
