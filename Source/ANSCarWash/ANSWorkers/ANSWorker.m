//
//  ANSWorker.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWorker.h"
#import "ANSCar.h"

@interface ANSWorker ()
@property(nonatomic, assign) float money;

- (void)setMoney:(float)money;

@end

@implementation ANSWorker

- (void)acceptMoney:(float)number {
    self.money = self.money + number;
}

- (void)giveMoney:(float)number {
    self.money = self.money - number;
}

- (void)countMoney {
    NSLog(@"i have %f money", self.money);
}

#pragma mark -
#pragma mark Private

- (void)setMoney:(float)money {
    self.money = money;
}

@end
