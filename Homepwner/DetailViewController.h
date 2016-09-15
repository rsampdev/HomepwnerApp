//
//  DetailViewController.h
//  Homepwner
//
//  Created by Rodney Sampson on 9/14/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;
@class ImageStore;

@interface DetailViewController : UIViewController

@property (nonatomic) Item *item;
@property (nonatomic) ImageStore *imageStore;

@end
