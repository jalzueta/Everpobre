//
//  AppDelegate.m
//  Everpobre
//
//  Created by Javi Alzueta on 7/4/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTCoreDataStack.h"
#import "FLGNotebook.h"
#import "FLGNote.h"

@interface AppDelegate ()
@property (strong, nonatomic) AGTCoreDataStack *stack;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Creamos una propiedad del DataStack
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"FLGModel"];
    
    // Creamos datos chorras
    [self createDummyData];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void) createDummyData{
    
    // Elimino datos anteriores
    [self.stack zapAllData];
    
    // Sin Mogenerator
//    FLGNotebook *exs = [NSEntityDescription insertNewObjectForEntityForName:@"Notebook"
//                                                     inManagedObjectContext:self.stack.context];
    
    // Con Mogenerator
//    FLGNotebook *exs = [FLGNotebook insertInManagedObjectContext:self.stack.context];
    
    // Inicializar la libreta con datos - Metodo de clase creado por nosotros
    FLGNotebook *exs = [FLGNotebook notebookWithName:@"Ex-novias para el recuerdo"
                                             context:self.stack.context];
    
    
    //Creamos nuevos objetos
    // Lo creamos y lo insertamos en el contexto. No hace falta guardarlo en un objeto
    [FLGNote noteWithName:@"Mariana Dávalos"
                 notebook:exs
                  context:self.stack.context];
    
    [FLGNote noteWithName:@"Camila Dávalos"
                 notebook:exs
                  context:self.stack.context];
    
    [FLGNote noteWithName:@"Pampita"
                 notebook:exs
                  context:self.stack.context];
    
    FLGNote *vega = [FLGNote noteWithName:@"María Teresa de la Vega"
                 notebook:exs
                  context:self.stack.context];
    
//    NSLog(@"Una nota: %@", vega);
    
    
    // Busqueda de objetos -> NSFetchRequest
    // Sin Mogenerator
//    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"Notebook"];
    
    // Con Mogenerator
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[FLGNote entityName]];
    
    // Criterios de ordenación para los resultados de la busqueda
    // caseInsensitiveCompare: compara sin tener en cuenta las mayusculas y las minusculas.
    // Si no, "U" saldría antes que "a"
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:FLGNoteAttributes.name
                                                          ascending:YES selector:@selector(caseInsensitiveCompare:)],
                            [NSSortDescriptor sortDescriptorWithKey:FLGNoteAttributes.modificationDate
                                                          ascending:NO]];
    
    // Numero maximo de objetos
//    req.fetchLimit = 10;
    
    // Numero de objetos en cada lote
    req.fetchBatchSize = 20;
    
    // Filtro de busqueda -> Mirar en el curso On-line
    // Las notas del notebook "exs"
    req.predicate = [NSPredicate predicateWithFormat:@"notebook = %@", exs];
    
    // Ejecutamos la busqueda
    // Nos devuelve algo que parece un NSArray pero no lo es, es un __NSArrayI (un objeto que cumple con la interfaz publica de los NSArray, pero que no lo es). De hecho los objetos que devuelve la busqueda no están en memoria, sino que este objeto va a buscarlos a CoreData cuando los pidamos.
    NSArray *results = [self.stack executeFetchRequest:req
                                            errorBlock:^(NSError *error) {
        NSLog(@"Error al buscar! %@", error);
    }];
    
    
    // Borrar
    // Marcamos el objeto como objeto a borrar cuando se guarde el contexto
    [self.stack.context deleteObject:vega];
    
    // Guardar
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar!: %@", error);
    }];
}


@end
