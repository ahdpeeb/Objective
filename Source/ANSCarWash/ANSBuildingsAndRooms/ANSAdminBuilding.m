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
@property (nonatomic, retain) NSMutableArray *mutableAdminRooms;

@end

@implementation ANSAdminBuilding
@dynamic adminRooms;

#pragma mark -
#pragma mark Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mutableAdminRooms = [NSMutableArray object];
        [self addRoom:[ANSAdminRoom create]];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)rooms {
    return [[self.mutableAdminRooms copy] autorelease];
}

#pragma mark -
#pragma mark Public methods

- (void)addRoom:(ANSAdminRoom *)room {
    NSMutableArray *adminRooms = self.mutableAdminRooms;
    if(![adminRooms containsObject:room]) {
        [adminRooms addObject:room];
    }
}

- (void)removeRoom:(ANSAdminRoom *)room {
    NSMutableArray *adminRooms = self.mutableAdminRooms;
    if([adminRooms containsObject:room]) {
        [adminRooms removeObject:room];
    }
}

@end
