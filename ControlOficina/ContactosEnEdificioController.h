//
//  ContactosEnEdificioController.h
//  ControlOficina
//
//  Created by Nicolas Novalbos on 3/8/15.
//  Copyright (c) 2015 Nicolas Novalbos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactosEnEdificioController : UICollectionViewController

@property (strong,nonatomic) NSMutableArray *contactosDentro;
@property (readonly, strong, nonatomic) NSManagedObjectContext *contexto;


@end
