#import "_FLGNotebook.h"

@interface FLGNotebook : _FLGNotebook {}

// Custom logic goes here.

// Metodo de clase para crear una libreta con datos
+ (instancetype) notebookWithName: (NSString *) name
                          context: (NSManagedObjectContext *) context;

@end
