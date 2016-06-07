//
//  ANSCarWasher.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWorker.h"
#import "ANSCar.h"
#import "ANSAccountant.h"

@interface ANSCarWasher : ANSWorker

- (instancetype)initWorker;
- (void)washCar:(ANSCar *)car withCost:(float) cost;
- (void)giveMoneyToАccountant:(ANSAccountant *)accountant;

@end
