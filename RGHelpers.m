//
//  RGHelpers.m
//
//  Created by Rok Gregorič on 2/5/13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#include "RGHelpers.h"

#pragma mark -
#pragma mark UIColor (IntegerConversion)

@implementation UIColor (IntegerConversion)

+ (UIColor *)colorWithInt:(NSInteger)number {
    return [UIColor colorWithRed:((number & 0xFF0000) >> 16) / 255.0
						   green:((number & 0xFF00) >> 8) / 255.0
							blue:(number & 0xFF) / 255.0
						   alpha:1];
}

@end

#pragma mark -
#pragma mark NSString (UrlEncoding)

@implementation NSString (UrlEncoding)

- (NSString *)urlEncoded {
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
}

- (NSString *)urlDecoded {
	return [[self stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end

#pragma mark -
#pragma mark UIApplication (NetworkActivity)

@implementation UIApplication (NetworkActivity)

- (void)setNetworkActivityIndicatorVisibleWithCounter:(BOOL)setVisible {
    static NSInteger NumberOfCallsToSetVisible = 0;
    if (setVisible)
        NumberOfCallsToSetVisible++;
    else
        NumberOfCallsToSetVisible--;

	UIApplication.sharedApplication.networkActivityIndicatorVisible = (NumberOfCallsToSetVisible > 0);
}

@end

#pragma mark -
#pragma mark NSObject (NetworkRequest)

@implementation NSObject (NetworkRequest)

- (void)asyncNetworkRequestForUrl:(NSString *)url withCompletion:(void (^)(NSData *response))completion {
	UIApplication.sharedApplication.networkActivityIndicatorVisibleWithCounter = YES;
	runOnQueue(@"networkRequestQueue", ^{
		for (int retries = 0; retries < 3; retries++) {
			NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
			if (data.length) {
				runInForeground(^{
					UIApplication.sharedApplication.networkActivityIndicatorVisibleWithCounter = NO;
					completion(data);
				});
				return;
			}
		}
		runInForeground(^{
			UIApplication.sharedApplication.networkActivityIndicatorVisibleWithCounter = NO;
			completion(nil);
		});
	});
}

@end

#pragma mark -
#pragma mark GDC helpers

void runInForeground(void (^block)(void)) {
	if ([NSThread isMainThread]) {
		block();
	} else {
		dispatch_sync(dispatch_get_main_queue(), block);
	}
}

void runInBackground(void (^block)(void)) {
	runOnQueue(@"backgroundQueue", block);
}

void runOnQueue(NSString *queue, void (^block)(void)) {
	dispatch_async(dispatch_queue_create([queue UTF8String], NULL), block);
}

void runDelayed(double delayInSeconds, void (^block)(void)) {
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), block);
}

#pragma mark -
#pragma mark CGRect helpers

CGRect CGRectSetWidth(CGRect rect, CGFloat width) {
    return CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height);
}

CGRect CGRectSetHeight(CGRect rect, CGFloat height) {
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height);
}

CGRect CGRectSetSize(CGRect rect, CGSize size) {
    return CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height);
}

CGRect CGRectSetX(CGRect rect, CGFloat x) {
    return CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height);
}

CGRect CGRectSetY(CGRect rect, CGFloat y) {
    return CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height);
}

CGRect CGRectSetOrigin(CGRect rect, CGPoint origin) {
    return CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height);
}
