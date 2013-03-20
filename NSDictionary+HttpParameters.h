//
//  NSDictionary+HttpParameters.h
//
//  Created by Rok Gregorič on 18. 03. 13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HttpParameters)

- (NSString *)httpEncoded;

@end
