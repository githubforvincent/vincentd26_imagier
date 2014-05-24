//
//  VDEPhotoPourAfficher.h
//  vincentd26_imagier
//
//  Created by Utilisation on 24/05/14.
//  Copyright (c) 2014 com.striato. All rights reserved.
//

#import "VDEPhotoSource.h"

@interface VDEPhotoPourAfficher : VDEPhotoSource

@property (nonatomic) CGSize vdeValeursZoom;

// CGSize parce qu'il y a déjà deux valeurs width et height et qua ça ma va bien pour le zoom aussi

@end
