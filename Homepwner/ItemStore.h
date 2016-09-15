//
//  ItemStore.h
//  Homepwner
//
//  Created by Rodney Sampson on 9/13/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item;

@interface ItemStore : NSObject

- (NSArray *)allItems;
- (Item *)createItem;
- (void)removeItem:(Item *)item;
- (void)moveItemAtIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex;
- (BOOL)saveChanges;

@end
