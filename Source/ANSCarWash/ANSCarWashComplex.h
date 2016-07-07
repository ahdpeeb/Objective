//
//  ANSCarWash.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSCar.h"

@interface ANSCarWashComplex : NSObject
@property (atomic, readonly)      NSMutableArray          *mutableWashers;
@property (nonatomic, readonly)   NSMutableArray          *mutableAccountants;
@property (nonatomic, readonly)   NSMutableArray          *mutablebosses;

- (void)addCarToQueue:(ANSCar *)car;

- (NSMutableArray *)objectsWithClass:(Class)cls
                               count:(NSUInteger)count
                           observers:(NSArray *)observers;

@end
