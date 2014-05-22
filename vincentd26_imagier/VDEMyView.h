//
//  VDEMyView.h
//  vincentd26_imagier
//
//  Created by Utilisation on 22/05/14.
//  Copyright (c) 2014 com.striato. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VDEMyView : UIView < UIScrollViewDelegate > {
	
	UISegmentedControl	*vdeSegmentedChoixPhotos;
	UISegmentedControl	*vdeSegmentedControlZoom;
	
	UIStepper			*vdeStepperChoixPhotos;
	
	UIScrollView		*vdeScrollViewZoneZoomPhoto;
	
	UISlider			*vdeSliderLargeur;
	UISlider			*vdeSliderHauteur;
	
	UILabel             *vdeLabelNomPhoto;
	UILabel             *vdeLabelRatioLargeur;
	UILabel             *vdeLabelRatioHauteur;
	
	UIView				*vdeSousVueHaut;		// 10% hauteur
	UIView				*vdeSousVueZoneZoom;	// 60% hauteur
	UIView				*vdeSousVueBas;			// 30% hauteur
	
	CGRect				vdeMaFrame;
	BOOL				isIpad;
	UIImageView			*vdeImageEspace;
}
- (void) vdeAffichageSuivantOrientation:(UIInterfaceOrientation) o;

@end
