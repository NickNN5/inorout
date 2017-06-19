//
//  ContactosEnEdificioController.m
//  ControlOficina
//
//  Created by Nicolas Novalbos on 3/8/15.
//  Copyright (c) 2015 Nicolas Novalbos. All rights reserved.
//

#import "ContactosEnEdificioController.h"
#import "AppDelegate.h"
#import "ContactoEnEdificioCell.h"
#import "ContactoViewController.h"
#import "Contacto.h"

@interface ContactosEnEdificioController ()

@end

@implementation ContactosEnEdificioController

static NSString * const reuseIdentifier = @"CellContactoEnEdificio";

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.contactosDentro=[NSMutableArray new];
    [self actualizarDatos];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actualizarDatos) name: NSManagedObjectContextObjectsDidChangeNotification object:self.contexto];

    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    
    // Do any additional setup after loading the view.
}

//getter del contexto
-(NSManagedObjectContext *) contexto{
    AppDelegate *app= [[UIApplication sharedApplication] delegate];
    return app.managedObjectContext;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.e
    ContactoViewController *detalle= segue.destinationViewController;
    Contacto *seleccionado= [self.contactosDentro objectAtIndex:[self.collectionView indexPathForCell:sender].row];
    detalle.contactoSelecconado=seleccionado;
    detalle.mode=1;

}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.contactosDentro.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContactoEnEdificioCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    Contacto *contacto = [self.contactosDentro objectAtIndex:indexPath.row];
    cell.contacto=contacto;
    [cell reloadInputViews];
    
    return cell;
}



-(void)actualizarDatos{
    // tenemos que mirar en el modelo.
    NSFetchRequest * consulta= [[NSFetchRequest alloc] initWithEntityName:@"Contacto"];
    //añadimos predicado
    NSPredicate *predicado = [NSPredicate predicateWithFormat:@"estado='EnEdificio'"];
    consulta.predicate=predicado;
    NSSortDescriptor *orden= [NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES];
    NSArray *listaDeOrdenadores = [[NSArray alloc] initWithObjects:orden, nil];
    [consulta setSortDescriptors:listaDeOrdenadores];
    //ejecutamos la consulta
    NSError *error;
    NSArray *resultado= [self.contexto executeFetchRequest:consulta error:&error];
    if(error){
        NSLog(@"Ha ocurrido un error al realizar la búsqueda en la barra de búsqueda %@ %@",error, [error userInfo]);
        abort();
    }else{
        [self.contactosDentro removeAllObjects];
        [self.contactosDentro addObjectsFromArray:resultado];
    }
    [self reloadInputViews];
    
}

-(void) reloadInputViews {
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
