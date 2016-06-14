//
//  ANSAccountant.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAccountant.h"

@implementation ANSAccountant

- (void)countMoney {
    NSLog(@"%f money in my cashbox", self.money);
}

- (void)processObject:(id)object {
    [self takeMoneyFromObject:object];
    [self countMoney];
}

@end
