//
//  ContactoEnEdificioCell.h
//  ControlOficina
//
//  Created by Nicolas Novalbos on 3/8/15.
//  Copyright (c) 2015 Nicolas Novalbos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacto.h"

@interface ContactoEnEdificioCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgContacto;
@property (weak, nonatomic) IBOutlet UILabel *lblNombreContacto;

@property (weak, nonatomic) Contacto *contacto;

@end
