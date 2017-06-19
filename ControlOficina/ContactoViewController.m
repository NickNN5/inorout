//
//  ContactoViewController.m
//  ControlOficina
//
//  Created by Nicolas Novalbos on 26/7/15.
//  Copyright (c) 2015 Nicolas Novalbos. All rights reserved.
//

#import "ContactoViewController.h"
#import "AppDelegate.h"
#import "Contacto.h"
#import "Registro.h"
#import "RegistroContacto.h"

@interface ContactoViewController ()<UIGestureRecognizerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtNombre;
@property (weak, nonatomic) IBOutlet UITextField *txtApellidos;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtTelefono;
@property (weak, nonatomic) IBOutlet UIImageView *imgContacto;
- (IBAction)guardarContacto:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *swEstado;
@property (weak, nonatomic) IBOutlet UILabel *lblNo;
@property (weak, nonatomic) IBOutlet UILabel *lblEsta;
@property (weak, nonatomic) IBOutlet UIButton *btnGuardarMostrar;
@property (weak, nonatomic) IBOutlet UIButton *btnVerRegistro;


@end

@implementation ContactoViewController


//metodo getter del contecfto

-(NSManagedObjectContext *) contexto{
    AppDelegate *app=[[UIApplication sharedApplication]delegate];
    return app.managedObjectContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.mode==1){
        //es modo edición
        [self loadEditionConfig];
    }

    // Do any additional setup after loading the view.
    UITapGestureRecognizer* pgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handlePinch:)];
    
    pgr.delegate = self;
    pgr.numberOfTapsRequired = 1;
    
    [self.imgContacto addGestureRecognizer:pgr];
    
    
    [self.swEstado addTarget:self
                 action:@selector(cambioEstado)
       forControlEvents:UIControlEventValueChanged];
    
    

}


-(void) loadEditionConfig{
    self.txtNombre.enabled=NO;
    self.txtApellidos.enabled=NO;
    self.txtEmail.enabled=NO;
    self.txtTelefono.enabled=NO;
 
    
    self.txtNombre.text= self.contactoSelecconado.nombre;
    self.txtApellidos.text=self.contactoSelecconado.apellidos;
    self.txtEmail.text = self.contactoSelecconado.email;
    self.txtTelefono.text = self.contactoSelecconado.telefono;
    self.imgContacto.image =[UIImage imageWithData:self.contactoSelecconado.foto];
    
    if([self.contactoSelecconado.estado isEqualToString:@"EnEdificio"]){
        [self.swEstado setOn:YES];
        [self.lblEsta setHidden:NO];
        [self.lblNo setHidden:YES];
    }else{
        [self.swEstado setOn:NO];
        [self.lblEsta setHidden:YES];
        [self.lblNo setHidden:NO];
    }
    
   // [self.btnGuardarMostrar setTitle:@"Ver Registro" forState:UIControlStateNormal];
    self.btnGuardarMostrar.hidden=YES;
    self.btnGuardarMostrar.enabled=NO;
    self.btnVerRegistro.hidden=NO;
    self.btnVerRegistro.enabled=YES;
    self.title =@"Estado";
    
    

    
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    //handle pinch...
    //Mostrar de manera modal la vista del controlador para seleccionar una imagen de la galería de imágenes del dispositivo.
    if(self.mode==0){
        UIImagePickerController *picker= [UIImagePickerController new];
        picker.delegate=self;
        picker.title=@"Selecciona Foto";
    
        [self presentViewController:picker animated:YES completion:nil];
    }
}

