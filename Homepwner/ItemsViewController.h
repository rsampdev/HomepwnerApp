//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Rodney Sampson on 9/13/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemStore;

@interface ItemsViewController : UITableViewController

@property (nonatomic) ItemStore *itemStore;

@end
