//
//  RGCoreDataManagedDocument.h
//
//  Created by Rok Gregorič on 12. 03. 13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

@import UIKit;
@import CoreData;
@import Foundation;

@interface RGCoreDataManagedDocument : NSObject

// Initializer - opens the document
+ (void)openWithCompletion:(void(^)(BOOL success))completion;

// Single shared UIManagedDocument
+ (UIManagedDocument *)document;

// Single shared NSManagedObjectContext
+ (NSManagedObjectContext *)context;

// Use this method for saving the shared document
+ (void)save;

@end
