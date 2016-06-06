//
//  ANSAdminBuiding.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAdminBuilding.h"

@interface ANSAdminBuilding ()
@property (nonatomic, retain) NSMutableArray *mutableRooms;

@end

@implementation ANSAdminBuilding
@dynamic rooms;

#pragma mark -
#pragma mark Accessors

- (NSArray *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

#pragma mark -
#pragma mark Public methods

- (void)addRoomToAdminBuilding:(ANSAdminRoom *) room {
    [self.mutableRooms addObject:room];
}

- (void)removeRoomsFromAdminBuilding:(ANSAdminRoom *) room {
    [self.mutableRooms removeObject:room];
}

@end
