//
//  ANSRoom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSCarWasher.h"
#import "ANSAccountant.h"
#import "ANSDirector.h"

@interface ANSRoom : NSObject

@property (nonatomic, readonly) NSArray *cars;
@property (nonatomic, readonly) NSArray *carWashers;
@property (nonatomic, readonly) ANSAccountant *accountant;
@property (nonatomic, readonly) ANSAccountant *direcrot;

@end
