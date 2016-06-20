//
//  ANSCarWasher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWasher.h"

@implementation ANSCarWasher

- (void)washCar:(ANSCar *)car {
    car.status = ANSCarClean;
    [self takeMoneyFromObject:car];
    [self.delegat workerGotMoney:self];  // after carWasher got money, inform accountant.
}

- (void)processObject:(id)object {
    [self washCar:object];
}

@end
