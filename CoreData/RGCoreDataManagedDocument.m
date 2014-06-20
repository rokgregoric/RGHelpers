//
//  RGCoreDataManagedDocument.m
//
//  Created by Rok Gregorič on 12. 03. 13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#import "RGCoreDataManagedDocument.h"

@implementation RGCoreDataManagedDocument

static UIManagedDocument *_document;

+ (void)load {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSURL *url = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
        url = [url URLByAppendingPathComponent:@"CoreDataDatabase"];

        _document = [[UIManagedDocument alloc] initWithFileURL:url];

        // Set our document up for automatic migrations
        _document.persistentStoreOptions = @{
            NSMigratePersistentStoresAutomaticallyOption: @YES,
            NSInferMappingModelAutomaticallyOption: @YES,
        };
    });
}

+ (void)openWithCompletion:(void(^)(BOOL success))completion {
    void (^handler)(BOOL) = ^(BOOL success) {
        if (success) {
            if (completion) completion(YES);
        } else {
            [NSFileManager.defaultManager removeItemAtURL:_document.fileURL error:nil];
            [_document saveToURL:_document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:completion];
        }
    };

    if (![NSFileManager.defaultManager fileExistsAtPath:_document.fileURL.path]) {
        [_document saveToURL:_document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:handler];
    } else if (_document.documentState == UIDocumentStateClosed) {
        [_document openWithCompletionHandler:handler];
    } else if (_document.documentState == UIDocumentStateNormal) {
        handler(YES);
    }
}

+ (UIManagedDocument *)document {
    return _document;
}

+ (NSManagedObjectContext *)context {
    return _document.managedObjectContext;
}

+ (void)save {
    [_document saveToURL:_document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:nil];
}

@end
