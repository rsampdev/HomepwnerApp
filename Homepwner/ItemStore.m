//
//  ItemStore.m
//  Homepwner
//
//  Created by Rodney Sampson on 9/13/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"

@interface ItemStore ()

@property (nonatomic) NSMutableArray *items;
@property (nonatomic) NSURL *itemArchiveURL;

@end

@implementation ItemStore

- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [NSMutableArray array];
        
        NSArray *directories = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL *documentDirectory = directories.firstObject;
        _itemArchiveURL = [documentDirectory URLByAppendingPathComponent:@"items.archive"];
        
        NSArray *loadedItems = [NSKeyedUnarchiver unarchiveObjectWithFile:self.itemArchiveURL.path];
        [_items addObjectsFromArray:loadedItems];
    }
    return self;
}

// MARK: - Item Management

- (NSArray *)allItems {
    return [self.items copy];
}

- (Item *)createItem {
    Item *newItem = [[Item alloc] initWithRandomValues];
    [self.items addObject:newItem];
    return newItem;
}

- (void)removeItem:(Item *)item {
    [self.items removeObject:item];
}

- (void)moveItemAtIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex {
    if (oldIndex == newIndex) {
        return;
    }
    Item *item = self.items[oldIndex];
    [self.items removeObjectAtIndex:oldIndex];
    [self.items insertObject:item atIndex:newIndex];
}

// MARK: - Saving/Loading

- (BOOL)saveChanges {
    NSLog(@"Saving the store to %@", self.itemArchiveURL);
    return [NSKeyedArchiver archiveRootObject:self.items toFile:self.itemArchiveURL.path];
}

@end
