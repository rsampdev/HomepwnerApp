//
//  ItemCell.m
//  Homepwner
//
//  Created by Rodney Sampson on 9/14/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

- (void)updateLabels {
    UIFont *bodyFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font = bodyFont;
    self.valueLabel.font = bodyFont;
    UIFont *captionFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    self.serialNumberLabel.font = captionFont;
}

@end
