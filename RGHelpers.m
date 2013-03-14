//
//  RGHelpers.m
//
//  Created by Rok Gregorič on 2/5/13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#include "RGHelpers.h"

@implementation UIColor (IntegerConversion)

+ (UIColor *)colorWithInt:(NSInteger)number {
    return [UIColor colorWithRed:((number & 0xFF0000) >> 16) / 255.0
						   green:((number & 0xFF00) >> 8) / 255.0
							blue:(number & 0xFF) / 255.0
						   alpha:1];
}

@end


@implementation NSString (encoder)

- (NSString *)urlEncodedString {
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
}

- (NSString *)urlDecodedString {
	return [[self stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end


@implementation UIApplication (NetworkActivity)

- (void)setNetworkActivityIndicatorVisibleWithCounter:(BOOL)setVisible {
    static NSInteger NumberOfCallsToSetVisible = 0;
    if (setVisible)
        NumberOfCallsToSetVisible++;
    else
        NumberOfCallsToSetVisible--;

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:(NumberOfCallsToSetVisible > 0)];
}

@end


void runInForeground(void (^block)(void)) {
	if ([NSThread isMainThread]) {
		block();
	} else {
		dispatch_sync(dispatch_get_main_queue(), block);
	}
}

void runInBackground(void (^block)(void)) {
	dispatch_async(dispatch_queue_create("background queue", NULL), block);
}

void runDelayed(double delayInSeconds, void (^block)(void)) {
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), block);
}
