//
//  FLGNoteViewController.m
//  Everpobre
//
//  Created by Javi Alzueta on 9/4/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGNoteViewController.h"
#import "FLGNote.h"

@interface FLGNoteViewController ()

@end

@implementation FLGNoteViewController

#pragma mark - Init

- (id) initWithModel: (FLGNote *) model{
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Asignamos delegados
    self.nameView.delegate = self;
    
    // Nos damos de alta en notificaciones de teclado -> las lanza UIWindow
    [self setupKeyboardNotifications];
    
    // Sincronizar modelo -> vista
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterShortStyle;
    
    self.creationDateView.text = [fmt stringFromDate:self.model.creationDate];
    self.modificationDateView.text = [fmt stringFromDate:self.model.modificationDate];
    
    self.nameView.text = self.model.name;
    self.textView.text = self.model.text;
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Baja en notificaciones de teclado
    [self tearDownKeyboardNotifications];
    
    // Sincronizo vistas -> modelo
    self.model.name = self.nameView.text;
    self.model.text = self.textView.text;
}

#pragma mark - Actions

- (IBAction)displayPhoto:(id)sender {

}

- (IBAction)hideKeyboard:(id)sender {
    // Le decimos a "view" que pare de editar, ella y todas sus subvistas
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    // Buen momento para validar el texto
//    if (textField.text.length > 0) {
//        [textField resignFirstResponder];
//        return YES;
//    }else{
//        return NO;
//    }
    
    [textField resignFirstResponder];
    return YES;
}

// Ha pasado la validación del metodo "textFieldShouldReturn"
- (void) textFieldDidEndEditing:(UITextField *)textField{
    
    // Buen momento para guardar el texto en el modelo. Nosotros lo hemos hecho en el viewWillDisappear
}


#pragma mark - keyboard Notifications

- (void) setupKeyboardNotifications{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(notifyThatKeyboardWillAppear:)
               name:UIKeyboardWillShowNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(notifyThatKeyboardWillDisappear:)
               name:UIKeyboardWillHideNotification
             object:nil];
}

- (void) tearDownKeyboardNotifications{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

// UIKeyboardWillShowNotification
- (void) notifyThatKeyboardWillAppear: (NSNotification *) n{
    
    // Sacar el tamaño (bounds) del keyboard del objeto
    // userInfo que vien en la notificacion
    
    
    // Calcular los nuevos bounds de self.textView y encogerlo mediante animación que coincida con la de aparicion del teclado
    
}

// UIKeyboardWillHideNotification
- (void) notifyThatKeyboardWillDisappear: (NSNotification *) n{
    
    // Devolver a self.textView su bounds original mediante una animacion que coincida con la del teclado
}

@end
