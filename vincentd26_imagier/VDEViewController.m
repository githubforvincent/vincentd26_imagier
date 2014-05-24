//
//  VDEViewController.m
//  vincentd26_imagier
//
//  Created by Utilisation on 22/05/14.
//  Copyright (c) 2014 com.striato. All rights reserved.
//

#import "VDEViewController.h"



@interface VDEViewController ()

@end

@implementation VDEViewController


- (void)viewDidLoad {
	//--------------------------------------------------------------------------------------------------------
    
    [super viewDidLoad];
    // initialisation vue
	vue = [[VDEMyView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[self view] addSubview:vue];
	
	//Initialisation controleur
	vdeControleurDonnes = [[VDEDataControllerImagier alloc] initWithTableauDesPhotos];
	

}

-(BOOL) shouldAutorotate {
	//--------------------------------------------------------------------------------------------------------
    return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)o duration:(NSTimeInterval)d {
//--------------------------------------------------------------------------------------------------------

    [vue vdeAffichageSuivantOrientation:o];
    
}

- (void)didReceiveMemoryWarning {
	//--------------------------------------------------------------------------------------------------------
    [super didReceiveMemoryWarning];
    NSLog(@"Alerte mémoire");
    
    
}

-(void) vdeDemandeTableauDesPhotosOriginales {
//--------------------------------------------------------------------------------------------------------
	
	
}



@end