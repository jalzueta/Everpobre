#import "_FLGNote.h"

@interface FLGNote : _FLGNote {}
// Custom logic goes here.

+ (instancetype) noteWithName: (NSString *) name
                     notebook: (FLGNotebook *) notebook
                          context: (NSManagedObjectContext *) context;

@end
