//
//  ImageDB.h
//  ObjC2_7
//
//  Created by Алексей on 25.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image+CoreDataClass.h"
#import "DBBase.h"

@interface ImageDB : NSObject

-(id)initWithDBBase;

-(Image*) save: (NSData*) image info: (NSString*) info name: (NSString*) name url: (NSString*) url;

-(void) save: (Image*) image;

-(NSMutableArray*)getAllImage;

-(void)updateImage: (Image*) image;

-(void)deleteRowFromUrl: (NSString*) url;

-(void) deleteAll;

@end
