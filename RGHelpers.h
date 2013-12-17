//
//  RGHelpers.h
//
//  Created by Rok Gregorič on 2/5/13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#define RGLogObj(i) NSLog(@"%s: %@", #i, i)
#define RGLogFloat(i) NSLog(@"%s: %g", #i, i)
#define RGLogInt(i) NSLog(@"%s: %d", #i, i)

#define RGLogSize(i) NSLog(@"%s width: %g, height: %g", #i, i.width, i.height)
#define RGLogPoint(i) NSLog(@"%s x: %g, y: %g", #i, i.x, i.y)
#define RGLogRect(i) NSLog(@"%s x: %g, y: %g, width: %g, height: %g", #i, i.origin.x, i.origin.y, i.size.width, i.size.height)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE_5 (UIScreen.mainScreen.bounds.size.height == 568.0f)

#define stringValue(x) [NSString stringWithFormat:@"%d", x]

#pragma mark - UIColor (IntegerConversion)

@interface UIColor (IntegerConversion)

+ (UIColor *)colorWithInt:(NSInteger)number;

@end

#pragma mark - NSString (UrlEncoding)

@interface NSString (UrlEncoding)

- (NSString *)urlEncoded;
- (NSString *)urlDecoded;

@end

#pragma mark - UIApplication (NetworkActivity)

@interface UIApplication (NetworkActivity)

- (void)setNetworkActivityIndicatorVisibleWithCounter:(BOOL)setVisible;

@end

#pragma mark - NSObject (NetworkRequest)

@interface NSObject (NetworkRequest)

- (void)asyncNetworkRequestForUrl:(NSString *)url withCompletion:(void (^)(NSData *response))completion;

@end

#pragma mark - GCD helpers

void runInForeground(void (^block)(void));
void runInBackground(void (^block)(void));
void runOnQueue(NSString *queue, void (^block)(void));
void runDelayed(double delayInSeconds, void (^block)(void));

#pragma mark - CGRect helpers

CGRect CGRectSetWidth(CGRect rect, CGFloat width);
CGRect CGRectSetHeight(CGRect rect, CGFloat height);
CGRect CGRectSetSize(CGRect rect, CGSize size);
CGRect CGRectSetX(CGRect rect, CGFloat x);
CGRect CGRectSetY(CGRect rect, CGFloat y);
CGRect CGRectSetOrigin(CGRect rect, CGPoint origin);
