//
//  ANSAccountant.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAccountant.h"

#import "ANSCarWasher.h"
#import "ANSConstants.h"

#import "ANSQueue.h"
#import "NSObject+ANSExtension.h"

@interface ANSAccountant ()

@end

@implementation ANSAccountant

#pragma mark -
#pragma mark Public methods

- (void)countMoney {
    usleep(kASNSleepSeconds);
    NSLog(@"%@ count money - %f ",self, self.money);
}

- (void)performWorkWithObject:(id)object {
    NSLog(@"%@ забирает деньги(%f) у %@", self, [object money], object);
    [self takeMoneyFromObject:object];
    [self countMoney];
}
 
@end
