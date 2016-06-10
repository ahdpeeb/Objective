//
//  ANSAdminBuiding.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAdminBuilding.h"

#import "NSObject+ANSExtension.h"

@interface ANSAdminBuilding ()
@property (nonatomic, retain) NSMutableArray *mutablerooms;

@end

@implementation ANSAdminBuilding

@dynamic rooms;

#pragma mark -
#pragma mark initialize / deallocate

- (void)dealloc {
    self.mutablerooms = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutablerooms = [NSMutableArray object];
    ANSRoom *room = [[[ANSRoom alloc] initWithAccountant:[ANSAccountant object]
                                                    boss:[ANSBoss object]] autorelease];
    [self addRoom:room];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)rooms {
    return [[self.mutablerooms copy] autorelease];
}

#pragma mark -
#pragma mark Public methods

- (void)addRoom:(ANSRoom *)room {
    NSMutableArray *rooms = self.mutablerooms;
    if(![rooms containsObject:room]) {
        [rooms addObject:room];
    }
}

- (void)removeRoom:(ANSRoom *)room {
    NSMutableArray *rooms = self.mutablerooms;
    if([rooms containsObject:room]) {
        [rooms removeObject:room];
    }
}

@end
