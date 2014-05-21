//
//  NSManagedObject+Insert.m
//
//  Created by Rok Gregorič on 21. 05. 14.
//  Copyright (c) 2014 Rok Gregorič. All rights reserved.
//

#import "NSManagedObject+Insert.h"

@implementation NSManagedObject (Insert)

+ (NSString *)entityName {
    return NSStringFromClass([self class]);
}

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:context];
}

@end
