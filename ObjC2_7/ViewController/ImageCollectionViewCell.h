//
//  ImageCollectionViewCell.h
//  ObjC2_7
//
//  Created by Алексей on 24.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
