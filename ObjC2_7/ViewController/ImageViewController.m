//
//  ImageViewController.m
//  ObjC2_7
//
//  Created by Алексей on 24.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

#import "ImageViewController.h"



@implementation ImageViewController

- (IBAction)addItem:(UIBarButtonItem *)sender {
    NSLog(@"Call delegate method");
    [_delegate addItemViewController: self];
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
