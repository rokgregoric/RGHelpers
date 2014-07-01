//
//  RGTapGestureRecognizer.h
//
//  Created by Rok Gregorič on 7. 04. 14.
//  Copyright (c) 2014 Rok Gregorič. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGTapGestureRecognizer : UIGestureRecognizer

@property (nonatomic) CGFloat allowableMovement;           // Default is 10. Maximum movement in pixels allowed before the gesture fails.

@end
