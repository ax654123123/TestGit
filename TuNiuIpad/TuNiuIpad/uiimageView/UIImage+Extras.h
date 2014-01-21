//
//  UIImage+Extras.h
//  SFZLH
//
//  Created by weihua zhang on 12-4-26.
//  Copyright (c) 2012年 Yek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Extras)
- (id)initWithContentsOfPngFile:(NSString *)path;
+ (UIImage*)imageWithContentsOfPngFile:(NSString *)path;
@end
