//
//  WebViewViewController.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-10-22.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface WebViewViewController : BaseViewController <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *htmlString;
@property (nonatomic, assign) BOOL isFromLogin;
@end
