//
//  ImageCollectionViewController.m
//  ObjC2_7
//
//  Created by Алексей on 24.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import "ImageDB.h"

@interface ImageCollectionViewController()

@property (strong) NSMutableArray* imageArray;

@property (strong) ImageDB* imageDB;

@end

@implementation ImageCollectionViewController

static NSString * const reuseIdentifier = @"imageCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageDB = [[ImageDB alloc] initWithDBBase];
    [self updateArray];
    [self loadEmptyImage];
}

-(void) showAlertConfirmTitle: (NSString*) title message: (NSString*) message actionConfirm: (void (^ __nullable)(UIAlertAction * action))actionConfirm{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* actionDeleteRecords = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive
                                                                handler:actionConfirm];
    UIAlertAction* actionCancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [alert dismissViewControllerAnimated:true
                                                                                       completion:nil];
                                                         }];
    
    [alert addAction:actionDeleteRecords];
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion:nil];}

#pragma mark - actions

- (IBAction)clickDeleteRecords:(UIBarButtonItem *)sender {
    [self showAlertConfirmTitle:@"Delete"
                        message:@"Delete all records?"
                  actionConfirm:^(UIAlertAction *action) {
                      [self deleteAllRecords];
                  }
     ];
}

#pragma mark - image ipdate

-(void) loadImage: (Image*) image{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL* imgUrl = [NSURL URLWithString:image.url];
        image.image = [NSData dataWithContentsOfURL:imgUrl];
        NSLog(@"Image load async");
        [self.imageDB updateImage: image];
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.collectionView reloadData];
        });
    });
}

-(void)deleteAllRecords{
    for (Image* image in _imageArray){
        [_imageDB deleteRowFromUrl:image.url];
    }
    [self updateArray];
}

-(void)loadEmptyImage{
    NSLog(@"loadEmptyImage");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (Image* image in _imageArray) {
            NSLog(@"Check image path = %@", image.url);
            if (!image.image){
                NSLog(@"This url without image...");
                [self loadImage: image];
            }
        }
    });
}

-(void)updateArray{
    self.imageArray = [self.imageDB getAllImage];
    [self.collectionView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addImageSegue"]) {
        ImageViewController* ivc = (ImageViewController*) segue.destinationViewController;
        ivc.delegate = self;
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Image* image = (Image*)self.imageArray[indexPath.row];
    
    cell.imageImageView.image = [UIImage imageWithData: image.image];
    cell.nameLabel.text = image.name;
    NSLog(@"%@", image.name);
    return cell;
}

#pragma mark Delegate ImageViewController

- (void)addItemViewController:(ImageViewController *)controller {
    Image* image = [self.imageDB save:nil
                                 info:controller.infoTextView.text
                                 name:controller.nameTextField.text
                                  url:controller.URLTextField.text];
    if (image){
        [self.imageArray addObject: image];
        [self.collectionView reloadData];
        [self loadImage: image];
    }
}

@end
