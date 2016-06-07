//
//  ANSCar.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCar.h"

@interface ANSCar ()
@property(nonatomic, assign) float money;

@end

@implementation ANSCar

#pragma mark -
#pragma mark Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.status = ANSCarDirty;
        self.money = 5;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public methods

-(void)acceptMoney:(float)number {
    self.money = self.money + number;
}

-(void)giveMoney:(float)number {
    self.money = self.money - number;
}

@end
