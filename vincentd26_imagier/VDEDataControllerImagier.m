//
//  VDEDataControllerImagier.m
//  vincentd26_imagier
//
//  Created by Utilisation on 24/05/14.
//  Copyright (c) 2014 com.striato. All rights reserved.
//

#import "VDEDataControllerImagier.h"
#import "VDEPhotoSource.h"

@interface VDEDataControllerImagier ()

@end

@implementation VDEDataControllerImagier

-(id) initWithTableauDesPhotos {
	self=[super init];
	[self vdeInitialisationTableauDesPhotos];
			
	return self;
}


-(void) vdeInitialisationTableauDesPhotos {
//--------------------------------------------------------------------------------

	// methode de construction du tableau initial
	// i suffira de modifier ici au cas ou le sphotos viendrait d'une autre source
	// Ici, il faudrait d'ailleurs lire le nombre de photo dans un répertoire pour lire leur nom etc.. , mais ça,
	// on verra plus tard !!

	int vdeNombreDePhotos = 20;
	self.vdeTableauDesPhotosOriginales = [[NSMutableArray alloc] initWithCapacity:vdeNombreDePhotos ];
	
	

	for ( int iteration=0; iteration < vdeNombreDePhotos; iteration++) {
	
		VDEPhotoSource * vdePhoto = [[VDEPhotoSource alloc] init];
		
		NSString *vdeNomPhotoAInserer =  [NSString stringWithFormat:@"photo-%.2d.jpg",iteration+1];
		vdePhoto.vdeNomPhotoSource = vdeNomPhotoAInserer;
		
		UIImage * vdeImagePhotoSource		= [UIImage imageNamed:vdeNomPhotoAInserer];
		vdePhoto.vdeTaillePhotoSource =  vdeImagePhotoSource.size;
		
		[self.vdeTableauDesPhotosOriginales addObject:vdePhoto];
	
	}

}


@end
