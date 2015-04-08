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

@end
