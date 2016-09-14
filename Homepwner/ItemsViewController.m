//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Rodney Sampson on 9/13/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemStore.h"
#import "Item.h"

@interface ItemsViewController ()

@property (nullable, nonatomic) NSMutableArray *itemsUnderFifty;
@property (nullable, nonatomic) NSMutableArray *itemsOverFifty;

@end

@implementation ItemsViewController

// MARK: - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    UIEdgeInsets insets = UIEdgeInsetsMake(statusBarHeight, 0, 0, 0);
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
    self.itemsUnderFifty = [[NSMutableArray alloc] init];
    self.itemsOverFifty = [[NSMutableArray alloc] init];
    
    Item *item = nil;
    
    for (int i = 0; i < self.itemStore.allItems.count; i++) {
        item = self.itemStore.allItems[i];
        
        if (item.valueInDollars >= 50) {
            [self.itemsOverFifty addObject:item];
        } else if (item.valueInDollars < 50) {
            [self.itemsUnderFifty addObject:item];
        }
    }
}

// MARK: - Table View Data Source and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger rtn = 1;
    
    if (self.itemsUnderFifty != nil && self.itemsOverFifty != nil) {
        if (self.itemsUnderFifty.count >= 1 || self.itemsOverFifty.count >= 1) {
            rtn++;
            if (self.itemsOverFifty.count >= 1 && self.itemsUnderFifty.count >= 1) {
                rtn++;
            }
        }
    } else {
        rtn = 0;
    }
    
    return rtn;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *rtn = @"Empty";
    
    if (section == 0) {
        if (self.itemsUnderFifty.count == 0 && self.itemsOverFifty.count == 0) {
            rtn = @"Empty";
        } else {
            if (self.itemsOverFifty.count == 0) {
                rtn = @"Items under $50";
            } else {
                rtn = @"Items over $50";
            }
        }
    } else if (section == 1) {
        rtn = @"Items over $50";
    }
    
    return rtn;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rtn = 0;
    
    if (section == 0) {
        if (self.itemsOverFifty.count == 0) {
            rtn = self.itemsUnderFifty.count + 1;
        } else {
            if (self.itemsUnderFifty.count == 0) {
                rtn = self.itemsOverFifty.count + 1;
            } else {
                rtn = self.itemsUnderFifty.count;
            }
        }
    } else if (section == 1) {
        rtn = self.itemsOverFifty.count + 1;
    }
    
    return rtn;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    if (self.itemsUnderFifty.count == 0 && self.itemsOverFifty.count == 0) {
        cell.textLabel.text = @"No more items!";
        cell.detailTextLabel.text = @"";
    } else {
        
        Item *item = nil;
        NSInteger section = indexPath.section;
        NSInteger row = indexPath.row;
        
        if ((section == 0 || self.itemsOverFifty.count == 0) && row < self.itemsUnderFifty.count) {
            item = self.itemsUnderFifty[row];
        } else if ((section == 1 || self.itemsUnderFifty.count == 0) && row < self.itemsOverFifty.count) {
            item = self.itemsOverFifty[row];
        }
        
        cell.textLabel.text = item.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
        
        if (item == self.itemsUnderFifty.lastObject && row == self.itemsUnderFifty.count - 1 && self.itemsOverFifty.count == 0) {
            [self.itemsUnderFifty addObject:[[Item alloc] initWithName:@"No more items!" serialNumber:@"" valueInDollars:-1]];
        } else if (item == self.itemsOverFifty.lastObject && row == self.itemsOverFifty.count - 1) {
            [self.itemsOverFifty addObject:[[Item alloc] initWithName:@"No more items!" serialNumber:@"" valueInDollars:-1]];
        }
        
        if (item.valueInDollars < 0) {
            cell.detailTextLabel.text = @"";
        }
    }
    
    return cell;
}

@end
