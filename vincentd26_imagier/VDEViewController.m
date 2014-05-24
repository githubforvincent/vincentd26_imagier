//
//  VDEViewController.m
//  vincentd26_imagier
//
//  Created by Utilisation on 22/05/14.
//  Copyright (c) 2014 com.striato. All rights reserved.
//

#import "VDEViewController.h"
#import "VDEPhotoPourAfficher.h"


@interface VDEViewController ()

@property (nonatomic, strong)	NSMutableArray	*vdeTableauDesPhotosAAfficher;

@end

@implementation VDEViewController


- (void)viewDidLoad {
	//--------------------------------------------------------------------------------------------------------
    
    [super viewDidLoad];
    
	// initialisation vue
	vue = [[VDEMyView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[self view] addSubview:vue];
	vue.vdeViewControllerImagier = self;
	
	//Initialisation controleur
	vdeDataControleurPhotos = [[VDEDataControllerImagier alloc] initWithTableauDesPhotos];
	
	[self vdeCreationTableauDesPhotosAAfficher];
	
	// affichage de la premièer photo
	[vue vdeActionStepperChoixPhotos:vue.vdeStepperChoixPhotos];

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

-(void) vdeCreationTableauDesPhotosAAfficher {
//--------------------------------------------------------------------------------------------------------
	
	NSArray * vdeTableauRecu = [vdeDataControleurPhotos vdeTableauDesPhotosOriginales ];
	CGSize vdeZoomDefaut;
	
	// Création du tableau qui servira à la vue
	int vdeNombreDePhotos = [vdeTableauRecu count];
	self.vdeTableauDesPhotosAAfficher = [[NSMutableArray alloc] initWithCapacity:vdeNombreDePhotos];
	if (vue.isIpad ) {
		vdeZoomDefaut = CGSizeMake(0.25, 0.25);
	} else {
		vdeZoomDefaut = CGSizeMake(0.10, 0.10);
	}
	

	for ( int iteration=0; iteration < vdeNombreDePhotos; iteration++) {

		VDEPhotoPourAfficher * vdePhoto = [[VDEPhotoPourAfficher alloc] init]; // property en plus pour le zoom dans cette classe

		vdePhoto.vdeNomPhotoSource		= [vdeTableauRecu[iteration] vdeNomPhotoSource];
		vdePhoto.vdeTaillePhotoSource	= [vdeTableauRecu[iteration] vdeTaillePhotoSource];
		// valeur de zoom qui permettra de conserver le zoom du dernier affichage pour chaque photo
		vdePhoto.vdeValeursZoom			= vdeZoomDefaut;
		
		[self.vdeTableauDesPhotosAAfficher addObject:vdePhoto];
		
		 
		 }
	
}

//--------------------------------------------------------------------------------------------------------
// demande de la photo par la vue
//--------------------------------------------------------------------------------------------------------

-(VDEPhotoPourAfficher*) vdeDemandePhotosAAfficher : (int) index {
//--------------------------------------------------------------------------------------------------------
	
	return self.vdeTableauDesPhotosAAfficher[index-1];
	
}


-(void)	vdeMiseAJourZoomLargeur:(float)zoomLargeur zoomHauteur:(float)zoomHauteur pourLaPhotoAIndex:(int) index {
//--------------------------------------------------------------------------------------------------------
		
	VDEPhotoPourAfficher * vdePhotoAMettreAJour = self.vdeTableauDesPhotosAAfficher[index-1];
	//NSLog(@"test = %f",  vdePhotoAMettreAJour.vdeValeursZoom.width);
	
	vdePhotoAMettreAJour.vdeValeursZoom = CGSizeMake(zoomLargeur, zoomHauteur);
	
	
}

@end