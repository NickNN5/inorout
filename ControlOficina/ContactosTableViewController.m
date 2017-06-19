//
//  ContactosTableViewController.m
//  ControlOficina
//
//  Created by Nicolas Novalbos on 23/7/15.
//  Copyright (c) 2015 Nicolas Novalbos. All rights reserved.
//

#import "ContactosTableViewController.h"
#import "Contacto.h"
#import "ContactoViewController.h"

@interface ContactosTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAdd;

@end

@implementation ContactosTableViewController

/*
 Implementamos el método getter del contexto

 */

-(NSManagedObjectContext *) contexto{
    AppDelegate *app= [[UIApplication sharedApplication] delegate];
    return app.managedObjectContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contactos=[NSMutableArray new];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self.tableView setContentOffset:CGPointMake(0, 45)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    // Return the number of sections.
    if(tableView == self.tableView ){
        return [[self.frController sections] count];
    }else{
        //es la tabla de la barra de búsqueda
        return 1;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(tableView == self.tableView ){
        id<NSFetchedResultsSectionInfo> infoSection= [self.frController sections] [section];
        return [infoSection numberOfObjects];
    }else{
        //es la tabla de la barra de búsqueda
        return self.contactos.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell ;
    
    if(self.tableView == tableView){
        cell = [tableView dequeueReusableCellWithIdentifier:@"celdaContacto" forIndexPath:indexPath];
        //  Contacto *contacto=[self.contactos objectAtIndex:indexPath.row];
        // Configure the cell...
        [self configurarCelda:cell indice : indexPath];
    }else{
        //es la tabla de la barra de búsqueda
        cell = [tableView cellForRowAtIndexPath:indexPath];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:nil];
        }
        [self configurarCeldaBarra:cell indice : indexPath];// es la misma de momento, no se hace otro metodo ya que mostrarán lo mismo.
    }
    
    
    return cell;
}

-(void) configurarCelda: (UITableViewCell *) cell indice:(NSIndexPath*)indexPath{
    
    Contacto *contacto=[self.frController objectAtIndexPath:indexPath];
    
    NSString *nombreAMostrar=[NSString stringWithFormat:@"%@ %@",contacto.nombre, contacto.apellidos];
    int tope=20;
    if(nombreAMostrar.length <20) tope=nombreAMostrar.length;
     cell.textLabel.text= [[NSString stringWithFormat:@"%@ %@",contacto.nombre, contacto.apellidos] substringToIndex:tope];
    if([contacto.estado isEqualToString:@"FueraEdificio"]){
        cell.detailTextLabel.textColor=[UIColor redColor];
    }else{
         cell.detailTextLabel.textColor=[UIColor blackColor];
    }
     cell.detailTextLabel.text= contacto.estado;
   
   // cell.imageView.image=[[UIImage alloc] initWithData:contacto.foto];
 
    cell.imageView.image = [UIImage imageNamed:@"Contacto.jpg"];
 
    UIImageView *iv = [[UIImageView alloc] initWithFrame:(CGRect){.size={70, self.tableView.rowHeight}}];
    iv.image=[[UIImage alloc] initWithData:contacto.foto];
    iv.backgroundColor = [UIColor whiteColor];
    iv.contentMode =  UIViewContentModeScaleAspectFit;
    iv.clipsToBounds = YES;
    [cell.contentView addSubview:iv];
  
    
}

-(void) configurarCeldaBarra: (UITableViewCell *) cell indice:(NSIndexPath*)indexPath{
    
    Contacto *contacto=[self.contactos objectAtIndex:indexPath.row];
    
    //cell.textLabel.font=[UIFont fontWithName:@"System" size:10.0];
 //    [cell.textLabel setFont:[UIFont fontWithName:@"System" size:6.0]];
    
    NSString *nombreAMostrar=[NSString stringWithFormat:@"%@ %@",contacto.nombre, contacto.apellidos];
    int tope=15;
    if(nombreAMostrar.length <15) tope=nombreAMostrar.length;
    cell.textLabel.text= [[NSString stringWithFormat:@"%@ %@",contacto.nombre, contacto.apellidos] substringToIndex:tope];
    cell.detailTextLabel.font=[UIFont fontWithName:@"System" size:8.0];
    if([contacto.estado isEqualToString:@"FueraEdificio"]){
        cell.detailTextLabel.textColor=[UIColor redColor];
    }else{
        cell.detailTextLabel.textColor=[UIColor blackColor];
    }
    cell.detailTextLabel.text= contacto.estado;
    
     //cell.imageView.image=[[UIImage alloc] initWithData:contacto.foto];
    
    cell.imageView.image = [UIImage imageNamed:@"Contacto.jpg"];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:(CGRect){.size={60, self.tableView.rowHeight}}];
    iv.image=[[UIImage alloc] initWithData:contacto.foto];
    iv.backgroundColor = [UIColor whiteColor];
    iv.contentMode =  UIViewContentModeScaleAspectFit;
    iv.clipsToBounds = YES;
    [cell.contentView addSubview:iv];
    
   
    
}




 
 
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if (tableView != self.tableView) {
         //es la tabla de la barra de busqueda
         Contacto *contacto = [self.contactos objectAtIndex:indexPath.row];
         UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         ContactoViewController * detalle = [mystoryboard instantiateViewControllerWithIdentifier:@"detalle"];
         detalle.contactoSelecconado = contacto;
          detalle.mode=1;
         [self.navigationController pushViewController:detalle animated:YES];
     }
 }
 
 




// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.frController managedObjectContext];
        [context deleteObject:[self.frController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if(sender == self.btnAdd){
        ContactoViewController *detalle= segue.destinationViewController;
        detalle.mode=0;
        
    }else{
        ContactoViewController *detalle= segue.destinationViewController;
        Contacto *seleccionado= [self.frController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        detalle.contactoSelecconado=seleccionado;
        detalle.mode=1;
    }
}



# pragma mark - Métodos relacionados con el NSFetchedResultsController

//getter
-(NSFetchedResultsController *) frController{
    if(_frController == nil){
     
        NSFetchRequest * request= [NSFetchRequest new];
        NSEntityDescription *entity= [NSEntityDescription entityForName:@"Contacto" inManagedObjectContext:self.contexto];
        
        //config la petición
        request.entity=entity;
        request.fetchBatchSize=10;
        
        //ordenamos la busqueda
        NSSortDescriptor * nombre= [[NSSortDescriptor alloc] initWithKey:@"nombre" ascending:YES];
        NSArray *listaOrdenadores=[[NSArray alloc] initWithObjects:nombre, nil];
        [request setSortDescriptors:listaOrdenadores];
        
        //creamos el fetechedResultsController
        _frController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.contexto sectionNameKeyPath:nil cacheName:@"ListadoContactos"];
        //asignamos delegado
        _frController.delegate=self;
        
        NSError *error=nil;
        if(![_frController performFetch:&error]){
            NSLog(@"Se ha producido un error al mostrar el listado de contactos."); //cambiar por alerta
            abort();
        }
        
        
        
    }
    return _frController;
}

//se llamará cuando haya modificaciones
-(void) controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

//cuando haya alguna inserción de objetos, modificación, etc.
-(void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    UITableView *table= self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [table insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            //metedo crear celda.
            [self configurarCelda:[self.tableView cellForRowAtIndexPath:indexPath] indice:indexPath];

            break;
        case NSFetchedResultsChangeMove:
            [table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
             [table insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
    
}

//se llama cuando se han terminado de realizar los cambios en el NSFetchedResultsController
-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}


//metodos delegados de la barra de busqueda:


- (BOOL)searchDisplayController:(UISearchController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    //eliminamos si hay objetos cargados
    [self.contactos removeAllObjects];
    NSFetchRequest *busqueda= [NSFetchRequest new];
    busqueda.predicate = [NSPredicate predicateWithFormat:@"estado contains[cd] %@ or nombre contains[cd] %@", searchString, searchString];
    busqueda.entity = [NSEntityDescription entityForName:@"Contacto" inManagedObjectContext:self.contexto];
    //ordenamos por nombre
    NSSortDescriptor *descriptorNombre= [[NSSortDescriptor alloc] initWithKey:@"nombre" ascending:YES];
    NSArray *listaDeOrdenadores= [[NSArray alloc] initWithObjects:descriptorNombre,nil];
    //asignamos los ordenadores
    [busqueda setSortDescriptors:listaDeOrdenadores];
    
    NSError *error;
    NSArray *resultadoAux = [self.contexto executeFetchRequest:busqueda error:&error];
    
    if(error){
        NSLog(@"Ha ocurrido un error al realizar la búsqueda en la barra de búsqueda %@ %@",error, [error userInfo]);
        abort();
    }else{
        [self.contactos addObjectsFromArray:resultadoAux];
    }
    
    
    return  YES;
}



- (void) searchDisplayContreollerDidEndSearch:(UISearchController *)controller{
    
    [self.tableView setContentOffset:CGPointMake(0, 45)];
    
}

//para recargar la lista cada vez que aparezca la barra ( al volverver de la interfaz detalle)


-(void)viewWillAppear:(BOOL)animated{
    
    if (![self.searchDisplayController.searchBar.text isEqualToString:@""]) {
        //por si se ha modificado el estado de una plaza y ya no cumple la premisa de la búsqueda
        [self searchDisplayController:self.searchDisplayController shouldReloadTableForSearchString:self.bar.text];
        //recargamos la tabla.
        [self.searchDisplayController.searchResultsTableView reloadData];
        
    }
}





@end
