//
//  FLGPhotoViewController.m
//  Everpobre
//
//  Created by Javi Alzueta on 10/4/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGPhotoViewController.h"
#import "FLGPhoto.h"

@interface FLGPhotoViewController ()

@end

@implementation FLGPhotoViewController

#pragma mark - Init

- (id) initWithModel: (FLGPhoto *) model{
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
    }
    return self;
}


#pragma mark - Life Cycle

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Sincronizo modelo -> vista
    self.photoView.image = self.model.image;
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Sincronizo vista -> modelo
    self.model.image = self.photoView.image;
}


#pragma mark - Actions

- (IBAction)takePicture:(id)sender {
    
    // Creamos un UIImagePickerController
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    // -------------- Lo configuramos ---------------
    // Compruebo si el dispositivo tiene camara
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // Uso la camara
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        // Tiro de la galeria
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    // Asigno el delegado
    picker.delegate = self;
    
    // Lo muetro de forma modal
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                        // Esto se va a ejecutar cuando termine la animacion que muestra al picker
                     }];
}

- (IBAction)applyFilter:(id)sender {
}

- (IBAction)deletePhoto:(id)sender {
}
@end
