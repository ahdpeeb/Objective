//
//  ANSAdminBuiding.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSRoom.h"

@interface ANSAdminBuilding : NSObject
@property (nonatomic, readonly) NSArray *adminRooms;

- (void)addRoom:(ANSAdminRoom *)room;
- (void)removeRoom:(ANSAdminRoom *)room;

@end
