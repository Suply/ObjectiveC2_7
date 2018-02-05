//
//  Image+CoreDataProperties.m
//  ObjC2_7
//
//  Created by Алексей on 25.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//
//

#import "Image+CoreDataProperties.h"

@implementation Image (CoreDataProperties)

+ (NSFetchRequest<Image *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Image"];
}

@dynamic image;
@dynamic info;
@dynamic name;
@dynamic url;

@end
