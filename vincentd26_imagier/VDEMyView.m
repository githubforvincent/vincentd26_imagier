//
//  VDEMyView.m
//  vincentd26_imagier
//
//  Created by Utilisation on 22/05/14.
//  Copyright (c) 2014 com.striato. All rights reserved.
//


#import "VDEMyView.h"


@implementation VDEMyView


//--------------------------------------------------------------------------------------------------------
-(id) initWithFrame:(CGRect)frame {
	//--------------------------------------------------------------------------------------------------------
    
    self= [super initWithFrame:frame ];
	
	
    if( self) {
        // recuperation du type de terminal
        if ( [[UIDevice currentDevice] userInterfaceIdiom ]== UIUserInterfaceIdiomPhone) {
            isIpad = NO;
        } else {
            isIpad = YES;
        }
    }
    

	
	//configuration subview du fond
    //--------------------------------------------------------------------------------------------------------
    // Pas de fond
	

	
	// configuration des sous-vue
	//--------------------------------------------------------------------------------------------------------
	vdeSousVueHaut		= [[UIView alloc] init];
	vdeSousVueZoneZoom	= [[UIView alloc] init];
	vdeSousVueBas		= [[UIView alloc] init];
	
	[self addSubview:vdeSousVueHaut];
	[self addSubview:vdeSousVueZoneZoom];
	[self addSubview:vdeSousVueBas];
	
    
    //configuration du segment pour choix photo
    //--------------------------------------------------------------------------------------------------------
    
	NSArray *vdeTableauLabelSegments	= @[@"<",@">"];
	vdeSegmentedChoixPhotos			= [[UISegmentedControl alloc] initWithItems:vdeTableauLabelSegments];
    [vdeSegmentedChoixPhotos addTarget:self action:@selector(vdeActionSegmentPhotos) forControlEvents:UIControlEventValueChanged];
    
	[vdeSousVueHaut addSubview:vdeSegmentedChoixPhotos];
		
	
	// configuration du label nom de photo
	//--------------------------------------------------------------------------------------------------------
	vdeLabelNomPhoto				= [[UILabel alloc ]init];
	vdeLabelNomPhoto.TextAlignment	= NSTextAlignmentRight;
	vdeLabelNomPhoto.font			= [UIFont systemFontOfSize:14];
	vdeLabelNomPhoto.textColor		= [UIColor grayColor];
	vdeLabelNomPhoto.text			= @"photo1.jpg"; // pour test

	[vdeSousVueHaut addSubview:vdeLabelNomPhoto];
	
	
	
	// configuration scroll view
	//--------------------------------------------------------------------------------------------------------
	vdeScrollViewZoneZoomPhoto									= [[UIScrollView alloc ] init];
	vdeScrollViewZoneZoomPhoto.scrollEnabled					= YES;
	vdeScrollViewZoneZoomPhoto.showsHorizontalScrollIndicator	= YES;
	vdeScrollViewZoneZoomPhoto.showsVerticalScrollIndicator		= YES;
	vdeScrollViewZoneZoomPhoto.minimumZoomScale					= 0.25;
	vdeScrollViewZoneZoomPhoto.maximumZoomScale					= 400.0;
	vdeScrollViewZoneZoomPhoto.backgroundColor					=[UIColor blackColor];
	
	[vdeSousVueZoneZoom addSubview:vdeScrollViewZoneZoomPhoto];
	
	
	
	//configuration  du slider largeur
    //--------------------------------------------------------------------------------------------------------
    vdeSliderLargeur					= [[UISlider alloc] init];
    vdeSliderLargeur.minimumValue		= 25;
    vdeSliderLargeur.maximumValue		= 400;
    vdeSliderLargeur.continuous			= YES;
    vdeSliderLargeur.value				= 100;
	vdeSliderLargeur.minimumValueImage	= [UIImage imageNamed:@"largeur_gris"];
    [vdeSliderLargeur addTarget:self action:@selector(vdeActionSliderLargeur) forControlEvents:UIControlEventValueChanged ];
	
    [vdeSousVueBas addSubview:vdeSliderLargeur];
	
	
	// configuration du label ratio largeur
	//--------------------------------------------------------------------------------------------------------
	vdeLabelRatioLargeur					= [[UILabel alloc ]init];
	vdeLabelRatioLargeur.TextAlignment		= NSTextAlignmentRight;
	vdeLabelRatioLargeur.font				= [UIFont systemFontOfSize:14];
	vdeLabelRatioLargeur.textColor			= [UIColor grayColor];
	vdeLabelRatioLargeur.text				= @"400%"; // pour test
	
	[vdeSousVueBas addSubview:vdeLabelRatioLargeur];
	
	
	//configuration  du slider hauteur
    //--------------------------------------------------------------------------------------------------------
    vdeSliderHauteur			   = [[UISlider alloc] init];
    vdeSliderHauteur.minimumValue  = 25;
    vdeSliderHauteur.maximumValue  = 400;
    vdeSliderHauteur.continuous    = YES;
    vdeSliderHauteur.value         = 100;
	vdeSliderHauteur.minimumValueImage	= [UIImage imageNamed:@"hauteur_gris"];
    [vdeSliderHauteur addTarget:self action:@selector(vdeActionSliderHauteur) forControlEvents:UIControlEventValueChanged ];
	
	[vdeSousVueBas addSubview:vdeSliderHauteur];
	
	// configuration du label ratio hauteur
	//--------------------------------------------------------------------------------------------------------
	vdeLabelRatioHauteur					= [[UILabel alloc ]init];
	vdeLabelRatioHauteur.TextAlignment		= NSTextAlignmentRight;
	vdeLabelRatioHauteur.font				= [UIFont systemFontOfSize:14];
	vdeLabelRatioHauteur.textColor			= [UIColor grayColor];
	vdeLabelRatioHauteur.text				= @"25%"; // pour test
	
	[vdeSousVueBas addSubview:vdeLabelRatioHauteur];
	

						   
   //configuration du segment pour zoom
   //--------------------------------------------------------------------------------------------------------
   
	vdeTableauLabelSegments = @[@"25%",@"50%",@"100%",@"200%",@"400%"];
	vdeSegmentedControlZoom = [[UISegmentedControl alloc] initWithItems:vdeTableauLabelSegments];
	
	//Taille police pour segment( source Internet )
	UIFont *segmentFont = [UIFont systemFontOfSize:14.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:segmentFont forKey:NSFontAttributeName];
    [vdeSegmentedControlZoom setTitleTextAttributes:attributes forState:UIControlStateNormal];
	
	[vdeSegmentedControlZoom addTarget:self action:@selector(vdeActionSegmentZoom) forControlEvents:UIControlEventValueChanged];
	
   
	[vdeSousVueBas addSubview:vdeSegmentedControlZoom];
	
	
    // positionnement des frames
    //--------------------------------------------------------------------------------------------------------
    [self vdeAffichageSuivantOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
	// on recupere l'orientation de la status bar pour connaitre l'orientation ( astuce UPMC )
    
    return self;
}


- (void) vdeAffichageSuivantOrientation:(UIInterfaceOrientation) o {
	//--------------------------------------------------------------------------------------------------------
	
	
	// rafraichissement de la frame en fonction de l'orientation
	//--------------------------------------------------------------------------------------------------------
	
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	
    if (o == UIInterfaceOrientationLandscapeLeft || o==UIInterfaceOrientationLandscapeRight)
    {
		self.frame = CGRectMake(screenRect.origin.x, screenRect.origin.y, screenRect.size.height, screenRect.size.width);
    }else {
		self.frame = CGRectMake(screenRect.origin.x, screenRect.origin.y, screenRect.size.width, screenRect.size.height);
    }
	
	// Recuperation des dimensions de l'affichage
	//--------------------------------------------------------------------------------------------------------
	
	int vdeLargeurVue, vdeHauteurVue;
    
	vdeLargeurVue = [self bounds].size.width;
	vdeHauteurVue = [self bounds].size.height;
	int vdeMargeLaterale = 20;
	int vdeMargeHaut	 = 30;
	

	
	// Calcul des dimensions et coordonnées des sous vue
	//--------------------------------------------------------------------------------------------------------

	// TEST À FAIR EPOUR MODE PORTRAIT OU PAYSAGE
	
	int vdeHauteurMiniSousVueHaut	= 50;
	int vdeHauteurMiniSousVueBas	= 150;
	int vdeHauteurCalculeeZoom		= vdeHauteurVue-vdeHauteurMiniSousVueBas-vdeHauteurMiniSousVueHaut;
	
    int vdeXSousVueHaut				= 0;
    int vdeYSousVueHaut				= vdeMargeHaut;
	int vdeLargeurSousVueHaut		= vdeLargeurVue;
	int vdeHauteurSousVueHaut		= vdeHauteurMiniSousVueHaut;
	//int vdeHauteurSousVueHaut		= (vdeHauteurVue-vdeHauteurMiniSousVueBas)*vdeRatioSousVueHaut;
	
    int vdeXSousVueZoneZoom			= 0;
    int vdeYSousVueZoneZoom			= vdeHauteurSousVueHaut+vdeMargeHaut;;
	int vdeLargeurSousVueZoneZoom	= vdeLargeurVue;
	int vdeHauteurSousVueZoneZoom	= vdeHauteurCalculeeZoom;
	
    int vdeXSousVueBas				= 0;
    int vdeYSousVueBas				= vdeHauteurSousVueHaut+vdeHauteurSousVueZoneZoom+vdeMargeHaut;
	int vdeLargeurSousVueBas		= vdeLargeurVue;
	int vdeHauteurSousVueBas		= vdeHauteurMiniSousVueBas;

	
	// Calcul des dimensions et coordonnées pour les éléments de chaque sous vue et placement
	//--------------------------------------------------------------------------------------------------------
		
	
	// Zone Haut
	//--------------------------------------------------------------------------------------------------------

	float vdeRatioEspacementZoneHaut		= 0.2; // deux espacements
	float vdeRatioHauteurElementZoneHaut	= 0.6;

	int vdeXSegmentedChoixPhotos			= vdeMargeLaterale;
	int vdeYSegmentedChoixPhotos			= vdeHauteurSousVueHaut*vdeRatioEspacementZoneHaut;
	int vdeLargeurSegmentedChoixPhotos		= vdeLargeurVue/4; // 1/4 de la largeur
	int vdeHauteurSegmentedChoixPhotos		= vdeHauteurSousVueHaut*vdeRatioHauteurElementZoneHaut;

	[vdeSegmentedChoixPhotos setFrame:CGRectMake(vdeXSegmentedChoixPhotos,
												 vdeYSegmentedChoixPhotos,
												 vdeLargeurSegmentedChoixPhotos,
												 vdeHauteurSegmentedChoixPhotos)];
	
	int vdeXLabelNomPhoto					= vdeLargeurSegmentedChoixPhotos+vdeMargeLaterale; // texte positionné à droite
	int vdeYLabelNomPhoto					= vdeHauteurSousVueHaut*vdeRatioEspacementZoneHaut;;
	int vdeLargeurLabelNomPhoto				= vdeLargeurVue-2*vdeMargeLaterale-vdeLargeurSegmentedChoixPhotos; // 3/4 de la largeur
	int vdeHauteurLabelNomPhoto				= vdeHauteurSousVueHaut*vdeRatioHauteurElementZoneHaut;

	[vdeLabelNomPhoto setFrame:CGRectMake(vdeXLabelNomPhoto,
										  vdeYLabelNomPhoto,
										  vdeLargeurLabelNomPhoto,
										  vdeHauteurLabelNomPhoto)];


	// Zone zoom
	//--------------------------------------------------------------------------------------------------------
	int vdeXScrollViewZoneZoomPhoto				= 0;
	int vdeYScrollViewZoneZoomPhoto				= 0;
	int vdeLargeurScrollViewZoneZoomPhoto		= vdeLargeurVue;
	int vdeHauteurScrollViewZoneZoomPhoto		= vdeHauteurCalculeeZoom;

	[vdeScrollViewZoneZoomPhoto	setFrame:CGRectMake(vdeXScrollViewZoneZoomPhoto,
													vdeYScrollViewZoneZoomPhoto,
													vdeLargeurScrollViewZoneZoomPhoto,
													vdeHauteurScrollViewZoneZoomPhoto)];

	// Zone bas
	//--------------------------------------------------------------------------------------------------------
	
	int vdeHauteurFixeElementsBas				= 45;
	int vdeHauteurFixeSegmentedControlZoom		= 25;
	
	int vdeEspacementZoneBas					= 0;

	
	//-------------------------------------------------------------------------
	int vdeXSliderLargeur			= vdeMargeLaterale;
	int vdeYSliderLargeur			= vdeEspacementZoneBas;
	int vdeLargeurSliderLargeur		= vdeLargeurVue*(4/5); // 4/5ième de la largeur
	int vdeHauteurSliderLargeur		= vdeHauteurFixeElementsBas;
	
	[vdeSliderLargeur setFrame:CGRectMake(vdeXSliderLargeur,
										  vdeYSliderLargeur,
										  vdeLargeurSliderLargeur,
										  vdeHauteurSliderLargeur)];
	
	//-------------------------------------------------------------------------
	int vdeXLabelRatioLargeur			= vdeMargeLaterale + vdeLargeurSliderLargeur;
	int vdeYLabelRatioLargeur			= vdeEspacementZoneBas;
	int vdeLargeurLabelRatioLargeur		= vdeLargeurVue- vdeLargeurSliderLargeur-2*vdeMargeLaterale;
	int vdeHauteurLabelRatioLargeur		= vdeHauteurFixeElementsBas;
	
	
	[vdeLabelRatioLargeur setFrame:CGRectMake(vdeXLabelRatioLargeur,
											  vdeYLabelRatioLargeur,
											  vdeLargeurLabelRatioLargeur,
											  vdeHauteurLabelRatioLargeur)];
	
	//-------------------------------------------------------------------------
	int vdeXSliderHauteur			= vdeMargeLaterale;
	int vdeYSliderHauteur			= 2*vdeEspacementZoneBas+vdeHauteurSliderLargeur;
	int vdeLargeurSliderHauteur		= vdeLargeurVue*(4/5); // 4/5ième de la largeur
	int vdeHauteurSliderHauteur		= vdeHauteurFixeElementsBas;
	
	[vdeSliderHauteur setFrame:CGRectMake(vdeXSliderHauteur,
										  vdeYSliderHauteur,
										  vdeLargeurSliderHauteur,
										  vdeHauteurSliderHauteur)];
	
	//-------------------------------------------------------------------------
	int vdeXLabelRatioHauteur			= vdeMargeLaterale + vdeLargeurSliderLargeur;
	int vdeYLabelRatioHauteur			= 2*vdeEspacementZoneBas+vdeHauteurSliderLargeur;
	int vdeLargeurLabelRatioHauteur		= vdeLargeurVue- vdeLargeurSliderLargeur-2*vdeMargeLaterale;
	int vdeHauteurLabelRatioHauteur		= vdeHauteurFixeElementsBas;
	
	[vdeLabelRatioHauteur setFrame:CGRectMake(vdeXLabelRatioHauteur	,
											  vdeYLabelRatioHauteur	,
											  vdeLargeurLabelRatioHauteur,
											  vdeHauteurLabelRatioHauteur)];
	
	//-------------------------------------------------------------------------
	int vdeXSegmentedControlZoom			= vdeMargeLaterale ;
	int vdeYSegmentedControlZoom			= 3*vdeEspacementZoneBas+2*vdeHauteurFixeElementsBas;
	int vdeLargeurSegmentedControlZoom		= vdeLargeurVue-2*vdeMargeLaterale;
	int vdeHauteurSegmentedControlZoom		= vdeHauteurFixeSegmentedControlZoom;

	
	[vdeSegmentedControlZoom setFrame:CGRectMake(vdeXSegmentedControlZoom,
												 vdeYSegmentedControlZoom	,
												 vdeLargeurSegmentedControlZoom,
												 vdeHauteurSegmentedControlZoom)];
	
	// placement des sous vue dans la fenetre
    //--------------------------------------------------------------------------------------------------------
    
	
	[vdeSousVueHaut		setFrame:CGRectMake(vdeXSousVueHaut,
											vdeYSousVueHaut,
											vdeLargeurSousVueHaut,
											vdeHauteurSousVueHaut)];
	
	[vdeSousVueZoneZoom setFrame:CGRectMake(vdeXSousVueZoneZoom,
											vdeYSousVueZoneZoom,
											vdeLargeurSousVueZoneZoom,
											vdeHauteurScrollViewZoneZoomPhoto)];
	
	[vdeSousVueBas		setFrame:CGRectMake(vdeXSousVueBas,
											vdeYSousVueBas,
											vdeLargeurSousVueBas,
											vdeHauteurSousVueBas)];
}

//--------------------------------------------------------------------------------------------------------
// LES ACTIONS
//--------------------------------------------------------------------------------------------------------


-(void)vdeActionSegmentPhotos {
//--------------------------------------------------------------------------------------------------------
	
}


-(void) vdeActionSliderLargeur {
//--------------------------------------------------------------------------------------------------------
	
}


-(void) vdeActionSliderHauteur {
//--------------------------------------------------------------------------------------------------------
	
}


-(void) vdeActionSegmentZoom {
//--------------------------------------------------------------------------------------------------------
	
}

//--------------------------------------------------------------------------------------------------------
// LES DELEGATES DE SCROLL VIEW
//--------------------------------------------------------------------------------------------------------




//--------------------------------------------------------------------------------------------------------

@end


