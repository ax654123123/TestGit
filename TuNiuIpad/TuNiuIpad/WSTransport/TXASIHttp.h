//
//  TXASIHttp.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-18.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SBJson.h"
@interface TXASIHttp : NSObject

+ (void)ytxASIHTTPRequest:(NSString*)str viewController:(id)controller parm:(id)parm tag:(NSInteger)tag;
+ (void)ytxASIHTTPRequest:(NSString*)str viewController:(id)controller parm:(id)parm;
+ (NSDictionary *)requestJson:(ASIHTTPRequest *)request parm:(id)parm;
+ (NSDictionary *)requestJson:(ASIHTTPRequest *)request;
@end
