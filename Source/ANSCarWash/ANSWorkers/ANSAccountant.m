//
//  ANSAccountant.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAccountant.h"

@implementation ANSAccountant

- (void)giveMoneyToBoss:(ANSBoss *)boss {
    float allMoney = self.money;
    [self giveMoney:allMoney];
    [boss acceptMoney:allMoney];
}

@end
