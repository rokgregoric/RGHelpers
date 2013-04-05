//
//  RGModalStoryboardSegue.m
//
//  Created by Rok Gregorič on 22. 03. 13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#import "RGModalStoryboardSegue.h"

@implementation RGModalStoryboardSegue

- (void)perform {
	UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.destinationViewController];
	[self.sourceViewController presentModalViewController:nc animated:YES];
}

@end
