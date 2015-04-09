//
//  FLGNotebooksViewController.m
//  Everpobre
//
//  Created by Javi Alzueta on 8/4/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGNotebooksViewController.h"
#import "FLGNotebook.h"
#import "FLGNotesViewController.h"
#import "FLGNote.h"

@interface FLGNotebooksViewController ()

@end

@implementation FLGNotebooksViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    self.title = @"Everpobre";
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self addNewNotebookButton];
    [self addEditNotebookButton];
}

#pragma mark - Table DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguar cual es la libreta
    FLGNotebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear una celda
    static NSString *cellId = @"notebookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    // Configurarla: sincronizar libreta->celda
    cell.textLabel.text = nb.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[nb.notes count]];
    
    //Devolverla
    return cell;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Averiguo la libreta
        FLGNotebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        // Inmediatamente lo elimino del modelo
        [self.fetchedResultsController.managedObjectContext deleteObject:nb];
        
        // Para poder mover las celdas, los "notebooks" tendrían que tener una propiedd "userOrder" y la cambiaríamos. Hay que tener en cuenta que el orden de las celdas viene dado por los criterios de ordenación del "fetch" que se realiza, por lo que haría falta una propiedad ordinal para esa maniobra
    }
}

#pragma mark - Table Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguo la libreta
    FLGNotebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Creo el fetch result controller
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[FLGNote entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:FLGNoteAttributes.name
                                                          ascending:YES selector:@selector(caseInsensitiveCompare:)],
                            [NSSortDescriptor sortDescriptorWithKey:FLGNoteAttributes.modificationDate
                                                          ascending:NO]];
    
    // Numero de objetos en cada lote
    req.fetchBatchSize = 20;
    
    req.predicate = [NSPredicate predicateWithFormat:@"notebook = %@", nb];
    
    //Creo el fetch result controller
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:nb.managedObjectContext
                                      sectionNameKeyPath:nil cacheName:nil];
    
    // Creo un controlador de notas
    FLGNotesViewController *notesVC = [[FLGNotesViewController alloc]
                                       initWithFetchedResultsController:fc
                                       style:UITableViewStylePlain notebook:nb];
    
    // Hago el push
    [self.navigationController pushViewController:notesVC
                                         animated:YES];
}


#pragma mark - Utils

- (void) addNewNotebookButton{
    
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                   target:self
                                   action:@selector(addNewNotebook:)];
    
    self.navigationItem.rightBarButtonItem = addBtnItem;
}

- (void) addEditNotebookButton{
    
    // Toda tabla tiene un editButtonItem
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}


#pragma mark - Actions

- (void) addNewNotebook: (id) sender{
    
    // Creamos una nueva instancia de una libreta y Core Data se encarga de notificar al fetchResultsController, y este avisa a su delegado (el controlador AGTCoreDataTableViewController)
    [FLGNotebook notebookWithName:@"Nueva libreta"
                          context:self.fetchedResultsController.managedObjectContext];
    // Todo objeto de Core Data sabe cual es su contexto, por eso se lo preguntamos a "self.fetchedResultsController"
}


@end
