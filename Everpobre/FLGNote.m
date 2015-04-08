#import "FLGNote.h"
#import "FLGPhoto.h"

@interface FLGNote ()

// Private interface goes here.

@end

@implementation FLGNote

// Custom logic goes here.

+ (instancetype) noteWithName: (NSString *) name
                     notebook: (FLGNotebook *) notebook
                      context: (NSManagedObjectContext *) context{
    
    FLGNote *n = [FLGNote insertInManagedObjectContext:context];
    
    // Reglas de validación - propiedades obligatorias
    n.name = name;
    n.notebook = notebook;
    n.creationDate = [NSDate date];
    n.modificationDate = [NSDate date];
    n.photo = [FLGPhoto insertInManagedObjectContext:context]; // Photo vacia de contenido
    
    return n;
}

@end
