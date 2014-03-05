//
//  CoreDataTableViewController.m
//
//  Created for Stanford CS193p Fall 2011.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "RGCoreDataTableViewController.h"

@interface RGCoreDataTableViewController()

@property (nonatomic) BOOL beganUpdates;

@end

@implementation RGCoreDataTableViewController

#pragma mark - Properties

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)setupDocument {
    if (!self.document) {
        [RGCoreDataManagedDocument.sharedDocument performWithDocument:^(UIManagedDocument *document) {
            self.document = document;
            [self setupFetchedResultsController];
            [self fetchDataIntoDocument];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDocument];
}

#pragma mark - Fetching

- (void)fetchDataIntoDocument {
    NSAssert(NO, @"You should override this method when subclassing %@.", NSStringFromClass(self.superclass));
}

- (void)setupFetchedResultsController {
    NSAssert(NO, @"You should override this method when subclassing %@.", NSStringFromClass(self.superclass));
}

- (void)setupSearchFetchedResultsController {
    NSAssert(NO, @"You should override this method when subclassing %@.", NSStringFromClass(self.superclass));
}

- (void)performFetch:(NSFetchedResultsController *)frc {
    if (frc) {
        if (frc.fetchRequest.predicate) {
            if (self.debug) NSLog(@"[%@ %@] fetching %@ with predicate: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), frc.fetchRequest.entityName, frc.fetchRequest.predicate);
        } else {
            if (self.debug) NSLog(@"[%@ %@] fetching all %@ (i.e., no predicate)", NSStringFromClass(self.class), NSStringFromSelector(_cmd), frc.fetchRequest.entityName);
        }
        NSError *error;
        [frc performFetch:&error];
        if (error) NSLog(@"[%@ %@] %@ (%@)", NSStringFromClass(self.class), NSStringFromSelector(_cmd), error.localizedDescription, error.localizedFailureReason);
    } else {
        if (self.debug) NSLog(@"[%@ %@] no NSFetchedResultsController (yet?)", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    }
    if (frc == self.fetchedResultsController) {
        [self.tableView reloadData];
    } else {
        [self.searchDisplayController.searchResultsTableView reloadData];
    }
}

- (void)updateFetchedResultsController:(NSFetchedResultsController *)frc {
    frc.delegate = self;
    if ((!self.title) && (!self.navigationController || !self.navigationItem.title)) {
        self.title = frc.fetchRequest.entity.name;
    }
    if (frc) {
        if (self.debug) NSLog(@"[%@ %@] set", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
        [self performFetch:frc];
    } else {
        if (self.debug) NSLog(@"[%@ %@] reset to nil", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    }
}

- (void)setFetchedResultsController:(NSFetchedResultsController *)newfrc {
    NSFetchedResultsController *oldfrc = _fetchedResultsController;
    if (newfrc != oldfrc) {
        _fetchedResultsController = newfrc;
        [self updateFetchedResultsController:newfrc];
        if (!newfrc) [self.tableView reloadData];
    }
}

- (void)setSearchFetchedResultsController:(NSFetchedResultsController *)newfrc {
    NSFetchedResultsController *oldfrc = _searchFetchedResultsController;
    if (newfrc != oldfrc) {
        _searchFetchedResultsController = newfrc;
        [self updateFetchedResultsController:newfrc];
        if (!newfrc) [self.searchDisplayController.searchResultsTableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView)
        return self.fetchedResultsController.sections.count;
    return self.searchFetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView)
        return [self.fetchedResultsController.sections[section] numberOfObjects];
    return [self.searchFetchedResultsController.sections[section] numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView)
        return [self.fetchedResultsController.sections[section] name];
    return [self.searchFetchedResultsController.sections[section] name];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (tableView == self.tableView)
        return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
    return [self.searchFetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == self.tableView)
        return self.fetchedResultsController.sectionIndexTitles;
    return self.searchFetchedResultsController.sectionIndexTitles;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)frc {
    if (!self.suspendAutomaticTrackingOfChanges) {
        if (frc == self.fetchedResultsController) {
            [self.tableView beginUpdates];
        } else {
            [self.searchDisplayController.searchResultsTableView beginUpdates];
        }
        self.beganUpdates = YES;
    }
}

- (void)controller:(NSFetchedResultsController *)frc didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    UITableView *tableView = frc == self.fetchedResultsController ? self.tableView : self.searchDisplayController.searchResultsTableView;
    NSUInteger si = frc == self.fetchedResultsController ? 1 : sectionIndex;
    if (!self.suspendAutomaticTrackingOfChanges) {
        switch(type) {
            case NSFetchedResultsChangeInsert:
                [tableView insertSections:[NSIndexSet indexSetWithIndex:si] withRowAnimation:UITableViewRowAnimationNone];
                break;

            case NSFetchedResultsChangeDelete:
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:si] withRowAnimation:UITableViewRowAnimationNone];
                break;
        }
    }
}

- (void)controller:(NSFetchedResultsController *)frc didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = frc == self.fetchedResultsController ? self.tableView : self.searchDisplayController.searchResultsTableView;
    NSIndexPath *ip1 = frc == self.fetchedResultsController ? [NSIndexPath indexPathForRow:indexPath.row inSection:1] : indexPath;
    NSIndexPath *ip2 = frc == self.fetchedResultsController ? [NSIndexPath indexPathForRow:newIndexPath.row inSection:1] : newIndexPath;
    if (!self.suspendAutomaticTrackingOfChanges) {
        switch(type) {
            case NSFetchedResultsChangeInsert:
                [tableView insertRowsAtIndexPaths:@[ip2] withRowAnimation:UITableViewRowAnimationNone];
                break;

            case NSFetchedResultsChangeDelete:
                [tableView deleteRowsAtIndexPaths:@[ip1] withRowAnimation:UITableViewRowAnimationNone];
                break;

            case NSFetchedResultsChangeUpdate:
                [tableView reloadRowsAtIndexPaths:@[ip1] withRowAnimation:UITableViewRowAnimationNone];
                break;

            case NSFetchedResultsChangeMove:
                [tableView deleteRowsAtIndexPaths:@[ip1] withRowAnimation:UITableViewRowAnimationNone];
                [tableView insertRowsAtIndexPaths:@[ip2] withRowAnimation:UITableViewRowAnimationNone];
                break;
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)frc {
    if (self.beganUpdates) {
        if (frc == self.fetchedResultsController) {
            [self.tableView endUpdates];
        } else {
            [self.searchDisplayController.searchResultsTableView endUpdates];
        }
    }
}

- (void)setSuspendAutomaticTrackingOfChanges:(BOOL)suspend {
    if (suspend) {
        _suspendAutomaticTrackingOfChanges = YES;
    } else {
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            _suspendAutomaticTrackingOfChanges = NO;
        }];
    }
}

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    [self setupSearchFetchedResultsController];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView {
    self.searchFetchedResultsController.delegate = nil;
    self.searchFetchedResultsController = nil;
}


@end
