//
//  VDEMyView.m
//  vincentd26_imagier
//
//  Created by Utilisation on 22/05/14.
//  Copyright (c) 2014 com.striato. All rights reserved.
//


#import "VDEMyView.h"
#import "VDEPhotoPourAfficher.h"
#import "VDEViewController.h"

@interface VDEMyView ()

@property (nonatomic, strong) VDEPhotoPourAfficher *vdePhotoPourAfficher;

@end

@implementation VDEMyView



//--------------------------------------------------------------------------------------------------------
// AFFICHAGE INITIAL
//--------------------------------------------------------------------------------------------------------
-(id) initWithFrame:(CGRect)frame {
//--------------------------------------------------------------------------------------------------------
    
    self= [super initWithFrame:frame ];
	if( self) {
		
	self.vdeViewControllerImagier	= [[VDEViewController alloc] init];
		self.vdePhotoPourAfficher	= [[VDEPhotoPourAfficher alloc]init];

    // Détermination type de terminal si besoin par la suite
	//--------------------------------------------------------------------------------------------------------

        // recuperation du type de terminal
        if ( [[UIDevice currentDevice] userInterfaceIdiom ]== UIUserInterfaceIdiomPhone) {
            self.isIpad = NO;
			vdeValeurZoomDeDepart = 10;
        } else {
            self.isIpad = YES;
			vdeValeurZoomDeDepart = 25;
        }
    
	
	// initialisation de la scrollView
	//--------------------------------------------------------------------------------------------------------

	vdeVueImageAInclureDansScrollView	= [[UIImageView alloc] init];
    
	//configuration subview du fond
    //--------------------------------------------------------------------------------------------------------
    // Pas de fond
		
	// configuration des sous-vue
	//--------------------------------------------------------------------------------------------------------
	vdeSousVueHaut		= [[UIView alloc] init];
	vdeSousVueZoneZoom	= [[UIView alloc] init];
	vdeSousVueBas			= [[UIView alloc] init];
	
	[self addSubview:vdeSousVueHaut];
	[self addSubview:vdeSousVueZoneZoom];
	[self addSubview:vdeSousVueBas];
    
	
	//configuration du Stepper choix photo
    //--------------------------------------------------------------------------------------------------------
    self.vdeStepperChoixPhotos				   = [[UIStepper alloc] init];
    self.vdeStepperChoixPhotos.maximumValue     = 20;
    self.vdeStepperChoixPhotos.minimumValue     = 1;
    self.vdeStepperChoixPhotos.stepValue        = 1;
	self.vdeStepperChoixPhotos.Value			   = 1;
    [self.vdeStepperChoixPhotos addTarget:self action:@selector(vdeActionStepperChoixPhotos:) forControlEvents:UIControlEventValueChanged];
	
    [vdeSousVueHaut addSubview:self.vdeStepperChoixPhotos];

	
	// configuration du label nom de photo
	//--------------------------------------------------------------------------------------------------------
	vdeLabelNomPhoto				= [[UILabel alloc ]init];
	vdeLabelNomPhoto.TextAlignment	= NSTextAlignmentRight;
	vdeLabelNomPhoto.font			= [UIFont systemFontOfSize:14];
	vdeLabelNomPhoto.textColor		= [UIColor grayColor];
	vdeLabelNomPhoto.text			= @"photo-01.jpg";

	[vdeSousVueHaut addSubview:vdeLabelNomPhoto];
	
	// configuration scroll view
	//--------------------------------------------------------------------------------------------------------
	vdeScrollViewZoneZoomPhoto									= [[UIScrollView alloc ] init];
	vdeScrollViewZoneZoomPhoto.delegate						= self;
	vdeScrollViewZoneZoomPhoto.scrollEnabled					= YES;
	vdeScrollViewZoneZoomPhoto.showsHorizontalScrollIndicator	= YES;
	vdeScrollViewZoneZoomPhoto.showsVerticalScrollIndicator		= YES;
	vdeScrollViewZoneZoomPhoto.minimumZoomScale					= 0.10;
	vdeScrollViewZoneZoomPhoto.maximumZoomScale					= 2.0;
	vdeScrollViewZoneZoomPhoto.backgroundColor					= [UIColor blackColor];
	

	[vdeScrollViewZoneZoomPhoto addSubview:vdeVueImageAInclureDansScrollView]; // Vue à insérer dans le scrollView
	
	[vdeSousVueZoneZoom addSubview:vdeScrollViewZoneZoomPhoto];
	
	//configuration  du slider largeur
    //--------------------------------------------------------------------------------------------------------
    vdeSliderLargeur					= [[UISlider alloc] init];
    vdeSliderLargeur.minimumValue		= 10;
    vdeSliderLargeur.maximumValue		= 200;
    vdeSliderLargeur.continuous			= YES;
    vdeSliderLargeur.value				= vdeValeurZoomDeDepart;
	vdeSliderLargeur.minimumValueImage	= [UIImage imageNamed:@"largeur_gris"];
    [vdeSliderLargeur addTarget:self action:@selector(vdeActionSliderLargeur:) forControlEvents:UIControlEventValueChanged ];
	
    [vdeSousVueBas addSubview:vdeSliderLargeur];
	
	// configuration du label ratio largeur
	//--------------------------------------------------------------------------------------------------------
	vdeLabelRatioLargeur					= [[UILabel alloc ]init];
	vdeLabelRatioLargeur.TextAlignment		= NSTextAlignmentRight;
	vdeLabelRatioLargeur.font				= [UIFont systemFontOfSize:14];
	vdeLabelRatioLargeur.textColor			= [UIColor grayColor];
	vdeLabelRatioLargeur.text				= [NSString stringWithFormat:@"%d %%", vdeValeurZoomDeDepart];
	
	[vdeSousVueBas addSubview:vdeLabelRatioLargeur];
		
	//configuration  du slider hauteur
    //--------------------------------------------------------------------------------------------------------
    vdeSliderHauteur			   = [[UISlider alloc] init];
    vdeSliderHauteur.minimumValue  = 10;
    vdeSliderHauteur.maximumValue  = 200;
    vdeSliderHauteur.continuous    = YES;
    vdeSliderHauteur.value         = vdeValeurZoomDeDepart;
	vdeSliderHauteur.minimumValueImage	= [UIImage imageNamed:@"hauteur_gris"];
    [vdeSliderHauteur addTarget:self action:@selector(vdeActionSliderHauteur:) forControlEvents:UIControlEventValueChanged ];
	
	[vdeSousVueBas addSubview:vdeSliderHauteur];
	
	// configuration du label ratio hauteur
	//--------------------------------------------------------------------------------------------------------
	vdeLabelRatioHauteur					= [[UILabel alloc ]init];
	vdeLabelRatioHauteur.TextAlignment		= NSTextAlignmentRight;
	vdeLabelRatioHauteur.font				= [UIFont systemFontOfSize:14];
	vdeLabelRatioHauteur.textColor			= [UIColor grayColor];
	vdeLabelRatioHauteur.text				= [NSString stringWithFormat:@"%d %%", vdeValeurZoomDeDepart];
	
	[vdeSousVueBas addSubview:vdeLabelRatioHauteur];
	

		
	//configuration du segment pour zoom
	//--------------------------------------------------------------------------------------------------------
   
	NSArray * vdeTableauLabelSegments = @[@"10%",@"25%",@"50%",@"100%",@"200%"];
	vdeSegmentedControlZoom = [[UISegmentedControl alloc] initWithItems:vdeTableauLabelSegments];
	
	//Taille police pour segment( source Internet )
	UIFont *segmentFont = [UIFont systemFontOfSize:14.0f];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:segmentFont forKey:NSFontAttributeName];
    [vdeSegmentedControlZoom setTitleTextAttributes:attributes forState:UIControlStateNormal];
	
	[vdeSegmentedControlZoom addTarget:self action:@selector(vdeActionSegmentZoom:) forControlEvents:UIControlEventValueChanged];
	
	[vdeSousVueBas addSubview:vdeSegmentedControlZoom];

	
    // positionnement des frames
    //--------------------------------------------------------------------------------------------------------
    // on recupere l'orientation de la status bar pour connaitre l'orientation ( astuce UPMC )
	[self vdeAffichageSuivantOrientation:[[UIApplication sharedApplication] statusBarOrientation]];

		
	} // fin du if self
    
	return self;
}

