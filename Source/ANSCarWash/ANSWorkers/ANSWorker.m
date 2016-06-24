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
@property (atomic, assign) float money;

@end

@implementation ANSWorker

#pragma mark -
#pragma mark initialize / deallocate

- (void)dealloc {
    
    [super dealloc];
}

- (instancetype)initWithId:(NSUInteger)idNumber {
    self = [super init];
    self.idNumber = idNumber;
    self.state = ANSWorkerFree;
    
    return self;
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
    self.state = ANSWorkerBusy;
    [self performWorkWithObject:object];
    if ([object respondsToSelector:@selector(setState:)]) { // car does not respond to this selector
        [object setState:ANSWorkerFree];
    }
    
    self.state = ANSWorkIsPending;
}

- (void)performWorkWithObject:(id)object {
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark -
#pragma mark Overloaded methods

- (SEL)selectorForState:(ANSState)state {
    switch (state) {
        case ANSWorkerBusy:
            return @selector(workerBecameBusy:);
            
        case ANSWorkIsPending:
            return @selector(workerBecameIsPending:);
            
        case ANSWorkerFree:
            return @selector(workerBecameFree:);
            
        default:
            return NULL;
    }
}

#pragma mark -
#pragma mark private

- (NSString *)description {
    return [NSString stringWithFormat:@"worker id - %ld", (long)self.idNumber ];
}

@end
