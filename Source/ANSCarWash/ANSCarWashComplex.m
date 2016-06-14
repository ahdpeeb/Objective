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

#import "NSObject+ANSExtension.h"

@interface ANSCarWashComplex ()
@property (nonatomic, retain) NSMutableArray    *mutableRooms;
@property (nonatomic, retain) ANSBuilding       *officeRoom;
@property (nonatomic, retain) ANSBuilding       *washingRoom;

    //test method
- (id)workerWithClass:(Class)cls;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark initialize / deallocate

- (void)dealloc {
    self.mutableRooms = nil;
    self.officeRoom = nil;
    self.washingRoom = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableRooms = [NSMutableArray object];
    NSMutableArray *rooms = self.mutableRooms;
    
    self.officeRoom = [ANSBuilding object];
    self.washingRoom = [ANSBuilding object];

    [rooms addObject:self.officeRoom];
    [rooms addObject:self.washingRoom];
    
    return self;
}

- (instancetype)initInfrastructure {
    self = [self init];
    ANSRoom *room = [[[ANSRoom alloc] initWithAccountant:[ANSAccountant object]
                                                    boss:[ANSBoss object]] autorelease];
    [self.officeRoom addRoom:room];
    [self.washingRoom addRoom:[ANSBox object]];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

#pragma mark -
#pragma mark Public implementation

- (void)washCar:(ANSCar *)car; {
    ANSBox *freeBox = [self.washingRoom freeRoom];
    if (freeBox) {
        ANSCarWasher *washer = [freeBox randomWasher];
        ANSBoss *boss = [self workerWithClass:[ANSBoss class]];
        ANSAccountant *accountant = [self workerWithClass:[ANSAccountant class]];
        
        [freeBox addCar:car];
        
        [washer processObject:car];
        [accountant processObject:washer];
        [boss processObject:accountant];
        
        [freeBox removeCar:car];
    }
}

#pragma mark -
#pragma mark Private test methods

- (id)workerWithClass:(Class)cls {
    return [[self.officeRoom workersWithClass:cls] firstObject];
}

@end
