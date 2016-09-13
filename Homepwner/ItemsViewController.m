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
    if (self.itemsUnderFifty != nil && self.itemsOverFifty != nil) {
        if (self.itemsUnderFifty.count >= 1 && self.itemsOverFifty.count >= 1) {
            return 2;
        } else if (self.itemsUnderFifty.count >= 1) {
            return 1;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Items under $50";
    } else if (section == 1) {
        return @"Items over $50";
    } else {
        return @"Unknown";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.itemsUnderFifty.count;
    } else if (section == 1) {
        return self.itemsOverFifty.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    Item *item = nil;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    if (section == 0 && row < self.itemsUnderFifty.count) {
        item = self.itemsUnderFifty[row];
    } else if (section == 1 && row < self.itemsOverFifty.count) {
        item = self.itemsOverFifty[row];
    }
    
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
    
    return cell;
}

@end
