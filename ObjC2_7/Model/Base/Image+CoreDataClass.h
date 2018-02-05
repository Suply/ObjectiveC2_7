//
//  Image+CoreDataClass.h
//  ObjC2_7
//
//  Created by Алексей on 25.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DBBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface Image : NSManagedObject

-(id) initAllImage: (NSData*) image info: (NSString*) info name: (NSString*) name url: (NSString*) url;

@end

NS_ASSUME_NONNULL_END

#import "Image+CoreDataProperties.h"
