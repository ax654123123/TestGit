//
//  CHKeychain.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-8-13.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>


@interface CHKeychain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;


@end
