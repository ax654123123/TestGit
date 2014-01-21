//
//  TXASIHttp.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-18.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "TXASIHttp.h"

#define YUMING @"http://ipad.htyou.com/mobile/"
@implementation TXASIHttp
+ (NSDictionary *)ytxTbASIHTTPRequest:(NSString*)str viewController:(UIViewController*)controller parm:(id)parm
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUMING,str]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    
    NSError *error = [request error];
    
    if (!error) {
        
      return  [self requestJson:request];
        
    }else
    
        return  nil;

}
+ (void)ytxASIHTTPRequest:(NSString*)str viewController:(id)controller parm:(id)parm tag:(NSInteger)tag
{
    //    if ([controller isKindOfClass:[UIViewController class]]) {
    //      controller  =  (UIViewController *)controller;
    //    }
    NSMutableString *mutableStr = [[NSMutableString alloc] init];
    if (parm != nil) {
        NSMutableDictionary *dic = (NSMutableDictionary*)parm;
        
        
        for (int i = 0; i < [[dic allKeys] count]; i ++) {
            
            NSString  *keyStr = [[dic allKeys] objectAtIndex:i];
            NSString *value = [dic objectForKey:keyStr];
            
            if (i == [[dic allKeys] count] - 1) {
                [mutableStr appendString:[NSString stringWithFormat:@"%@=%@",keyStr,value]];
            }else
                [mutableStr appendString:[NSString stringWithFormat:@"%@=%@&",keyStr,value]];
        }
        NSString* url_str = [[NSString stringWithFormat:@"%@%@?%@",YUMING,str,mutableStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:url_str];
        NSLog(@"----------%@",url);
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setTag:tag];
        [request setDelegate:controller];
        
        [request startAsynchronous];
    }
    if (parm == nil) {
        NSString* url_str = [[NSString stringWithFormat:@"%@%@",YUMING,str] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:url_str];
        NSLog(@"----------%@",url);
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setTag:tag];
        [request setDelegate:controller];
        
        [request startAsynchronous];
    }
    
    
    
    
}
+ (void)ytxASIHTTPRequest:(NSString*)str viewController:(id)controller parm:(id)parm
{
//    if ([controller isKindOfClass:[UIViewController class]]) {
//      controller  =  (UIViewController *)controller;
//    }
 NSMutableString *mutableStr = [[NSMutableString alloc] init];
    if (parm != nil) {
        NSMutableDictionary *dic = (NSMutableDictionary*)parm;
       

        for (int i = 0; i < [[dic allKeys] count]; i ++) {
           
            NSString  *keyStr = [[dic allKeys] objectAtIndex:i];
            NSString *value = [dic objectForKey:keyStr];
            
            if (i == [[dic allKeys] count] - 1) {
                [mutableStr appendString:[NSString stringWithFormat:@"%@=%@",keyStr,value]];
            }else
                [mutableStr appendString:[NSString stringWithFormat:@"%@=%@&",keyStr,value]];
        }
        NSString* url_str = [[NSString stringWithFormat:@"%@%@?%@",YUMING,str,mutableStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:url_str];
        NSLog(@"----------%@",url);
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:controller];
        
        [request startAsynchronous];
    }
    if (parm == nil) {
        NSString* url_str = [[NSString stringWithFormat:@"%@%@",YUMING,str] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:url_str];
        NSLog(@"----------%@",url);
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        [request setDelegate:controller];
        
        [request startAsynchronous];
    }

    


}
+ (NSDictionary *)requestJson:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:responseString];
    return rootDic;
}
@end
