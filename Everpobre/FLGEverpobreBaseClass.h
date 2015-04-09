//
//  FLGEverpobreBaseClass.h
//  Everpobre
//
//  Created by Javi Alzueta on 8/4/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

@import CoreData;

@interface FLGEverpobreBaseClass : NSManagedObject

// Para hacerla la clase base para Mogeneratorejecutar en linea de comandos:
// mogenerator -v2 -m Model.xcdatamodeld/Model.xcdatamodel/ --base-class AGTEverpobreBaseClass

+ (NSArray *) observableKeys;

@end
