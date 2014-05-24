//
//  VDEMyView.h
//  vincentd26_imagier
//
//  Created by Utilisation on 22/05/14.
//  Copyright (c) 2014 com.striato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VDEViewController;

@interface VDEMyView : UIView < UIScrollViewDelegate > {
	
	UISegmentedControl	*vdeSegmentedControlZoom;

	
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
	UIImageView			*vdeImageEspace;
	int					vdeValeurZoomDeDepart;
	
}

@property (nonatomic) BOOL	isIpad;
@property (nonatomic, strong ) VDEViewController * vdeViewControllerImagier;
@property (nonatomic, strong) 	UIStepper			*vdeStepperChoixPhotos;


- (void) vdeAffichageSuivantOrientation:(UIInterfaceOrientation) o;
- (void) vdeActionStepperChoixPhotos : (UIStepper *) sender;

@end
