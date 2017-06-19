//
//  EstadoEdificioViewController.m
//  ControlOficina
//
//  Created by Nicolas Novalbos on 3/8/15.
//  Copyright (c) 2015 Nicolas Novalbos. All rights reserved.
//

#import "EstadoEdificioViewController.h"
#import "AppDelegate.h"

@interface EstadoEdificioViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblEnEdificio;
@property (weak, nonatomic) IBOutlet UILabel *lblFueraEdificio;

@end

@implementation EstadoEdificioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cargarDatos];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cargarDatos) name: NSManagedObjectContextObjectsDidChangeNotification object:self.contexto];
    
    // Do any additional setup after loading the view.
}

//metodo getter del contecfto

-(NSManagedObjectContext *) contexto{
    AppDelegate *app=[[UIApplication sharedApplication]delegate];
    return app.managedObjectContext;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) cargarDatos{
    NSFetchRequest *request=[NSFetchRequest new];
    
    NSError *error;
    NSFetchRequest *consulta= [[NSFetchRequest alloc] initWithEntityName:@"Contacto"];
    NSArray *resultadoTodas= [self.contexto executeFetchRequest:consulta error:&error];
    int totalContactos=resultadoTodas.count;
    consulta.predicate= [NSPredicate predicateWithFormat:@"estado='EnEdificio'"];
    NSArray *resultado= [self.contexto executeFetchRequest:consulta error:&error];
    int enEdificio=resultado.count;
    self.lblEnEdificio.text=[NSString stringWithFormat:@"%d",enEdificio];
    self.lblFueraEdificio.text=[NSString stringWithFormat:@"%d", (totalContactos-enEdificio)];

    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
