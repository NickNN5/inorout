//
//  ContactoEnEdificioCell.m
//  ControlOficina
//
//  Created by Nicolas Novalbos on 3/8/15.
//  Copyright (c) 2015 Nicolas Novalbos. All rights reserved.
//

#import "ContactoEnEdificioCell.h"

@implementation ContactoEnEdificioCell

//al tratarse de una celda de una colección, y esta ser reutilizable, hay que recargar la vista. Por lo tanto se implementa este método.
-(void) reloadInputViews{
    self.imgContacto.image = [UIImage imageWithData:self.contacto.foto];
    self.lblNombreContacto.text = self.contacto.nombre;
}

-(void) drawRect:(CGRect)rect{
    [self reloadInputViews];
}


@end
