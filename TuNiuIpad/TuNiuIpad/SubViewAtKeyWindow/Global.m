//
//  Global.m
//  Lesuke
//
//  Created by user on 12-11-26.
//  Copyright (c) 2012年 Yek.com. All rights reserved.
//

#import "Global.h"
static Global *sharedManager = nil;
@implementation Global
@synthesize ss1;
@synthesize ss2;
@synthesize ss3;
@synthesize sessionid;
@synthesize jzluid;
@synthesize yuefen;
@synthesize leixing;
@synthesize guojia;
@synthesize zaoshijian;
@synthesize wanshijian;
@synthesize riliviewcontroller;
+ (Global *) shared {
	@synchronized(self) {
        if (sharedManager == nil) {
            sharedManager = [[self alloc] init]; 
        }
    }
    return sharedManager;
}

- (id) init {
	if (self = [super init]){

        ss1 = @"";
        ss2 = @"";
        ss3 = @"";
        sessionid = @"";
        jzluid = @"";
        yuefen = @"";
         leixing = @"";
         guojia = @"";
         zaoshijian = @"";
         wanshijian = @"";
        riliviewcontroller = nil;
    }
    
    return self;
}

@end
