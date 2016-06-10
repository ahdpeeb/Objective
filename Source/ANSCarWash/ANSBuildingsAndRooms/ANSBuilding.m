//
//  ANSAdminBuiding.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSBuilding.h"

#import "ANSConstants.h"

#import "NSObject+ANSExtension.h"

@interface ANSBuilding ()
@property (nonatomic, retain) NSMutableArray *mutablerooms;

@end

@implementation ANSBuilding

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

- (instancetype)freeRoom {
    for (id room in self.mutablerooms) {
        if ([room respondsToSelector:@selector(isReadyToUse)]) { //makeObjectsPerformSelector
            if ([room isReadyToUse]) {
                return room;
            }
        }
    }
    
    NSLog(@"%@", kANSallBoxesFul);

    return nil;
}

- (NSArray *)workersWithClass:(Class)class {
    NSMutableArray *workers = [NSMutableArray object];
    for (id room in self.mutablerooms) {
    [workers addObjectsFromArray:[room objectsWithClass:class]];
    }
    
    return [[workers copy] autorelease];
}

@end
