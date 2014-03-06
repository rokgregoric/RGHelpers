//
//  RGAlertViewDelegate.h
//
//  Created by Rok Gregorič on 27. 02. 14.
//  Copyright (c) 2014 Rok Gregorič. All rights reserved.
//

//    USAGE:
//
//    __weak UIViewController *wself = self;
//    self.alertViewDelegate = [RGAlertViewDelegate delegateWithHandler:^(UIAlertView *alertView, NSInteger clickedButtonIndex) {
//        switch (clickedButtonIndex) {
//            case 0: { // No
//                [wself noTapped];
//            } break;
//            case 1: { // Yes
//                [wself yesTapped];
//            } break;
//        }
//        wself.alertViewDelegate = nil;
//    }];
//
//    UIAlertView *alert = [UIAlertView.alloc initWithTitle:@"Question" message:@"Are you sure?" delegate:self.alertViewDelegate cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//    [alert show];

#import <UIKit/UIKit.h>

typedef void (^DelegateHandler)(UIAlertView *alertView, NSInteger clickedButtonIndex);

@interface RGAlertViewDelegate : NSObject <UIAlertViewDelegate>

@property (nonatomic, copy) DelegateHandler delegateHandler;

+ (instancetype)delegateWithHandler:(DelegateHandler)delegateHandler;

@end


