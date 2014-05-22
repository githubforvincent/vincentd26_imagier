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
	
	
	
	// configuration du label ratio largeur
	//--------------------------------------------------------------------------------------------------------
	vdeLabelRatioLargeur					= [[UILabel alloc ]init];
	vdeLabelRatioLargeur.TextAlignment		= NSTextAlignmentRight;
	vdeLabelRatioLargeur.font				= [UIFont systemFontOfSize:14];
	vdeLabelRatioLargeur.textColor			= [UIColor grayColor];
	
	//[vdeSousVueBas addSubview:vdeLabelRatioLargeur];
	
	// configuration du label ratio hauteur
	//--------------------------------------------------------------------------------------------------------
	vdeLabelRatioHauteur					= [[UILabel alloc ]init];
	vdeLabelRatioHauteur.TextAlignment		= NSTextAlignmentRight;
	vdeLabelRatioHauteur.font				= [UIFont systemFontOfSize:14];
	vdeLabelRatioHauteur.textColor			= [UIColor grayColor];
	
	//[vdeSousVueBas addSubview:vdeLabelRatioHauteur];
	
	
	//configuration  du slider largeur
    //--------------------------------------------------------------------------------------------------------
    vdeSliderLargeur					= [[UISlider alloc] init];
    vdeSliderLargeur.minimumValue		= 25;
    vdeSliderLargeur.maximumValue		= 400;
    vdeSliderLargeur.continuous			= YES;
    vdeSliderLargeur.value				= 100;
	vdeSliderLargeur.minimumValueImage	= [UIImage imageNamed:@"largeur_gris"];
    [vdeSliderLargeur addTarget:self action:@selector(vdeActionSliderLargeur) forControlEvents:UIControlEventValueChanged ];

    //[vdeSousVueBas addSubview:vdeSliderLargeur];
	
	//configuration  du slider hauteur
    //--------------------------------------------------------------------------------------------------------
    vdeSliderHauteur			   = [[UISlider alloc] init];
    vdeSliderHauteur.minimumValue  = 25;
    vdeSliderHauteur.maximumValue  = 400;
    vdeSliderHauteur.continuous    = YES;
    vdeSliderHauteur.value         = 100;
	vdeSliderHauteur.minimumValueImage	= [UIImage imageNamed:@"hauteur_gris"];
    [vdeSliderHauteur addTarget:self action:@selector(vdeActionSliderHauteur) forControlEvents:UIControlEventValueChanged ];
	
	// [vdeSousVueBas addSubview:vdeSliderHauteur];
						   
   //configuration du segment pour zoom
   //--------------------------------------------------------------------------------------------------------
   
   vdeTableauLabelSegments = @[@"25%",@"50%",@"100%",@"200%",@"400%"];
   vdeSegmentedControlZoom = [[UISegmentedControl alloc] initWithItems:vdeTableauLabelSegments];
   [vdeSegmentedControlZoom addTarget:self action:@selector(vdeActionSegmentZoom) forControlEvents:UIControlEventValueChanged];
   
	//[vdeSousVueBas addSubview:vdeSegmentedControlZoom];
		


	
	
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
	float vdeRatioSousVueHaut		= 0.1; // en %
	float vdeRatioSousVueZoneZoom	= 0.6;
	float vdeRatioSousVueBas		= 0.3;
	
    int vdeXSousVueHaut				= 0;
    int vdeYSousVueHaut				= vdeMargeHaut;
	int vdeLargeurSousVueHaut		= vdeLargeurVue;
	int vdeHauteurSousVueHaut		= vdeHauteurVue*vdeRatioSousVueHaut;
	
    int vdeXSousVueZoneZoom			= 0;
    int vdeYSousVueZoneZoom			= vdeHauteurSousVueHaut+vdeMargeHaut;;
	int vdeLargeurSousVueZoneZoom	= vdeLargeurVue;
	int vdeHauteurSousVueZoneZoom	= vdeHauteurVue*vdeRatioSousVueZoneZoom;
	
    int vdeXSousVueBas				= 0;
    int vdeYSousVueBas				= vdeHauteurSousVueHaut+vdeHauteurSousVueZoneZoom;
	int vdeLargeurSousVueBas		= vdeLargeurVue;
	int vdeHauteurSousVueBas		= vdeHauteurVue*vdeRatioSousVueBas;

	
	// Calcul des dimensions et coordonnées pour les éléments de chaque sous vue et placement
	//--------------------------------------------------------------------------------------------------------
		
		// TEST A FAIRE POUE LE MODE PORTRAIT PU PAYSAGE
		int vdeHauteurElement	= 30;
	
		// Zone Haut
		//--------------------------------------------------------------------------------------------------------


		int vdeXSegmentedChoixPhotos			= vdeMargeLaterale;
		int vdeYSegmentedChoixPhotos			= 0;
		int vdeLargeurSegmentedChoixPhotos		= vdeLargeurVue/4; // 1/4 de la largeur
		int vdeHauteurSegmentedChoixPhotos		= vdeHauteurElement;
	
		[vdeSegmentedChoixPhotos setFrame:CGRectMake(vdeXSegmentedChoixPhotos,
													 vdeYSegmentedChoixPhotos,
													 vdeLargeurSegmentedChoixPhotos,
													 vdeHauteurSegmentedChoixPhotos)];
		
		int vdeXLabelNomPhoto					= vdeLargeurSegmentedChoixPhotos; // texte positionné à droite
		int vdeYLabelNomPhoto					= 0;
		int vdeLargeurLabelNomPhoto				= (vdeLargeurVue/4)*3-vdeMargeLaterale; // 3/4 de la largeur
		int vdeHauteurLabelNomPhoto				= vdeHauteurElement;
	
		[vdeLabelNomPhoto setFrame:CGRectMake(vdeXLabelNomPhoto,
											  vdeYLabelNomPhoto,
											  vdeLargeurLabelNomPhoto,
											  vdeHauteurLabelNomPhoto)];
	
	
		// Zone zoom
		//--------------------------------------------------------------------------------------------------------
		int vdeXScrollViewZoneZoomPhoto				= 0;
		int vdeYScrollViewZoneZoomPhoto				= 0;
		int vdeLargeurScrollViewZoneZoomPhoto		= vdeLargeurVue;
		int vdeHauteurScrollViewZoneZoomPhoto		= vdeHauteurVue*vdeRatioSousVueZoneZoom;
	
		[vdeScrollViewZoneZoomPhoto	setFrame:CGRectMake(vdeXScrollViewZoneZoomPhoto,
														vdeYScrollViewZoneZoomPhoto,
														vdeLargeurScrollViewZoneZoomPhoto,
														vdeHauteurScrollViewZoneZoomPhoto)];

	
 
	
	
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


