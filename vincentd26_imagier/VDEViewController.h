//
//  VDEViewController.h
//  vincentd26_imagier
//
//  Created by Utilisation on 22/05/14.
//  Copyright (c) 2014 com.striato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VDEMyView.h"
#import "VDEDataControllerImagier.h"
#import "VDEPhotoPourAfficher.h"

@interface VDEViewController : UIViewController {
    VDEMyView					*vue;
	VDEDataControllerImagier	*vdeDataControleurPhotos;
}
	
-(VDEPhotoPourAfficher*)	vdeDemandePhotosAAfficher : (int) index;

-(void) vdeMiseAJourZoomLargeur:(float)largeur
					zoomHauteur:(float)hauteur
		  pourLaPhotoAIndex:(int) index;

@end