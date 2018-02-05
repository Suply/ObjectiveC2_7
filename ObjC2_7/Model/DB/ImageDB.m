//
//  ImageDB.m
//  ObjC2_7
//
//  Created by Алексей on 25.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

#import "ImageDB.h"

@implementation ImageDB

NSString* const baseName   = @"Image";
NSString* const fieldName  = @"name";
NSString* const fieldUrl   = @"url";
NSString* const fieldImage = @"image";
NSString* const fieldInfo  = @"info";

DBBase* dbbase;

-(id)initWithDBBase{
    self = [super init];
    if (self){
        dbbase = [[DBBase alloc] init];
    }
    return self;
}

-(void)saveContext: (NSManagedObjectContext*) context{
    NSError* errorHandler = nil;
    if ([context save: &errorHandler]) {
        NSLog(@"Saved image data");
    } else {
        NSLog(@"Error saved image data %@", errorHandler);
    }
}

-(Image*)save: (NSData*) image info: (NSString*) info name: (NSString*) name url: (NSString*) url {
    NSManagedObjectContext* context = [dbbase getContext];
    NSMutableArray* imagesArray = [self getImagesWithUrl:url];
    NSLog(@"Count array = %lu", (unsigned long)imagesArray.count);
    if (imagesArray.count == 0) {
        Image* imageContext = [NSEntityDescription insertNewObjectForEntityForName: baseName
                                                            inManagedObjectContext: context];
        imageContext.image = image;
        imageContext.info  = info;
        imageContext.name  = name;
        imageContext.url   = url;
        
        [self saveContext: context];
        return imageContext;
    }
    return nil;
}

-(void) save: (Image*) image{
    [self save:image.image info:image.info name:image.name url:image.url];
}

-(NSMutableArray*)getImagesWithUrl: (NSString*) url{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:baseName];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"url == %@", url];
    [request setPredicate: predicate];
    
    NSError* errorHandler = nil;
    NSManagedObjectContext* context = [dbbase getContext];
    NSMutableArray* imageArray = [[context executeFetchRequest:request error: &errorHandler] mutableCopy];
    return imageArray;
}

-(NSMutableArray*)getAllImage{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName: baseName];
    NSManagedObjectContext* context = [dbbase getContext];
    NSError* errorHandler = nil;
    NSMutableArray* imageArray = [[context executeFetchRequest:request error: &errorHandler] mutableCopy];
    if (errorHandler == nil) {
        NSLog(@"Loaded image data: %lu", (unsigned long)imageArray.count);
    } else {
        NSLog(@"Error loaded image data %@", errorHandler);
    }
    return imageArray;
}

-(void)updateImage: (Image*) image{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName: baseName];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"url == %@", image.url];
    [request setPredicate: predicate];
    
    NSError* errorHandler = nil;
    NSManagedObjectContext* context = [dbbase getContext];
    NSMutableArray* imageArray = [[context executeFetchRequest:request error: &errorHandler] mutableCopy];
    if (errorHandler == nil) {
        NSLog(@"Loaded image data: %lu", (unsigned long)imageArray.count);
    } else {
        NSLog(@"Error loaded image data %@", errorHandler);
    }
    
    if (imageArray.count > 0) {
        NSManagedObject* grabbed = [imageArray objectAtIndex: 0];
        [grabbed setValuesForKeysWithDictionary: @{fieldImage: image.image,
                                                   fieldName : image.name,
                                                   fieldUrl  : image.url,
                                                   fieldInfo : image.info
                                                   }];
        [self saveContext:context];
        NSLog(@"Update success");
    } else {
        NSLog(@"Record not found");
    }
}

-(void)deleteRowFromUrl: (NSString*) url{
    NSMutableArray* imageArray = [self getImagesWithUrl:url];
    NSManagedObjectContext* context = [dbbase getContext];
    if (imageArray.count > 0) {
        for(NSManagedObject *managedObject in imageArray){
            [context deleteObject: managedObject];
        }
        
        [self saveContext: context];
    }
}

-(void) deleteAll{
    NSLog(@"Delete all");
    NSManagedObjectContext* context = [dbbase getContext];
    [context deletedObjects];
    [self saveContext: context];
}

@end
