//
//  ANSAdminRoom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSBoss.h"
#import "ANSAccountant.h"

@interface ANSRoom : NSObject
@property (nonatomic, readonly)                         NSArray *workers ;
@property (nonatomic, readonly, getter = isOccupied)    BOOL    occupied;

- (instancetype)initWithAccountant:(ANSAccountant *)accountant boss:(ANSBoss *)boss;

- (void)addWorker:(id)worker;
- (void)removeWorker:(id)worker;
- (NSArray *)objectsWithClass:(Class)cls;

@end
