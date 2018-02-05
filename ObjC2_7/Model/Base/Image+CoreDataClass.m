//
//  Image+CoreDataClass.m
//  ObjC2_7
//
//  Created by Алексей on 25.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//
//

#import "Image+CoreDataClass.h"

@implementation Image

-(id) initAllImage: (NSData*) image info: (NSString*) info name: (NSString*) name url: (NSString*) url{
    NSManagedObjectContext* context = [[[DBBase alloc] init] getContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"Image" inManagedObjectContext: context];
    self = [[Image alloc] initWithEntity:entity insertIntoManagedObjectContext: context];
    
    if (self){
        self.image = image;
        self.name = name;
        self.info = info;
        self.url = url;
    }
    return self;
}

@end
