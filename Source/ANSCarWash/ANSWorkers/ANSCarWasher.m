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
    [self takeMoneyFromObject:car];
    car.status = ANSCarClean;
    self.state = ANSWorkIsPending;             // work finishd => change state ANSWorkIsPending
    [self.delegate workerDidFinishWork:self];  // after carWasher did work, he inform delegat
}

- (void)processObject:(id)object {
    [self washCar:object];
    
}

@end
