//
//  AGTEntityObserver.m
//  CoreDataTest
//
//  Created by Fernando Rodríguez Romero on 14/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "AGTEntityObserver.h"

@interface AGTEntityObserver ()
@property (nonatomic, strong) NSPredicate *filteringPredicate;
@property (nonatomic, strong) NSManagedObjectContext *context;
@end
@implementation AGTEntityObserver

#pragma mark - Class methods
+(instancetype) entityObserverWithEntityDescription:(NSEntityDescription *) description
                             inManagedObjectContext:(NSManagedObjectContext *)context{
    
    return [[self alloc] initWithEntityDescription:description
                            inManagedObjectContext:context];
}

+(instancetype) entityObserverWithEntityName:(NSString *) name
                      inManagedObjectContext:(NSManagedObjectContext *)context{
    
    return [[self alloc] initWithEntityEntityName:name
                           inManagedObjectContext:context];
}


#pragma mark - Init
-(id) initWithEntityDescription:(NSEntityDescription *) description
         inManagedObjectContext:(NSManagedObjectContext *)context{
    
    if (self = [super init]) {
        _context = context;
        _filteringPredicate = [self buildFilteringPredicateForEntityDescription:description inContext:context];
    }
    return self;
}

-(id) initWithEntityEntityName:(NSString *) name
        inManagedObjectContext:(NSManagedObjectContext *)context{
    
    NSEntityDescription *description = [NSEntityDescription entityForName:name
                                                   inManagedObjectContext:context];
    
    return [self initWithEntityDescription:description
                    inManagedObjectContext:context];
}

#pragma mark - Notifications
// NSManagedObjectContextObjectsDidChangeNotification
-(void)notificationThatContextDidChange:(NSNotification *)notification{
    
    // Extraer el dict
    NSDictionary *dict = notification.userInfo;
    
    // Los tres posibles casos:
    
    // Insert
    [self extractObjectsFromDictionary:dict
                               withKey:NSInsertedObjectsKey
                          sendSelector:@selector(entityObserver:didInsertObjects:)];
    
    // Delete
    [self extractObjectsFromDictionary:dict
                               withKey:NSDeletedObjectsKey
                          sendSelector:@selector(entityObserver:didDeleteObjects:)];
    
    // Update
    [self extractObjectsFromDictionary:dict
                               withKey:NSUpdatedObjectsKey
                          sendSelector:@selector(entityObserver:didUpdateObjects:)];
}

#pragma mark - State
-(void) startObserving{
    [self susbcribeToNotificationsFrom:self.context];
}
-(void) stopObserving{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

#pragma mark - Lifecycle
-(void)dealloc{
    [self stopObserving];
}


#pragma mark -  Utils
-(void) extractObjectsFromDictionary: (NSDictionary*) dict
                             withKey:(NSString *)key
                        sendSelector:(SEL) selector{
    
    // Las pragmas de abajo sirven para crear una zona de código
    // donde se ignora un cierto warning. Esto tiene sentido cuando
    // el warning realmente no aporta nada.
    //
    // En este caso, lo que ocurre es lo siguiente: cuando enviamos
    // performSelector:withObject:withObject: estamos pasando un
    // selector que el compilador desconoce por completo. El que la
    // cosa salga bien está totalmente en nuestras manos.
    // ¿Qué podría salir y causar el "leak" del que nos avisa el
    // warning?
    //
    // Nuestro selector podría devolver un objeto, y en ese caso
    // ARC no sabría muy bien qué hacer con él, puesto que no conoce
    // la firma del método: ¿debe retenerlo y liberarlo al terminar el
    // el método? ¿Debe dejarlo en paz ya que viene con un autorelease?
    //
    // En nuestro caso no devuelve nada, así que nos podemos despreocupar.
    // Podríamos obtner la firma del método que corresponde al selector
    // mediante un puntero a una función, pero haría mucho más complejo
    // nuestro código y no vale la pena.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    // Solo filtramos si tenemos un delegado implementando
    // el selector.
    if ([self.delegate respondsToSelector:selector]) {
        
        // Extraer el NSSet
        NSSet *objects = [dict objectForKey:key];
        
        // Filtrarlo con el predicado
        objects = [objects filteredSetUsingPredicate:self.filteringPredicate];
        
        // Si sobra alguien, pegamos un grito al delegado
        if (objects.count > 0) {
            [self.delegate performSelector:selector
                                withObject:self
                                withObject:objects];
        
        }

        
    }

#pragma clang diagnostic pop
    
}


-(NSPredicate *) buildFilteringPredicateForEntityDescription: (NSEntityDescription *) description inContext:(NSManagedObjectContext *) context{
    
    

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"entity.name ==%@", description.name];
    return pred;
}

-(void) susbcribeToNotificationsFrom:(NSManagedObjectContext*) context{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notificationThatContextDidChange:)
               name:NSManagedObjectContextObjectsDidChangeNotification
             object:context];
}


#pragma mark -  NSObject
-(NSString *) description{
    return [NSString stringWithFormat:@"<%@: delegate: %@>", [self class], self.delegate];
}
@end
