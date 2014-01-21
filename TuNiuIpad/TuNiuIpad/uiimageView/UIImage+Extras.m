//
//  UIImage+Extras.m
//  SFZLH
//
//  Created by weihua zhang on 12-4-26.
//  Copyright (c) 2012年 Yek. All rights reserved.
//

#import "UIImage+Extras.h"

@implementation UIImage (Extras)

- (id)initWithContentsOfPngFile:(NSString *)path
{
	CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
	if (systemVersion >= 4.0 && systemVersion < 4.1 && [[UIScreen mainScreen] scale] == 2.0)
	{
		NSString *path2x = [path stringByReplacingOccurrencesOfString:@".png" withString:@"@2x.png"];
		if ( [[NSFileManager defaultManager] fileExistsAtPath:path2x])
		{
			return [self initWithCGImage:[[UIImage imageWithData:[NSData dataWithContentsOfFile:path2x]] CGImage] scale:2.0 orientation:UIImageOrientationUp];
		}
	}
	
    return [self initWithContentsOfFile:path];
}

+ (UIImage*)imageWithContentsOfPngFile:(NSString *)path {  
    return [[[UIImage alloc] initWithContentsOfPngFile:path] autorelease];  
}  

@end
