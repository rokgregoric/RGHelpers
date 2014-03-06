//
//  RGAlertActionDelegate.h
//
//  Created by Rok Gregorič on 27. 02. 14.
//  Copyright (c) 2014 Rok Gregorič. All rights reserved.
//

//    USAGE:
//
//    __weak UIViewController *wself = self;
//    self.alertViewDelegate = [RGAlertActionDelegate delegateWithHandler:^(UIAlertView *alertView, NSInteger clickedButtonIndex) {
//        wself.alertViewDelegate = nil;
//        switch (clickedButtonIndex) {
//            case 0: { // No
//                [wself noTapped];
//            } break;
//            case 1: { // Yes
//                [wself yesTapped];
//            } break;
//        }
//    }];
//
//    UIAlertView *alertView = [UIAlertView.alloc initWithTitle:@"Question" message:@"Are you sure?" delegate:self.alertViewDelegate cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//    [alertView show];
//
//    OR
//
//    __weak UIViewController *wself = self;
//    self.actionSheetDelegate = [RGAlertActionDelegate delegateWithHandler:^(UIActionSheet *actionSheet, NSInteger clickedButtonIndex) {
//        wself.actionSheetDelegate = nil;
//        switch (clickedButtonIndex) {
//            case 0: { // No
//                [wself noTapped];
//            } break;
//            case 1: { // Yes
//                [wself yesTapped];
//            } break;
//        }
//    }];
//
//    UIActionSheet *actionSheet = [UIActionSheet.alloc initWithTitle:nil delegate:self.actionSheetDelegate cancelButtonTitle:@"No" destructiveButtonTitle:nil otherButtonTitles:@"Yes", nil];
//    [actionSheet showInView:self.view];

#import <UIKit/UIKit.h>

typedef void (^RGAlertActionDelegateHandler)(id object, NSInteger clickedButtonIndex);

@interface RGAlertActionDelegate : NSObject <UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, copy) RGAlertActionDelegateHandler handler;

+ (instancetype)delegateWithHandler:(RGAlertActionDelegateHandler)handler;

@end
