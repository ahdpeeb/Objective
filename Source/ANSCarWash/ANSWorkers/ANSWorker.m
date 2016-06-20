//
//  ANSWorker.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWorker.h"

#import "ANSCar.h"
#import "ANSRandom.h"

@interface ANSWorker ()
@property (nonatomic, assign) float money;

@end

@implementation ANSWorker

#pragma mark -
#pragma mark initialize / deallocate

- (void)dealloc {
    self.delegatingWorker = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.yearsOfExperience = 3;
    
    return self;
}

#pragma mark 
#pragma marrk Accessors 

- (void)setDelegatingObject:(id)delegatingWorker {
    if (_delegatingWorker != delegatingWorker) {
        [_delegatingWorker release];
        [delegatingWorker setDelegat:nil];
        _delegatingWorker = [delegatingWorker retain];
        
        [_delegatingWorker setDelegat:self];
    }
}

#pragma mark -
#pragma mark Public methods

- (void)receiveMoney:(float)number {
    self.money += number;
}

- (void)giveMoney:(float)number {
    self.money -= number;
}

- (void)takeMoneyFromObject:(id<ANSMoneyOwner>)owner {
    float money = owner.money;
    [owner giveMoney:money];
    [self receiveMoney:money];
}

- (void)processObject:(id)object {
    NSLog(@"process object");
}

#pragma mark -
#pragma mark ANSWorkerDelegate

- (void)workerGotMoney:(id)worker {
    [self processObject:worker];
}

@end
