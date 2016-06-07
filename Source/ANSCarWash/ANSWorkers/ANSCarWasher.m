//
//  ANSCarWasher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWasher.h"
#import "ANSRandom.h"

@implementation ANSCarWasher

- (instancetype)initWorker
{
    self = [super init];
    if (self) {
        self.proffesion = ANSWasher;
        self.yearsOfExperience = ANSRandomIntWithRange(0, 3);
    }
    
    return self;
}

- (void)washCar:(ANSCar *)car withCost:(float)cost {
    if (car.money >= cost) {
        [car giveMoney:cost];
        [self acceptMoney:cost];
        car.status = ANSCarClean;
    }
}

- (void)giveMoneyToАccountant:(ANSAccountant *)accountant {
    float allMoney = self.money;
    [self giveMoney:allMoney];
    [accountant acceptMoney:allMoney];
}

@end
