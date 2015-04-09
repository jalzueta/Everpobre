//
//  FLGNotesViewController.h
//  Everpobre
//
//  Created by Javi Alzueta on 9/4/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"

@class FLGNotebook;

@interface FLGNotesViewController : AGTCoreDataTableViewController

- (id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                                  style:(UITableViewStyle)aStyle
                               notebook:(FLGNotebook *) notebook;

@end
