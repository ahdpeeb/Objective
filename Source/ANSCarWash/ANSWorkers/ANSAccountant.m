//
//  ANSAccountant.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAccountant.h"

#import "ANSCarWasher.h"

#import "ANSQueue.h"
#import "NSObject+ANSExtension.h"

static const NSUInteger kASNSleepSeconds = 1;

@interface ANSAccountant ()

@end

@implementation ANSAccountant

#pragma mark -
#pragma mark Initializetion / deallocation

- (void)dealloc {
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)countMoney {
    @synchronized(self) {
        sleep(kASNSleepSeconds);
        NSLog(@"%@ count money - %f ",self, self.money);
    }
}

- (void)performWorkWithObject:(id)object {
    NSLog(@"%@ забирает деньги(%f) у %@", self, [object money], object);
    [self takeMoneyFromObject:object];
    [self countMoney];
}
 
- (void)workerDidBecomeIsPending:(id)worker {
    [self startProcessingObject:worker];
}

@end
