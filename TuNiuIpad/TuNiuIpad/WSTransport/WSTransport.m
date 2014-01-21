//
//  WSTransport.m
//  b2c
//
//  Created by RL03 on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//111111111111111111111122222222222222222222222
#import "WSTransport.h"
#import "JSON.h"

@interface WSTransport (Private)

-(NSString* ) sendRequest:(NSString*) function parms:(NSDictionary*) parms;
-(NSString*) getReturn:(NSString*) stringReply;

@end

@implementation WSTransport

WSTransport *globalInstance = nil;
static NSString * ws_header = @"<?xml version=\"1.0\" encoding=\"utf-8\"?><S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"><S:Header/><S:Body>%@</S:Body></S:Envelope>";


//static NSString *ws_server = @"http://ipad.htyou.com/mobile/htWS/JzlServicePort";
static NSString *ws_server =@"http://ipad.htyou.com/mobile/mobile";
static NSString * ws_namespace =@"http://ipad.htyou.com/mobile/mobile";

- (id)init {
	if((self = [super init])) {
		
	}
	return self;
}

+ (WSTransport *)globalInstance {
	if(globalInstance == nil) {
		globalInstance = [[WSTransport alloc] init];
	}
	return globalInstance;
}

- (bool) getServiceResponseBool:(NSString*) function parms:(NSDictionary*) parms{
	NSString* stringReply = [self sendRequest:function parms:parms];
	NSString* returnVlaue =[self getReturn:stringReply];
	bool resultBool = [returnVlaue boolValue];
	return resultBool;
}

- (int) getServiceResponseInt:(NSString*) function parms:(NSDictionary*) parms{
	NSString* stringReply = [self sendRequest:function parms:parms];
	NSString* returnVlaue =[self getReturn:stringReply];
	int resultInt = [returnVlaue  intValue];
	return resultInt;
}

- (id) getServiceResponseObj:(NSString*) function parms:(NSDictionary*) parms{
	NSLog(@"getServiceResponseObj------%@-----%@",function,parms);
    if ([function isEqualToString:@"getGoodsDetail"]) {
    }
	NSString* stringReply = [self sendRequest:function parms:parms];
	NSString* returnVlaue =[self getReturn:stringReply];
	id resultobj = [returnVlaue JSONValue];
	return resultobj;

}

- (NSString *) getServiceResponseString:(NSString*) function parms:(NSDictionary*) parms{
	NSString* stringReply = [self sendRequest:function parms:parms];
	NSString* returnVlaue =[self getReturn:stringReply];
	return returnVlaue;
}

- (double) getServiceResponseDouble:(NSString*) function parms:(NSDictionary*) parms{
	NSString* stringReply = [self sendRequest:function parms:parms];
	NSString* returnVlaue =[self getReturn:stringReply];
	double returnDouble= [returnVlaue doubleValue];
	return returnDouble;
}

-(NSString* ) sendRequest:(NSString*) function parms:(NSDictionary*) parms{
   NSLog(@"%@------%@",function,parms);
     
	NSMutableString * parmString = [NSMutableString stringWithFormat:@""];

	if(parms !=nil){
		NSArray * keys = [parms allKeys];
        NSLog(@"------%@",[parms allKeys]);
		for (NSString* key in keys) {
			[parmString appendString:[NSString stringWithFormat:@"<%@>%@</%@>",key,[parms objectForKey:key],key]];
		}
	}
	
	NSMutableString * soapFunction = [NSMutableString stringWithFormat:@"<ns2:%@ xmlns:ns2=\"%@\">%@</ns2:%@>",function,ws_namespace,parmString,function];
	NSString *soapMessage = [NSString stringWithFormat:ws_header,soapFunction];
	
        soapMessage = [soapMessage stringByReplacingOccurrencesOfString:@"&" withString:@"\\u0026"];
#ifdef WSDEBUG
        NSLog(@"--------send soap message = %@",soapMessage);
#endif
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",ws_server]];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: function forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	[theRequest setTimeoutInterval:10];
	
	NSHTTPURLResponse *response=nil;
        NSData *dataReply=nil;
	NSError * error=nil;
	
	dataReply = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
	
	if(dataReply != nil && error==nil){
		NSString* stringReply = [(NSString *)[[NSString alloc] initWithData:dataReply encoding:NSUTF8StringEncoding] autorelease];
#ifdef WSDEBUG
               NSLog(@"--------receive soap message = %@",stringReply);
		
#endif	
		return stringReply;
	}else{
		@throw [NSException exceptionWithName:@"connect error" reason:[error localizedDescription] userInfo:error.userInfo];
	}
}

-(NSString*) getReturn:(NSString*) stringReply{

	NSString * response = [stringReply stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
	NSRange returnStart = [response rangeOfString:@"<return>"];
	NSRange returnEnd = [response rangeOfString:@"</return>"];
	
	if(returnStart.location != NSNotFound && returnEnd.location != NSNotFound){
		NSRange returnRange;
		returnRange.location = returnStart.location + returnStart.length;
		returnRange.length = returnEnd.location - returnStart.location - returnStart.length;
		
		NSString * returnstr = [response substringWithRange:returnRange];
               	NSLog(@"========================returnstr = %@",returnstr);
                
		return returnstr;
	}
	
	returnStart = [response rangeOfString:@"<faultstring>"];
	returnEnd = [response rangeOfString:@"</faultstring>"];
	
	if(returnStart.location != NSNotFound && returnEnd.location != NSNotFound){
		NSRange faultRange;
		faultRange.location = returnStart.location + returnStart.length;
		faultRange.length = returnEnd.location - returnStart.location - returnStart.length;
		NSString * returnfault = [response substringWithRange:faultRange];
		
		@throw [NSException exceptionWithName:@"soap fault" reason:returnfault userInfo:nil];
	}
	return nil;
}


@end
