//
//  VDEMyView.h
//  vincentd26_imagier
//
//  Created by Utilisation on 22/05/14.
//  Copyright (c) 2014 com.striato. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VDEMyView : UIView < UIScrollViewDelegate > {
	
	UISegmentedControl	*vdeSegmentedControlZoom;
	UIStepper			*vdeStepperChoixPhotos;
	
	UIScrollView		*vdeScrollViewZoneZoomPhoto;
	
	UISlider			*vdeSliderLargeur;
	UISlider			*vdeSliderHauteur;
	
	UILabel             *vdeLabelNomPhoto;
	UILabel             *vdeLabelRatioLargeur;
	UILabel             *vdeLabelRatioHauteur;
	
	UIView				*vdeSousVueHaut;
	UIView				*vdeSousVueZoneZoom;
	UIView				*vdeSousVueBas;
	
	UIImage				*vdePhotoAAfficher;
	UIImageView			*vdeVueImageAInclureDansScrollView;
	
	CGRect				vdeMaFrame;
	BOOL				isIpad;
	UIImageView			*vdeImageEspace;
}
- (void) vdeAffichageSuivantOrientation:(UIInterfaceOrientation) o;

@end
