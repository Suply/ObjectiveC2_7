//
//  DBBase.h
//  ObjC2_7
//
//  Created by Алексей on 25.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DBBase : NSObject
-(NSManagedObjectContext*) getContext;
@end
