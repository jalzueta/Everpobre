//
//  AGTEntityObserver.h
//  CoreDataTest
//
//  Created by Fernando Rodríguez Romero on 14/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//
//
//
//  CAMBIOS EN OBJETOS RELACIONADOS
//
//  Si estás observando la clase AGTJedi que tiene una propiedad lightSabre que
//  apunta a un AGTLightSabre y este último cambia, NO se enviará el mensaje
//  de cambio al delegado, puesto que sólo se observa a AGTLighTSabre.
//
//  ¡¡ NO LLAMES A SAVE EN LOS MÉTODOS DE DELEGADO!!
//
//  La notificación NSManagedObjectContextObjectsDidChangeNotification, en la
//  que se basa esta clase, se envía cuando el contexto recibe el mensaje
//  `processPendingChanges`. Esto se hace cada vez que se termina el RunLoop.
//  Uséase:
//      * por un lado, la notificación se recibirá pasado un cierto tiempo
//      después de haber llevado a cabo la modificación de los objetos.
//
//      * además, las notificaciones se consolidan y si creas un objeto y
//      luego lo cambias, solo recibirás un aviso de creación ya con el nuevo valor
//
//  `processPendingChanges` envía la notificación cuando todavía no es
//  seguro guardar. NO envies el mensaje save al contexto desde ninguno
//  de los métodos de delegado de esta clase, o provocarás una fermosa
//  recursión infinita.
//
//  Si te es vital guardar después de uno de estos métodos, hazlo de forma aplazada,
//  mediante GCD o el mensaje performSelector:withObject:afterDelay: para que se haga
//  en la siguiente vuelta del RunLoop.
//
@import Foundation;
@import CoreData;

@class AGTEntityObserver;

@protocol AGTEntityObserverDelegate <NSObject>
@optional
-(void) entityObserver:(AGTEntityObserver *) observer didUpdateObjects:(NSSet*) objects;
-(void) entityObserver:(AGTEntityObserver *) observer didDeleteObjects:(NSSet*) objects;
-(void) entityObserver:(AGTEntityObserver *) observer didInsertObjects:(NSSet*) objects;


@end

@interface AGTEntityObserver : NSObject

@property (weak,nonatomic) id<AGTEntityObserverDelegate> delegate;

+(instancetype) entityObserverWithEntityDescription:(NSEntityDescription *) description
                             inManagedObjectContext:(NSManagedObjectContext *)context;

+(instancetype) entityObserverWithEntityName:(NSString *) name
                      inManagedObjectContext:(NSManagedObjectContext *)context;

-(id) initWithEntityDescription:(NSEntityDescription *) description
         inManagedObjectContext:(NSManagedObjectContext *)context;


-(id) initWithEntityEntityName:(NSString *) name
        inManagedObjectContext:(NSManagedObjectContext *)context;


-(void) startObserving;
-(void) stopObserving;

@end
