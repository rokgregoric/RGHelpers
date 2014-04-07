//
//  RGTapGestureRecognizer.m
//
//  Created by Rok Gregorič on 7. 04. 14.
//  Copyright (c) 2014 Rok Gregorič. All rights reserved.
//

#import "RGTapGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation RGTapGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.state == UIGestureRecognizerStatePossible) {
        self.state = UIGestureRecognizerStateBegan;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    self.state = UIGestureRecognizerStateCancelled;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.state == UIGestureRecognizerStateBegan) {
        self.state = UIGestureRecognizerStateRecognized;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateCancelled;
}

@end
