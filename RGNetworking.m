//
//  RGNetworking.m
//
//  Created by Rok Gregorič on 18. 03. 13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#import "RGNetworking.h"
#import "NSDictionary+HttpParameters.h"

@implementation RGNetworking

#pragma mark -
#pragma mark URLRequest method

+ (void)asyncURLRequest:(NSMutableURLRequest *)request withCompletion:(void (^)(NSData *response, NSInteger code))completion {
	UIApplication.sharedApplication.networkActivityIndicatorVisibleWithCounter = YES;
	runOnQueue(@"networkRequestQueue", ^{
		NSError *error;
		NSHTTPURLResponse *response;
		NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
		if (error) {
			NSLog(@"RGNetworking error: %@", error);
		}
		runInForeground(^{
			UIApplication.sharedApplication.networkActivityIndicatorVisibleWithCounter = NO;
			completion(data, response.statusCode);
		});
	});
}

#pragma mark -
#pragma mark GET request method

+ (void)asyncRequestForUrl:(NSString *)url withCompletion:(void (^)(NSData *response, NSInteger code))completion {
	[RGNetworking asyncGetRequestForUrl:url withParams:nil headers:nil completion:completion];
}

+ (void)asyncGetRequestForUrl:(NSString *)url withParams:(NSDictionary *)params headers:(NSDictionary *)headers completion:(void (^)(NSData *response, NSInteger code))completion {
	if (params) {
		url = [NSString stringWithFormat:@"%@?%@", url, params.httpEncoded];
	}

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
	for (NSString *field in headers) {
		[request setValue:[headers objectForKey:field] forHTTPHeaderField:field];
	}

	[RGNetworking asyncURLRequest:request withCompletion:completion];
}

#pragma mark -
#pragma mark POST request method

+ (void)asyncPostRequestForUrl:(NSString *)url withParams:(NSDictionary *)params headers:(NSDictionary *)headers completion:(void (^)(NSData *response, NSInteger code))completion {
	NSData *data = [params.httpEncoded dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
	[request setValue:stringValue(data.length) forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	for (NSString *field in headers) {
		[request setValue:[headers objectForKey:field] forHTTPHeaderField:field];
	}
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:data];

	[RGNetworking asyncURLRequest:request withCompletion:completion];
}

#pragma mark -
#pragma mark PUT request method

+ (void)asyncPutRequestForUrl:(NSString *)url withParams:(NSDictionary *)params headers:(NSDictionary *)headers data:(NSData *)data completion:(void (^)(NSData *response, NSInteger code))completion {
	if (params) {
		url = [NSString stringWithFormat:@"%@?%@", url, params.httpEncoded];
	}

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
	[request setValue:stringValue(data.length) forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
	for (NSString *field in headers) {
		[request setValue:[headers objectForKey:field] forHTTPHeaderField:field];
	}
	[request setHTTPMethod:@"PUT"];
	[request setHTTPBody:data];

	[RGNetworking asyncURLRequest:request withCompletion:completion];
}

#pragma mark -
#pragma mark DELETE request method

+ (void)asyncDeleteRequestForUrl:(NSString *)url withParams:(NSDictionary *)params headers:(NSDictionary *)headers completion:(void (^)(NSData *response, NSInteger code))completion {
	if (params) {
		url = [NSString stringWithFormat:@"%@?%@", url, params.httpEncoded];
	}

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
	for (NSString *field in headers) {
		[request setValue:[headers objectForKey:field] forHTTPHeaderField:field];
	}
	[request setHTTPMethod:@"DELETE"];

	[RGNetworking asyncURLRequest:request withCompletion:completion];
}

@end
