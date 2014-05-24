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
	
	//création du tableau des photos
	int vdeNombreDePhotos = 20;
	self.vdeTableauDesPhotosOriginales = [[NSMutableArray alloc] initWithCapacity:vdeNombreDePhotos ];
	
	VDEPhotoSource * vdePhotoSource = [[VDEPhotoSource alloc] init];
	
	for ( int iteration=0; iteration < vdeNombreDePhotos; iteration++) {
		
		NSString *vdeNomPhotoAInserer =  [NSString stringWithFormat:@"photo-%.2d.jpg",iteration+1];
		vdePhotoSource.vdeNomPhotoSource = vdeNomPhotoAInserer;
		
		UIImage * vdeImagePhotoSource		= [UIImage imageNamed:vdeNomPhotoAInserer];
		vdePhotoSource.vdeTaillePhotoSource =  vdeImagePhotoSource.size;
		
		[self.vdeTableauDesPhotosOriginales addObject:vdePhotoSource];
		
	}
		
	
	return self;
}


@end
