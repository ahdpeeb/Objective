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
@property (nonatomic, readonly) NSArray *rooms;

- (void)addRoom:(ANSRoom *)room;
- (void)removeRoom:(ANSRoom *)room;

@end
