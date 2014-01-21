//
//  Global.h
//  Lesuke
//
//  Created by user on 12-11-26.
//  Copyright (c) 2012年 Yek.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RiLiViewController.h"

@interface Global : NSObject{

    NSString* ss1;
    NSString* ss2;
    NSString* ss3;
    
}
@property(nonatomic,copy)NSString* ss1;
@property(nonatomic,copy)NSString* ss2;
@property(nonatomic,copy)NSString* ss3;
@property(nonatomic,copy)NSString* sessionid;
@property(nonatomic,copy)NSString* jzluid;
@property(nonatomic,copy)NSString* yuefen;
@property(nonatomic,copy)NSString* leixing;
@property(nonatomic,copy)NSString* guojia;
@property(nonatomic,copy)NSString* zaoshijian;
@property(nonatomic,copy)NSString* wanshijian;
@property (nonatomic,strong)RiLiViewController *riliviewcontroller;
+ (Global *) shared ;
@end
