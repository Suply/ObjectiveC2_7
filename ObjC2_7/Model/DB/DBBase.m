//
//  DBBase.m
//  ObjC2_7
//
//  Created by Алексей on 25.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

#import "DBBase.h"

@implementation DBBase

-(NSManagedObjectContext*) getContext{
    AppDelegate* appDelegate = (AppDelegate*) UIApplication.sharedApplication.delegate;
    NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
    return context;
}

@end
