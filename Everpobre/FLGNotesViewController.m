//
//  FLGNotesViewController.m
//  Everpobre
//
//  Created by Javi Alzueta on 9/4/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGNotesViewController.h"
#import "FLGNote.h"
#import "FLGPhoto.h"
#import "FLGNotebook.h"

@interface FLGNotesViewController ()
@property (strong, nonatomic) FLGNotebook *notebook;
@end

@implementation FLGNotesViewController

- (id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                                  style:(UITableViewStyle)aStyle
                               notebook:(FLGNotebook *) notebook{
    
    if (self = [super initWithFetchedResultsController:aFetchedResultsController
                                                 style:aStyle]) {
        _notebook = notebook;
        self.title = notebook.name;
    }
    return self;
}

// El metodo que genera la celda
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguar la nota
    FLGNote *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear la celda
    static NSString *cellId = @"noteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellId];
    }
    
    // Sincronizar nota -> celda
    cell.imageView.image = n.photo.image;
    cell.textLabel.text = n.name;
    
    // Devolverla
    return cell;
}

@end
