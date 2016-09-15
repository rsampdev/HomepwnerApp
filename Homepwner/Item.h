//
//  Item.h
//  Homepwner
//
//  Created by Rodney Sampson on 9/13/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (copy, nonatomic) NSString *itemKey;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic) NSDate *dateCreated;

- (instancetype)initWithName:(NSString *)name serialNumber:(NSString *)serialNumber valueInDollars:(int)valueInDollars NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithRandomValues;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end
