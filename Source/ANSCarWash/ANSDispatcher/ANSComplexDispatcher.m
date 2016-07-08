//
//  ANSComplexDispatcher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSComplexDispatcher.h"

#import "ANSCarWashComplex.h"
#import "ANSCar.h"
#import "ANSConstants.h"

#import "NSArray+ANSExtension.h"

@implementation ANSComplexDispatcher

- (NSArray *)cars {
    __block NSUInteger value = 0;
    ANSObjectBlock object = ^id(void) {
        ANSCar *car  = [[ANSCar alloc] initWithID:value];
        value ++;
        return car;
    };
    
    
    return [NSArray objectsWithCount:kANSMaxCarCount block:object];
}

@end
