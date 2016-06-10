//
//  ANSAdminBuiding.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSRoom.h"
#import "ANSBox.h"

@interface ANSBuilding : NSObject
@property (nonatomic, readonly) NSArray *rooms;

- (void)addRoom:(ANSRoom *)room;
- (void)removeRoom:(ANSRoom *)room;
// returns free box for washing a car.
- (instancetype)freeRoom;
// returns array workers with class
- (NSArray *)workersWithClass:(Class)class;

@end
