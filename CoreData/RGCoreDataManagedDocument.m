//
//  RGCoreDataManagedDocument.m
//
//  Created by Rok Gregorič on 12. 03. 13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#import "RGCoreDataManagedDocument.h"
#import <CoreData/NSPersistentStoreCoordinator.h>


@implementation RGCoreDataManagedDocument

static RGCoreDataManagedDocument *_sharedInstance;

+ (RGCoreDataManagedDocument *)sharedDocument {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"CoreDataDatabase"];

        self.document = [[UIManagedDocument alloc] initWithFileURL:url];

        // Set our document up for automatic migrations
        self.document.persistentStoreOptions = @{
			NSMigratePersistentStoresAutomaticallyOption: @YES,
			NSInferMappingModelAutomaticallyOption: @YES,
		};
	}
    return self;
}

- (void)performWithDocument:(OnDocumentReady)onDocumentReady {
    void (^OnDocumentDidLoad)(BOOL) = ^(BOOL success) {
        onDocumentReady(self.document);
    };

    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.document.fileURL path]]) {
        [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:OnDocumentDidLoad];
    } else if (self.document.documentState == UIDocumentStateClosed) {
        [self.document openWithCompletionHandler:OnDocumentDidLoad];
    } else if (self.document.documentState == UIDocumentStateNormal) {
        OnDocumentDidLoad(YES);
    }
}

@end
