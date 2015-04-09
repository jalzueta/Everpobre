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
#import "FLGNoteViewController.h"

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

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self addNewNoteButton];
//    [self addEditNoteButton];
}

#pragma mark - Table Data Source

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

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Averiguo la nota
        FLGNote *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        // Inmediatamente lo elimino del modelo
        [self.fetchedResultsController.managedObjectContext deleteObject:n];
        
        // Para poder mover las celdas, las "notes" tendrían que tener una propiedd "userOrder" y la cambiaríamos. Hay que tener en cuenta que el orden de las celdas viene dado por los criterios de ordenación del "fetch" que se realiza, por lo que haría falta una propiedad ordinal para esa maniobra
    }
}

#pragma mark - Table Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguo la nota
    FLGNote *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear el controlador
    FLGNoteViewController *nVC = [[FLGNoteViewController alloc] initWithModel:n];
    
    // Hacer el push
    [self.navigationController pushViewController:nVC
                                         animated:YES];
}

#pragma mark - Utils

- (void) addNewNoteButton{
    
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                   target:self
                                   action:@selector(addNewNote:)];
    
    self.navigationItem.rightBarButtonItem = addBtnItem;
}

- (void) addEditNoteButton{
    
    // Toda tabla tiene un editButtonItem
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

#pragma mark - Actions

- (void) addNewNote: (id) sender{
    
    // Creamos una nueva instancia de una libreta y Core Data se encarga de notificar al fetchResultsController, y este avisa a su delegado (el controlador AGTCoreDataTableViewController)
    [FLGNote noteWithName:@"Nueva nota"
                 notebook:self.notebook
                  context:self.fetchedResultsController.managedObjectContext];
    // Todo objeto de Core Data sabe cual es su contexto, por eso se lo preguntamos a "self.fetchedResultsController"
}

@end
