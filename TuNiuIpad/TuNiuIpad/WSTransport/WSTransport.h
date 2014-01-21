//
//  WSTransport.h
//  b2c
//
//  Created by RL03 on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WSDEBUG

@interface WSTransport : NSObject {
 
}

+ (WSTransport *) globalInstance;

- (bool) getServiceResponseBool:(NSString*) function parms:(NSDictionary*) parms;
- (int) getServiceResponseInt:(NSString*) function parms:(NSDictionary*) parms;
- (id) getServiceResponseObj:(NSString*) function parms:(NSDictionary*) parms;
- (NSString *) getServiceResponseString:(NSString*) function parms:(NSDictionary*) parms;
- (double) getServiceResponseDouble:(NSString*) function parms:(NSDictionary*) parms;

//－ (int) getServiceResponseInt: (NSString *) function parms: ()

//- (int) getServiceResponseInt:(NSString*) function parms:(NSString*) parms;

@end
