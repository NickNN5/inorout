//
//  Contacto.h
//  ControlOficina
//
//  Created by Nicolas Novalbos on 23/7/15.
//  Copyright (c) 2015 Nicolas Novalbos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Registro;

@interface Contacto : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * apellidos;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * telefono;
@property (nonatomic, retain) NSString * estado;
@property (nonatomic, retain) NSData * foto;
@property (nonatomic, retain) NSSet *tiene;
@end

@interface Contacto (CoreDataGeneratedAccessors)

- (void)addTieneObject:(Registro *)value;
- (void)removeTieneObject:(Registro *)value;
- (void)addTiene:(NSSet *)values;
- (void)removeTiene:(NSSet *)values;

@end
