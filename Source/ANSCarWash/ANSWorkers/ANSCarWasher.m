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
}

- (void)performWorkWithObject:(id)object {
    [self takeMoneyFromObject:object];
    [self washCar:object];
}

@end