//delagados del UIImagePiker

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //Deshacer la vista modal
    //Asignar la propiedad alpha de imgFondo a 0.
    //Asignar la nueva imagen a imgFondo.
    
    
    //Animar el cambio a 0.7 de la propiedad alpha de imgFondo.
    //Asignar la duracion de la animación mediante la propiedad value de sldVelocidad.
    //Establecer una curva Linear.
    [self dismissViewControllerAnimated:YES completion:nil];
    // self.imgFondo.alpha=0;
    self.imgContacto.image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
 //   NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    
  
    
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if(self.mode==1){
        RegistroContacto *registro= segue.destinationViewController;
        
        [registro setRegistros:[self registroContacto:self.contactoSelecconado]];
       
        registro.title=self.contactoSelecconado.nombre;
        //cargamos de manera modal el controlador.
       // [self.navigationController pushViewController:registro animated:YES];
    }else{
        //eliminamos del navigation controller lo que mete pr defecto
       // [self.navigationController popToRootViewControllerAnimated:YES];
    }

    
}


-(void) cambioEstado{
    NSString *action=nil;
    if([self.swEstado isOn]){
        [self.lblEsta setHidden:NO];
        [self.lblNo setHidden:YES];
        action=@"Entra";
        self.contactoSelecconado.estado=@"EnEdificio";
    }else{
        [self.lblEsta setHidden:YES];
        [self.lblNo setHidden:NO];
        action=@"Sale";
        self.contactoSelecconado.estado=@"FueraEdificio";
        
    }
    
    if(self.mode==1){
        //edición, tenemos que refistrar los movimientos
        /*
        Registro *registro=[NSEntityDescription insertNewObjectForEntityForName:@"Registro" inManagedObjectContext:self.contexto];
       // NSLocale* currentLocale = [NSLocale currentLocale];
       // NSDate *fecha= [[NSDate date] :currentLocale];
        NSDate *fecha = [NSDate date];
        registro.fecha=fecha;
        registro.tipoRegistro=action;
        registro.registradoPor=self.contactoSelecconado;
        NSError *error;
        [self.contexto save:&error];
        */
        [self crearRegistro:self.contactoSelecconado conAccion: action];
    }
    
   
    
}

-(void) crearRegistro:(Contacto*)contacto conAccion:(NSString*)action{
    
    //edición, tenemos que refistrar los movimientos
    Registro *registro=[NSEntityDescription insertNewObjectForEntityForName:@"Registro" inManagedObjectContext:self.contexto];
    // NSLocale* currentLocale = [NSLocale currentLocale];
    // NSDate *fecha= [[NSDate date] :currentLocale];
    NSDate *fecha = [NSDate date];
    registro.fecha=fecha;
    registro.tipoRegistro=action;
    registro.registradoPor=contacto;
    NSError *error;
    [self.contexto save:&error];

    
}

- (IBAction)guardarContacto:(id)sender {
    if(self.mode==0){
        //guardar
        Contacto *contacto=[NSEntityDescription insertNewObjectForEntityForName:@"Contacto" inManagedObjectContext:self.contexto];
        //editamos el contacto.
        contacto.nombre=self.txtNombre.text;
        contacto.apellidos=self.txtApellidos.text;
        contacto.email=self.txtEmail.text;
        contacto.telefono=self.txtTelefono.text;
        contacto.foto=UIImageJPEGRepresentation(self.imgContacto.image, 1);
        if([self.swEstado isOn]){
           contacto.estado=@"EnEdificio";
            [self crearRegistro:contacto conAccion:@"Entra"];
        }else{
            contacto.estado=@"FueraEdificio";
        }
        [self.navigationController popViewControllerAnimated:YES]; //sto o dissmiss....
    }
}

-(NSArray*) registroContacto:(Contacto*)contacto{
  
    NSSortDescriptor * nombre= [[NSSortDescriptor alloc] initWithKey:@"fecha" ascending:NO];
    NSArray *listaOrdenadores=[[NSArray alloc] initWithObjects:nombre, nil];

    NSArray *arrayRegistros= [contacto.tiene allObjects];
    arrayRegistros=[arrayRegistros sortedArrayUsingDescriptors:listaOrdenadores];
    
   return arrayRegistros;

}


@end
