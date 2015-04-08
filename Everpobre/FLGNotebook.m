#import "FLGNotebook.h"

@interface FLGNotebook ()

// Private interface goes here.

@end

@implementation FLGNotebook

// Custom logic goes here.

+ (instancetype) notebookWithName: (NSString *) name
                          context: (NSManagedObjectContext *) context{
    
    FLGNotebook *nb = [self insertInManagedObjectContext:context];
    nb.name = name;
    nb.creationDate = [NSDate date];
    nb.modificationDate = [NSDate date];
    
    return nb;
}

@end
