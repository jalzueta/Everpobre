//
//  FLGNotebooksViewController.m
//  Everpobre
//
//  Created by Javi Alzueta on 8/4/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGNotebooksViewController.h"
#import "FLGNotebook.h"

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


#pragma mark - Utils

- (void) addNewNotebookButton{
    
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                   target:self
                                   action:@selector(addNewNotebook:)];
    
    self.navigationItem.rightBarButtonItem = addBtnItem;
}

- (void) addEditNotebookButton{
    
//    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc]
//                                   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
//                                   target:self
//                                   action:@selector(editNotebook:)];
    
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
