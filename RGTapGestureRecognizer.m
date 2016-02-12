//
//  RGTapGestureRecognizer.m
//
//  Created by Rok Gregorič on 7. 04. 14.
//  Copyright (c) 2014 Rok Gregorič. All rights reserved.
//

#import "RGTapGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface RGTapGestureRecognizer ()

@property (nonatomic) CGPoint start;

@end

@implementation RGTapGestureRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    if (self) {
        self.allowableMovement = 10;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.state == UIGestureRecognizerStatePossible) {
        self.start = [self locationInView:self.view];
        self.state = UIGestureRecognizerStateBegan;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint current = [self locationInView:self.view];

    CGFloat xDist = (current.x - self.start.x);
    CGFloat yDist = (current.y - self.start.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));

    if (distance > self.allowableMovement) {
        self.state = UIGestureRecognizerStateCancelled;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged) {
        self.state = UIGestureRecognizerStateRecognized;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateCancelled;
}

@end
