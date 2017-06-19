//
//  addContacto.h
//  ControlOficina
//
//  Created by Nicolas Novalbos on 26/7/15.
//  Copyright (c) 2015 Nicolas Novalbos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacto.h"

@interface ContactoViewController : UIViewController

@property (weak, readonly) NSManagedObjectContext *contexto;
@property (strong) Contacto *contactoSelecconado;
@property  int mode; // 0 añadir, 1 ver detalle.

@end
