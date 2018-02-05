//
//  ImageViewController.h
//  ObjC2_7
//
//  Created by Алексей on 24.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Image+CoreDataClass.h"

@class ImageViewController;
@protocol ImgViewControllerDelegate <NSObject>
- (void)addItemViewController:(ImageViewController*)controller;
@end

@interface ImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *URLTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

@property (nonatomic, weak) id <ImgViewControllerDelegate> delegate;

@end
