//
//  ItemCell.h
//  Homepwner
//
//  Created by Rodney Sampson on 9/14/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (nonatomic) IBOutlet UILabel *valueLabel;

- (void)updateLabels;

@end