//--------------------------------------------------------------------------------------------------------
-(void) vdeAffichageSuivantOrientation:(UIInterfaceOrientation) o {
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
	
	int vdeHauteurFixeSousVueHaut	= 50;
	int vdeHauteurFixeSousVueBas	= 150;
	int vdeHauteurCalculeeZoom		= vdeHauteurVue-vdeHauteurFixeSousVueBas-vdeHauteurFixeSousVueHaut;
	
    int vdeXSousVueHaut				= 0;
    int vdeYSousVueHaut				= vdeMargeHaut;
	int vdeLargeurSousVueHaut		= vdeLargeurVue;
	int vdeHauteurSousVueHaut		= vdeHauteurFixeSousVueHaut;
	
    int vdeXSousVueZoneZoom			= 0;
    int vdeYSousVueZoneZoom			= vdeHauteurSousVueHaut+vdeMargeHaut;;
	int vdeLargeurSousVueZoneZoom	= vdeLargeurVue;
	int vdeHauteurSousVueZoneZoom	= vdeHauteurCalculeeZoom;
	
    int vdeXSousVueBas				= 0;
    int vdeYSousVueBas				= vdeHauteurSousVueHaut+vdeHauteurSousVueZoneZoom+vdeMargeHaut;
	int vdeLargeurSousVueBas		= vdeLargeurVue;
	int vdeHauteurSousVueBas		= vdeHauteurFixeSousVueBas;

	
	// Calcul des dimensions et coordonnées pour les éléments de chaque sous vue et placement
	//--------------------------------------------------------------------------------------------------------
			
	// Zone Haut
	//--------------------------------------------------------------------------------------------------------

	float vdeRatioEspacementZoneHaut		= 0.2; // deux espacements
	float vdeRatioHauteurElementZoneHaut	= 0.6;

	int vdeXStepperChoixPhotos				= vdeMargeLaterale;
	int vdeYStepperChoixPhotos				= vdeHauteurSousVueHaut*vdeRatioEspacementZoneHaut;
	int vdeLargeurStepperChoixPhotos		= vdeLargeurVue/4; // 1/4 de la largeur
	int vdeHauteurStepperChoixPhotos		= vdeHauteurSousVueHaut*vdeRatioHauteurElementZoneHaut;
	
	[self.vdeStepperChoixPhotos setFrame:CGRectMake(vdeXStepperChoixPhotos,
												 vdeYStepperChoixPhotos,
												 vdeLargeurStepperChoixPhotos,
												 vdeHauteurStepperChoixPhotos)];
	
	
	int vdeXLabelNomPhoto					= vdeLargeurStepperChoixPhotos+vdeMargeLaterale; // texte positionné à droite
	int vdeYLabelNomPhoto					= vdeHauteurSousVueHaut*vdeRatioEspacementZoneHaut;;
	int vdeLargeurLabelNomPhoto				= vdeLargeurVue-2*vdeMargeLaterale-vdeLargeurStepperChoixPhotos; // 3/4 de la largeur
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
	int vdeEspacementZoneBas					= 0;   // ??

	
	//-------------------------------------------------------------------------
	int vdeLargeurLabelRatioLargeur		= 50;
	int vdeXLabelRatioLargeur			= vdeLargeurVue - vdeLargeurLabelRatioLargeur - vdeMargeLaterale;
	int vdeYLabelRatioLargeur			= vdeEspacementZoneBas;
	int vdeHauteurLabelRatioLargeur		= vdeHauteurFixeElementsBas;
	
	
	[vdeLabelRatioLargeur setFrame:CGRectMake(vdeXLabelRatioLargeur,
											  vdeYLabelRatioLargeur,
											  vdeLargeurLabelRatioLargeur,
											  vdeHauteurLabelRatioLargeur)];
	
	//-------------------------------------------------------------------------
	int vdeXSliderLargeur			= vdeMargeLaterale;
	int vdeYSliderLargeur			= vdeEspacementZoneBas;
	int vdeLargeurSliderLargeur		= vdeLargeurVue-2*vdeMargeLaterale-vdeLargeurLabelRatioLargeur;
	int vdeHauteurSliderLargeur		= vdeHauteurFixeElementsBas;
	
	[vdeSliderLargeur setFrame:CGRectMake(vdeXSliderLargeur,
										  vdeYSliderLargeur,
										  vdeLargeurSliderLargeur,
										  vdeHauteurSliderLargeur)];
	
	//-------------------------------------------------------------------------
	int vdeLargeurLabelRatioHauteur		= 50;
	int vdeXLabelRatioHauteur			= vdeLargeurVue - vdeLargeurLabelRatioHauteur - vdeMargeLaterale;
	int vdeYLabelRatioHauteur			= 2*vdeEspacementZoneBas+vdeHauteurSliderLargeur;
	int vdeHauteurLabelRatioHauteur		= vdeHauteurFixeElementsBas;
	
	[vdeLabelRatioHauteur setFrame:CGRectMake(vdeXLabelRatioHauteur	,
											  vdeYLabelRatioHauteur	,
											  vdeLargeurLabelRatioHauteur,
											  vdeHauteurLabelRatioHauteur)];
	
	//-------------------------------------------------------------------------
	int vdeXSliderHauteur			= vdeMargeLaterale;
	int vdeYSliderHauteur			= 2*vdeEspacementZoneBas+vdeHauteurSliderLargeur;
	int vdeLargeurSliderHauteur		= vdeLargeurVue-2*vdeMargeLaterale-vdeLargeurLabelRatioHauteur;
	int vdeHauteurSliderHauteur		= vdeHauteurFixeElementsBas;
	
	[vdeSliderHauteur setFrame:CGRectMake(vdeXSliderHauteur,
										  vdeYSliderHauteur,
										  vdeLargeurSliderHauteur,
										  vdeHauteurSliderHauteur)];

	
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

-(void) vdeActionStepperChoixPhotos : (UIStepper *) sender {
//--------------------------------------------------------------------------------------------------------
	
	self.vdePhotoPourAfficher = [self.vdeViewControllerImagier vdeDemandePhotosAAfficher:(int) sender.value];
	//NSLog(@"stepper : %@", self.vdePhotoPourAfficher.vdeNomPhotoSource);
	
	[self vdeAffichePhoto: self.vdePhotoPourAfficher];
}


-(void) vdeActionSliderLargeur:(UISlider*) sender {
//--------------------------------------------------------------------------------------------------------
	int vdeSliderLargeurValeur = sender.value;
	vdeLabelRatioLargeur.text = [NSString stringWithFormat:@"%d %%", vdeSliderLargeurValeur];
	[self vdeRedimensionnePhoto];
}

-(void) vdeActionSliderHauteur:(UISlider*) sender {
//--------------------------------------------------------------------------------------------------------
	int vdeSliderHauteurValeur = sender.value;
	vdeLabelRatioHauteur.text = [NSString stringWithFormat:@"%d %%", vdeSliderHauteurValeur];
	[self vdeRedimensionnePhoto];
}

-(void) vdeActionSegmentZoom: (UISegmentedControl*) sender {
//--------------------------------------------------------------------------------------------------------
	int vdeValeurSegmentZoom;
	switch (sender.selectedSegmentIndex) {
		case 0:
			vdeValeurSegmentZoom=10;
			break;
		case 1:
			vdeValeurSegmentZoom=25;
			break;
		case 2:
			vdeValeurSegmentZoom=50;
			break;
		case 3:
			vdeValeurSegmentZoom=100;
			break;
		case 4:
			vdeValeurSegmentZoom=200;
			break;
		default:
			break;
	}
		
	vdeSliderLargeur.value		= vdeValeurSegmentZoom;
	vdeSliderHauteur.value		= vdeValeurSegmentZoom;
	vdeLabelRatioLargeur.text	= [NSString stringWithFormat:@"%d %%", vdeValeurSegmentZoom];
	vdeLabelRatioHauteur.text	= [NSString stringWithFormat:@"%d %%", vdeValeurSegmentZoom];

	vdeSegmentedControlZoom.selectedSegmentIndex = -1; // ruse de sioux pour déselectionner les segments

	// on donne la nouvelle valeur du zoom à la propriété zoomScale qui est utilsé par la methode viewForZoomingInScrollView:
	vdeScrollViewZoneZoomPhoto.zoomScale = vdeValeurSegmentZoom/100;
	
	[self vdeRedimensionnePhoto];
	
}

//--------------------------------------------------------------------------------------------------------
// LES ACTIONS DANS LE SCROLL VIEW
//--------------------------------------------------------------------------------------------------------

-(void) vdeAffichePhoto: (VDEPhotoPourAfficher *) photo {
//--------------------------------------------------------------------------------------------------------
	
	
	
	vdePhotoAAfficher						= [UIImage imageNamed:photo.vdeNomPhotoSource];
	//NSLog(@"nom photo : %@", photo.vdeNomPhotoSource);
	vdeVueImageAInclureDansScrollView.image	= vdePhotoAAfficher;
	vdeSliderLargeur.value					= (int)((photo.vdeValeursZoom.width)*100);
	vdeSliderHauteur.value					= (int)((photo.vdeValeursZoom.height)*100);
	NSLog(@"valeur zoom recue : %f", vdeSliderLargeur.value);
	vdeScrollViewZoneZoomPhoto.zoomScale	= photo.vdeValeursZoom.width/100; // pour synchro avec méthode zoom pinch // ( width = height )
	vdeLabelRatioLargeur.text				= [NSString stringWithFormat:@"%d %%", (int)vdeSliderLargeur.value	];
	vdeLabelRatioHauteur.text				= [NSString stringWithFormat:@"%d %%", (int)vdeSliderHauteur.value];
	
	
	
	[self vdeRedimensionnePhoto];
	
}

-(void) vdeRedimensionnePhoto {
//--------------------------------------------------------------------------------------------------------
	
	float vdeValeurZoomLargeur = vdeSliderLargeur.value/100.0;
	float vdeValeurZoomHauteur = vdeSliderHauteur.value/100.0;
	
	int vdeTailleImageLargeur		= vdePhotoAAfficher.size.width*vdeValeurZoomLargeur;
	int vdeTailleImageHauteur		= vdePhotoAAfficher.size.height*vdeValeurZoomHauteur ;

	[vdeVueImageAInclureDansScrollView	setFrame:CGRectMake(0,0,vdeTailleImageLargeur,vdeTailleImageHauteur)];
	
	
	// On donne la taille de la vue à l'intérieur de la subview pour permettre le glisser jusqu'au limite de l'image
	//-----------------------------------------------------------------------------------------------------------
	CGSize vdeTailleMaxPourGlisser;
	vdeTailleMaxPourGlisser.width	= vdeTailleImageLargeur;
	vdeTailleMaxPourGlisser.height	= vdeTailleImageHauteur;
	vdeScrollViewZoneZoomPhoto.contentSize	= vdeTailleMaxPourGlisser;
	[vdeScrollViewZoneZoomPhoto setNeedsDisplay];
	
	// on met à jour le tableau des photos avec les nouvelle valeur de zoom
	//self.vdePhotoPourAfficher.vdeValeursZoom.width = vdeTailleImageLargeur;
	
	
	 [self.vdeViewControllerImagier vdeMiseAJourZoomLargeur:vdeValeurZoomLargeur
											   zoomHauteur:vdeValeurZoomHauteur
										 pourLaPhotoAIndex:(int) self.vdeStepperChoixPhotos.value];

	 }

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//--------------------------------------------------------------------------------------------------------

	return vdeVueImageAInclureDansScrollView;
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
//--------------------------------------------------------------------------------------------------------
// pour afficher la nouvelle valeur de zoom  suite au pinch mais...quand l'image zoomée est déjà déformée, c'est un peu faux....
	
	float vdeZoomScale				= scrollView.zoomScale;

	vdeSliderLargeur.value			= vdeZoomScale*100;
	vdeSliderHauteur.value			= vdeZoomScale*100;
	vdeLabelRatioLargeur.text		= [NSString stringWithFormat:@"%d %%",(int) (vdeZoomScale*100)];
	vdeLabelRatioHauteur.text		= [NSString stringWithFormat:@"%d %%",(int) (vdeZoomScale*100)];
	
	[self.vdeViewControllerImagier vdeMiseAJourZoomLargeur:vdeZoomScale
											   zoomHauteur:vdeZoomScale
										 pourLaPhotoAIndex:(int) self.vdeStepperChoixPhotos.value];
	
}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
//--------------------------------------------------------------------------------------------------------
// finalement, non, je l'utilse pas...
}

@end


