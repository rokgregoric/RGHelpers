//
//  NSDictionary+HttpParameters.m
//
//  Created by Rok Gregorič on 18. 03. 13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#import "NSDictionary+HttpParameters.h"
#import "RGHelpers.h"

@implementation NSDictionary (HttpParameters)

- (NSString *)httpEncoded {
	NSString *params = @"";
	for (NSString *key in self) {
		params = [params stringByAppendingFormat:@"%@=%@&", key.urlEncoded, [[[self objectForKey:key] description] urlEncoded]];
	}
	return params.length ? [params substringToIndex:(params.length - 1)] : @"";
}

@end
