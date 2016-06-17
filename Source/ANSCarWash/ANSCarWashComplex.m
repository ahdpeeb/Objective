//
//  ANSCarWash.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWashComplex.h"

#import "ANSRoom.h"
#import "ANSAccountant.h"
#import "ANSBoss.h"
#import "ANSBuilding.h"

#import "NSObject+ANSExtension.h"
#import "ANSQueue.h"

@interface ANSCarWashComplex ()
@property (nonatomic, retain) ANSQueue          *carQueue;
@property (nonatomic, retain) ANSBuilding       *officeBuilding;
@property (nonatomic, retain) ANSBuilding       *washBuilding;

- (id)workerWithClass:(Class)cls;
- (void)initInfrastructure;
- (void)washCar:(ANSCar *)car;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark initialize / deallocate

- (void)dealloc {
    self.carQueue = nil;
    self.officeBuilding = nil;
    self.washBuilding = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    self.carQueue = [ANSQueue object];
    
    self.officeBuilding = [ANSBuilding object];
    self.washBuilding = [ANSBuilding object];
    
    ANSBuilding *officeBuilding = self.officeBuilding;
    ANSBuilding *washBuilding = self.washBuilding;
    
    ANSRoom *room = [[[ANSRoom alloc] initWithAccountant:[ANSAccountant object]
                                                    boss:[ANSBoss object]] autorelease];
    [officeBuilding addRoom:room];
    [washBuilding addRoom:[ANSBox object]];
}

#pragma mark -
#pragma mark Public implementation

- (void)addCarToQueue:(ANSCar *)car {
    ANSQueue *queue = self.carQueue;
    [queue enqueue:car];
    while (!queue.count == 0) {
        [self washCar:[queue dequeue]];
    }
}

#pragma mark -
#pragma mark Private methods

- (id)workerWithClass:(Class)cls {
    return [[self.officeBuilding workersWithClass:cls] firstObject];
}

- (void)washCar:(ANSCar *)car; {
    ANSBox *freeBox = [self.washBuilding freeRoom];
    if (freeBox) {
        ANSCarWasher *washer = [freeBox randomWasher];
        ANSBoss *boss = [self workerWithClass:[ANSBoss class]];
        ANSAccountant *accountant = [self workerWithClass:[ANSAccountant class]];
        
        [freeBox addCar:car];
        
        [washer processObject:car];
        [accountant processObject:washer];
        [boss processObject:accountant];
        
        [freeBox removeCar:car];
        NSLog(@"%@ washed",car);
    }
}

@end
