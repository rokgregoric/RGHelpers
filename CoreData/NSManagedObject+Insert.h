//
//  NSManagedObject+Insert.h
//
//  Created by Rok Gregorič on 21. 05. 14.
//  Copyright (c) 2014 Rok Gregorič. All rights reserved.
//

@import CoreData;

@interface NSManagedObject (Insert)

+ (NSString *)entityName;

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context;

@end
