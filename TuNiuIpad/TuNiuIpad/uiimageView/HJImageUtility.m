//
//  HJImageUtility.m
//  Moonbasa
//
//  Created by zwh on 11-7-26.
//  Copyright 2011 yek.com All rights reserved.
//

#import "HJImageUtility.h"
#import "HJObjManager.h"


#pragma mark -
#pragma mark HJImageLoadOperationHandler
@interface HJImageLoadOperationHandler : NSObject<HJMOUser>
{
	id object;
	SEL action;
	id param;
	
	id oid;
	NSURL* url;
	HJMOHandler* moHandler;
	NSString* mSaveFilePath;
}
@property(nonatomic, retain)NSString* mSaveFilePath;
/*
 action:
 (void) *****:(UIImage*) image url:(NSString*) url;
 */
-(id) initWithObject:(id) aobject action:(SEL)aaction param:(id) aparam;
-(void)dealFilePath;
@end

@implementation HJImageLoadOperationHandler

@synthesize oid;
@synthesize url;
@synthesize moHandler;
@synthesize mSaveFilePath;

NSTimeInterval startTime;
-(id) initWithObject:(id)aobject action:(SEL)aaction param:(id) aparam{
	if(self=[super init]){
		startTime=[[NSDate date] timeIntervalSince1970];
		object=[aobject retain];
		action=aaction;
		param=[aparam retain];
	}
	return self;
}

//-(void) imageLoadOperation:(YKImageLoadOperation *)imageLoadOperation loadedImage:(UIImage *)image url:(NSString *)url{
//	[object performSelector:action withObject:image withObject:param];
//	//NSTimeInterval endTime=[[NSDate date] timeIntervalSince1970];
//	//NSLog(@"%@ timespan %f startTime:%f endTime:%f",[self class],endTime-startTime,startTime, endTime);
//}

-(void) changeManagedObjStateFromLoadedToReady {
	//NSLog(@"managedStateReady %@",managedState);
	if (moHandler.moData) 
	{
		[self dealFilePath];
		if ([self.mSaveFilePath length])
		{
			[moHandler.moData writeToFile:self.mSaveFilePath atomically:NO];
		}
		else
		{
			moHandler.managedObj=[UIImage imageWithData:moHandler.moData];
		}
		
	} 
	else if (moHandler.moReadyDataFilename)
	{
		[self dealFilePath];
		if ([self.mSaveFilePath length])
		{
			[[NSFileManager defaultManager] moveItemAtPath:moHandler.moReadyDataFilename toPath:self.mSaveFilePath error:nil];
		}
		else
		{
			moHandler.managedObj=[UIImage imageWithContentsOfFile:moHandler.moReadyDataFilename];
		}
	}
	else
	{
		//error? 
		NSLog(@"HJManagedImageV error in changeManagedObjStateFromLoadedToReady ?");
	}
}

-(void)dealFilePath
{
	if ([self.mSaveFilePath length]) {
		[[NSFileManager defaultManager] removeItemAtPath:self.mSaveFilePath error:nil];
		NSString* dirPath = [mSaveFilePath stringByDeletingLastPathComponent];
		if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath])
		{
			[[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
		}
	}
}

-(void) managedObjFailed {
	//NSLog(@"moHandlerFailed %@",moHandler);
	[object performSelector:action withObject:nil withObject:param];
	[self autorelease];
}

-(void) managedObjReady {
	//NSLog(@"moHandlerReady %@",moHandler);
	[object performSelector:action withObject:moHandler.managedObj withObject:param];
	[self autorelease];
}

-(void) dealloc{
	[self.moHandler removeUser:self];
	self.moHandler=nil;
	self.oid=nil;
	self.url=nil;
	self.mSaveFilePath = nil;
	
	[param release];
	[object release];
	[super dealloc];
}


@end

#pragma mark -
#pragma mark UIImageUtility
@implementation HJImageUtility

#pragma mark ======================image tool======================
static void addRoundedRectToPath(CGContextRef context, CGRect rect, 
								 float ovalWidth,float ovalHeight) 
{ 
	float fw, fh; 
	if (ovalWidth == 0 || ovalHeight == 0) { 
		CGContextAddRect(context, rect); 
		return; 
	} 
	
	CGContextSaveGState(context); 
	CGContextTranslateCTM (context, CGRectGetMinX(rect), 
						   CGRectGetMinY(rect)); 
	CGContextScaleCTM (context, ovalWidth, ovalHeight); 
	fw = CGRectGetWidth (rect) / ovalWidth;
	fh = CGRectGetHeight (rect) / ovalHeight; 
	CGContextMoveToPoint(context, fw, fh/2); 
	CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1); 
	CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); 
	CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); 
	CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); 
	CGContextClosePath(context); 
	CGContextRestoreGState(context); 
} 

