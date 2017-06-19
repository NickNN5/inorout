//
//  ContactosTableViewController.h
//  ControlOficina
//
//  Created by Nicolas Novalbos on 23/7/15.
//  Copyright (c) 2015 Nicolas Novalbos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface ContactosTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (weak, readonly) NSManagedObjectContext *contexto;
@property (strong, nonatomic) NSFetchedResultsController *frController;
@property (strong, nonatomic) NSMutableArray * contactos;

@property (weak, nonatomic) IBOutlet UISearchBar *bar;


@end
