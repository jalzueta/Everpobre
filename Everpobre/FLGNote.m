#import "FLGNote.h"
#import "FLGPhoto.h"

@interface FLGNote ()

// Private interface goes here.

@end

@implementation FLGNote

#pragma mark - Class Methods

+ (NSArray *) observableKeys{
    // Mogenerator nos crea Constantes con los nombres de las propiedades
    //  @"photo.photoData": se refiere a la propiedad "photoData" de la propiedad "photo" --> por eso se llama keyPath
    return @[FLGNoteAttributes.name, FLGNoteAttributes.text, FLGNoteRelationships.notebook, @"photo.photoData"];
}

+ (instancetype) noteWithName: (NSString *) name
                     notebook: (FLGNotebook *) notebook
                      context: (NSManagedObjectContext *) context{
    
    FLGNote *n = [FLGNote insertInManagedObjectContext:context];
    
    // Reglas de validación - propiedades obligatorias
    n.name = name;
    n.notebook = notebook;
    n.creationDate = [NSDate date]; // Fecha/hora actual en GMT. Si quieres la hora local, necesitarías guardar una instancia de NSTimezone
    n.modificationDate = [NSDate date];
    n.photo = [FLGPhoto insertInManagedObjectContext:context]; // Photo vacia de contenido
    
    return n;
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
