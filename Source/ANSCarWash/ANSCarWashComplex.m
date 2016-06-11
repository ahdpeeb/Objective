//
//  ANSCarWash.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWashComplex.h"

#import "ANSBuilding.h"
#import "ANSRoom.h"

#import "NSObject+ANSExtension.h"

ANSBuilding *office;
ANSBuilding *washing;

@interface ANSCarWashComplex ()
@property (nonatomic, retain) NSMutableArray    *mutableRooms;
@property (nonatomic, retain) ANSBuilding       *office;
@property (nonatomic, retain) ANSBuilding       *washing;

    //test method
- (id)workerWithClass:(Class)cls;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark initialize / deallocate

- (void)dealloc {
    self.mutableRooms = nil;
    self.office = nil;
    self.washing = nil;
    
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    self.mutableRooms = [NSMutableArray object];
    NSMutableArray *rooms = self.mutableRooms;
    
    self.office = [ANSBuilding object];
    self.washing = [ANSBuilding object];

    [rooms addObject:self.office];
    [rooms addObject:self.washing];
    
    return self;
}

- (instancetype)initInfrastructure {
    self = [self init];
    ANSRoom *room = [[[ANSRoom alloc] initWithAccountant:[ANSAccountant object]
                                                    boss:[ANSBoss object]] autorelease];
    [self.office addRoom:room];
    [self.washing addRoom:[ANSBox object]];
    
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
    ANSBox *freeBox = [self.washing freeRoom];
    if (freeBox) {
        ANSCarWasher *washer = [freeBox randomWasher];
        ANSBoss *boss = [self workerWithClass:[ANSBoss class]];
        ANSAccountant *accountant = [self workerWithClass:[ANSBoss class]];
        
        [freeBox addCar:car];
        [washer washCar:car];
        [freeBox removeCar:car];

        [accountant takeMoneyFromObject:washer];
        [boss takeMoneyFromObject:accountant];
    }
}

#pragma mark -
#pragma mark Privat test methods

- (id)workerWithClass:(Class)cls {
    return [[office workersWithClass:cls] firstObject];
}

@end
