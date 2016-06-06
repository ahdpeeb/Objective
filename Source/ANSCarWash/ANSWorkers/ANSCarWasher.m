//
//  ANSCarWasher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWasher.h"
#import "ANSRandom.h"

@interface ANSCarWasher ()

@end

@implementation ANSCarWasher

- (instancetype)initWorker
{
    self = [super init];
    if (self) {
        self.proffesion = ANSProffesionCarWasher;
        self.yearsOfExperience = randomIntegerBetweenMinValue(0, 3);
        self.currentBalance = 0;
        
    }
    return self;
}
    //take money from car, clean car. 
- (void)washCar:(ANSCar *) car withCost:(float) cost {
    if (car.balans >= cost) {
        self.currentBalance = self.currentBalance + cost;
        car.status = ANSCarStatusClead; // may be need to move to another method.
        car.balans = car.balans - cost; // may be need to move to another method.
    }
}
    //give money to accountant
- (void)giveMoneyToАccountant:(ANSAccountant *) accountant {
    if (self.currentBalance > 0) {
        accountant.currentBalance = accountant.currentBalance + self.currentBalance;
        self.currentBalance = 0;
    }
}
    
@end
