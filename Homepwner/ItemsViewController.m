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
#import "ItemCell.h"

@interface ItemsViewController ()

@end

@implementation ItemsViewController

// MARK: - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    UIEdgeInsets insets = UIEdgeInsetsMake(statusBarHeight, 0, 0, 0);
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 65;
}

// MARK: - Actions

- (IBAction)addNewItem:(id)sender {
    Item *newItem = [self.itemStore createItem];
    NSUInteger itemIndex = [self.itemStore.allItems indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)toggleEditingMode:(id)sender {
    if (self.editing) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

// MARK: - Table View Data Source and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemStore.allItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    if (self.itemStore.allItems.count == 0) {
        cell.textLabel.text = @"No more items!";
        cell.detailTextLabel.text = @"";
    } else {
        NSInteger row = indexPath.row;
        [cell updateLabels];
        Item *item = self.itemStore.allItems[row];
        
        cell.nameLabel.text = item.name;
        cell.serialNumberLabel.text = item.serialNumber;
        cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
        
        if (item.valueInDollars < 0) {
            cell.detailTextLabel.text = @"";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Item *item = self.itemStore.allItems[indexPath.row];
        
        NSString *title = [NSString stringWithFormat:@"Delete %@?", item.name];
        NSString *message = @"Are you sure that you want to delete this item?";
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.itemStore removeItem:item];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        [ac addAction:cancelAction];
        [ac addAction:deleteAction];
        
        [self presentViewController:ac animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.itemStore moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

@end
