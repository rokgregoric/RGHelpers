//
//  RGNetworking.h
//
//  Created by Rok Gregorič on 18. 03. 13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGNetworking : NSObject

+ (void)asyncRequestForUrl:(NSString *)url withCompletion:(void (^)(NSData *response, NSInteger code))completion;

+ (void)asyncGetRequestForUrl:(NSString *)url withParams:(NSDictionary *)params withCompletion:(void (^)(NSData *response, NSInteger code))completion;
+ (void)asyncPostRequestForUrl:(NSString *)url withParams:(NSDictionary *)params completion:(void (^)(NSData *response, NSInteger code))completion;
+ (void)asyncPutRequestForUrl:(NSString *)url withParams:(NSDictionary *)params data:(NSData *)data completion:(void (^)(NSData *response, NSInteger code))completion;
+ (void)asyncDeleteRequestForUrl:(NSString *)url withParams:(NSDictionary *)params withCompletion:(void (^)(NSData *response, NSInteger code))completion;

@end
