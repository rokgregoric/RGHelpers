//
//  RGHelpers.h
//
//  Created by Rok Gregorič on 2/5/13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#define RGLogObj(i) NSLog(@"%s: %@", #i, i)
#define RGLogFloat(i) NSLog(@"%s: %f", #i, i)
#define RGLogInt(i) NSLog(@"%s: %d", #i, i)

#define RGLogSize(i) NSLog(@"%s width: %f, height: %f", #i, i.width, i.height)
#define RGLogPoint(i) NSLog(@"%s x: %f, y: %f", #i, i.x, i.y)
#define RGLogRect(i) NSLog(@"%s x: %f, y: %f, width: %f, height: %f", #i, i.origin.x, i.origin.y, i.size.width, i.size.height)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568.0f)


@interface UIColor (IntegerConversion)

+ (UIColor *)colorWithInt:(NSInteger)number;

@end


@interface NSString (UrlEncoding)

- (NSString *)urlEncoded;
- (NSString *)urlDecoded;

@end


@interface UIApplication (NetworkActivity)

- (void)setNetworkActivityIndicatorVisibleWithCounter:(BOOL)setVisible;

@end


@interface NSObject (NetworkRequest)

- (void)asyncNetworkRequestForUrl:(NSString *)url withCompletion:(void (^)(NSData *response))completion;

@end


void runInForeground(void (^block)(void));
void runInBackground(void (^block)(void));
void runOnQueue(NSString *queue, void (^block)(void));
void runDelayed(double delayInSeconds, void (^block)(void));
