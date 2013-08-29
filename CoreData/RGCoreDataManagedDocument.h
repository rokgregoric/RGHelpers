//
//  RGCoreDataManagedDocument.h
//
//  Created by Rok Gregorič on 12. 03. 13.
//  Copyright (c) 2013 Rok Gregorič. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGCoreDataManagedDocument : NSObject

@property (nonatomic) UIManagedDocument *document;

+ (RGCoreDataManagedDocument *)sharedDocument;
- (void)performWithDocument:(void(^)(UIManagedDocument *document))onDocumentReady;

@end
