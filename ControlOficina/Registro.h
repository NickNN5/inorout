//
//  Registro.h
//  ControlOficina
//
//  Created by Nicolas Novalbos on 23/7/15.
//  Copyright (c) 2015 Nicolas Novalbos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contacto;

@interface Registro : NSManagedObject

@property (nonatomic, retain) NSDate * fecha;
@property (nonatomic, retain) NSString * tipoRegistro;
@property (nonatomic, retain) Contacto *registradoPor;

@end
