//
//  RGAlertActionDelegate.m
//
//  Created by Rok Gregorič on 27. 02. 14.
//  Copyright (c) 2014 Rok Gregorič. All rights reserved.
//

#import "RGAlertActionDelegate.h"

@implementation RGAlertActionDelegate

+ (instancetype)delegateWithHandler:(RGAlertActionDelegateHandler)handler {
    RGAlertActionDelegate *delegate = RGAlertActionDelegate.new;
    delegate.handler = handler;
    return delegate;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.handler) {
        self.handler(alertView, buttonIndex);
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.handler) {
        self.handler(actionSheet, buttonIndex);
    }
}

@end
