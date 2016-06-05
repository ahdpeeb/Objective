//
//  ANSRoom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSRoom.h"

@interface ANSRoom ()
@property (nonatomic, retain, readwrite) ANSAccountant *accountant;
@property (nonatomic, retain, readwrite) ANSAccountant *direcrot;
@property (nonatomic, retain, readwrite) NSMutableArray *mutableCars;
@property (nonatomic, retain, readwrite) NSMutableArray *carWashers;
@end

@implementation ANSRoom

@dynamic cars;
@dynamic carWashers;



@end
