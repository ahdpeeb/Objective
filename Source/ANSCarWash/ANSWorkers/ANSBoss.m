//
//  ANSBoss.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSBoss.h"

@implementation ANSBoss

- (void)calculateProfit {
    NSLog(@"my profit - %f", self.money);
}

- (void)performWorkWithObject:(id)object {
    [self takeMoneyFromObject:object];
    [self calculateProfit];
}

- (void)workerBecameIsPending:(id)worker {
    [self processObject:worker];
}

@end
