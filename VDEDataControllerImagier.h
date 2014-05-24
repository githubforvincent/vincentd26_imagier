//
//  VDEDataControllerImagier.h
//  vincentd26_imagier
//
//  Created by Utilisation on 24/05/14.
//  Copyright (c) 2014 com.striato. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VDEPhotoSource;

@interface VDEDataControllerImagier : NSObject

@property ( nonatomic,strong)	NSMutableArray * vdeTableauDesPhotosOriginales;

-(id) initWithTableauDesPhotos;

@end
