//
//  FLGPhotoViewController.h
//  Everpobre
//
//  Created by Javi Alzueta on 10/4/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

@import UIKit;

@class FLGPhoto;

@interface FLGPhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

- (IBAction)takePicture:(id)sender;
- (IBAction)applyFilter:(id)sender;
- (IBAction)deletePhoto:(id)sender;

@property (strong, nonatomic) FLGPhoto *model;

- (id) initWithModel: (FLGPhoto *) model;

@end
