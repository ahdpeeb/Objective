//
//  ANSCar.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCar.h"

@implementation ANSCar

- (instancetype)initWithBalans:(float) balans {
    self = [super init];
    if (self) {
        self.status = ANSCarStatusDirty;
        self.balans = balans;
    }
    
    return self;
}

@end
