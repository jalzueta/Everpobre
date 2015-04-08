#import "FLGNotebook.h"

@interface FLGNotebook ()

// Private interface goes here.

@end

@implementation FLGNotebook

// Custom logic goes here.


#pragma mark - Class Methods

+ (NSArray *) observableKeys{
    // Mogenerator nos crea Constantes con los nombres de las propiedades
    return @[FLGNotebookAttributes.name, FLGNotebookRelationships.notes];
}

+ (instancetype) notebookWithName: (NSString *) name
                          context: (NSManagedObjectContext *) context{
    
    FLGNotebook *nb = [self insertInManagedObjectContext:context];
    nb.name = name;
    nb.creationDate = [NSDate date];
    nb.modificationDate = [NSDate date];
    
    return nb;
}

#pragma mark - KVO

// mensaje que se recibe siempre en KVO cuando cambia cualquiera de las propiedades observadas
- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context{
    
    // Actualizo la modificationDate
    self.modificationDate = [NSDate date];
}

@end