- (UIImage *) roundCorners: (UIImage*) img
{
    int w = img.size.width;
    int h = img.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    addRoundedRectToPath(context, rect, 100, 100);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    UIImage* retimg = [UIImage imageWithCGImage:imageMasked];
	if (imageMasked) {
		CFRelease(imageMasked);
	}
	return retimg;
}
- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
	
	CGImageRef maskRef = maskImage.CGImage; 
	
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
										CGImageGetHeight(maskRef),
										CGImageGetBitsPerComponent(maskRef),
										CGImageGetBitsPerPixel(maskRef),
										CGImageGetBytesPerRow(maskRef),
										CGImageGetDataProvider(maskRef), NULL, false);
	
	CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
	CFRelease(mask);
	UIImage* img = [UIImage imageWithCGImage:masked];
	CFRelease(masked);
	return img;
}
+(UIImageView *) getUIImageView:(UIImage *)img
{
	UIImageView *tmpView = [ [UIImageView alloc] initWithImage:img];
	return [tmpView autorelease];
}
+(UIImage *)getUIImage:(NSString *) filePath
{
	UIImage *tmp_img = [UIImage imageNamed:filePath];
	
	if(tmp_img)
	{
		//NSLog(@"--->Image normal version %@ is loaded",filePath);
	}
	else
		NSLog(@"Image %@ load failed",filePath);
	return tmp_img;
}
+(UIImage *)getUIImage_releaseVersion:(NSString *) filePath
{
	UIImage *tmp_img  =[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath],filePath]];
	if(tmp_img)
	{
		//
		//NSLog(@"===>Image release version%@ is loaded",filePath);
	}
	else
		NSLog(@"Image %@ load failed",filePath);
	return [tmp_img autorelease];
}

+ (UIImage*)imageByCropping:(UIImage *)imageToCrop toEllipseInRect:(CGRect)rect
{
	//create a context to do our clipping in
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	CGMutablePathRef path = CGPathCreateMutable();
	
	//create a rect with the size we want to crop the image to
	//the X and Y here are zero so we start at the beginning of our
	//newly created context
	CGRect clippedRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
	CGPathAddEllipseInRect(path, NULL, clippedRect);
    CGContextAddPath(currentContext, path);
    CGContextClip(currentContext);
    CGPathRelease(path);
	//create a rect equivalent to the full size of the image
	//offset the rect by the X and Y we want to start the crop
	//from in order to cut off anything before them
	CGRect drawRect = CGRectMake(rect.origin.x * -1,
								 rect.origin.y,
								 imageToCrop.size.width,
								 imageToCrop.size.height);
	
	//Quartz 2d uses a different co-ordinate system, where the origin is in the lower left corner.
	//The x co-ordinate system matches, so you will need to flip the y co-ordinates.
	CGContextTranslateCTM(currentContext, 0, imageToCrop.size.height);
	CGContextScaleCTM(currentContext, 1.0, -1.0);
	
	//draw the image to our clipped context using our offset rect
	CGContextDrawImage(currentContext, drawRect, imageToCrop.CGImage);
	
	//pull the image from our cropped context
	UIImage *cropped = UIGraphicsGetImageFromCurrentImageContext();
	
	//pop the context to get back to the default
	UIGraphicsEndImageContext();
	
	//Note: this is autoreleased
	return cropped;
}

+(UIImage *) DefaultLoadingImage:(UIView *)view
{
    CGSize size = view.bounds.size;
    NSLog(@"w:%f h:%f",size.width,size.height);
    if (size.width == 28 && size.height == 32) {
        return [UIImage imageNamed:@"loading38x28.png"];
    }
    else if (size.width == 60 && size.height == 60) {
        return [UIImage imageNamed:@"loading60x60.png"];
    }
    else if (size.width == 65 && size.height == 65) {
        return [UIImage imageNamed:@"loading64x64.png"];
    }
    else if (size.width == 68 && size.height == 68) {
        return [UIImage imageNamed:@"loading72x72.png"];
    }
    else if (size.width == 70 && size.height == 70) {
        return [UIImage imageNamed:@"loading72x72.png"];
    }
    else if (size.width == 80 && size.height == 80) {
        return [UIImage imageNamed:@"loading80x80.png"];
    }
    else if (size.width == 130 && size.height == 130) {
        return [UIImage imageNamed:@"loading130x130.png"];
    }
    else if (size.width == 320 && size.height == 50) {
        return [UIImage imageNamed:@"loading320x94.png"];
    }
    else if (size.width == 320 && size.height == 170) {
        return [UIImage imageNamed:@"loading320x170.png"];
    }
    else if (size.width == 320 && size.height == 177) {
        return [UIImage imageNamed:@"loading320.180.png"];
    }
    else if (size.width == 320 && size.height == 436) {
        return [UIImage imageNamed:@"loading320x412.png"];
    }
    else if (size.width == 320 && size.height == 480) {
        return [UIImage imageNamed:@"loading320x412.png"];
    }

    return nil;

}
+(void) queueLoadImageFromUrl:(NSString*) url imageView:(HJManagedImageV*) imageView
{
    [imageView setImage: [self DefaultLoadingImage:imageView]];
	[imageView seturlByStr:url needEncode:NO];
	[imageView showLoadingWheel];
	imageView.mUseFilpAnimated = YES;
	[[HJObjManager shareManager] manage:imageView];
}

+(void) queueLoadImageFromUrl:(NSString *)url object:(id) object action:(SEL) action  param:(id)param{
	HJImageLoadOperationHandler* handler=[[HJImageLoadOperationHandler alloc] initWithObject:object action:action param:param];
	handler.url = [NSURL URLWithString:url];
	[[HJObjManager shareManager] manage:handler];
}

+(void) queueLoadImageFromUrl:(NSString *)url object:(id) object action:(SEL) action  param:(id)param saveFilePath:(NSString*)path
{
	HJImageLoadOperationHandler* handler=[[HJImageLoadOperationHandler alloc] initWithObject:object action:action param:param];
	handler.url = [NSURL URLWithString:url];
	handler.mSaveFilePath = path;
	[[HJObjManager shareManager] manage:handler];
}

@end