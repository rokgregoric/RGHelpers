//
//  RGAlertViewDelegate.m
//
//  Created by Rok Gregorič on 27. 02. 14.
//  Copyright (c) 2014 Rok Gregorič. All rights reserved.
//

#import "RGAlertViewDelegate.h"

@implementation RGAlertViewDelegate

+ (instancetype)delegateWithHandler:(DelegateHandler)delegateHandler {
    RGAlertViewDelegate *alertViewDelegate = RGAlertViewDelegate.new;
    alertViewDelegate.delegateHandler = delegateHandler;
    return alertViewDelegate;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.delegateHandler) {
        self.delegateHandler(buttonIndex);
    }
}

@end
