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
    
    [super dealloc];
}

- (instancetype)initWithId:(NSUInteger)idNumber {
    self = [super init];
    self.idNumber = idNumber;
    self.state = ANSWorkerFree;
    
    return self;
}

#pragma mark 
#pragma marrk Accessors 


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
    self.state = ANSWorkerBusy; 

}

- (void)processObject:(id)object {
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark -
#pragma mark ANSWorkerDelegate

- (void)workerDidFinishWork:(ANSWorker *)worker {
    [self processObject:worker];
    worker.state = ANSWorkerFree;
}

@end
