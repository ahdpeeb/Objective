//
//  ANSWashBuilding.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWashBuilding.h"

#import "NSObject+ANSExtension.h"

@interface ANSWashBuilding ()
@property (nonatomic, retain, readwrite) NSMutableArray *mutableBoxes;

@end

@implementation ANSWashBuilding
@dynamic boxes;

#pragma mark -
#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mutableBoxes = [NSMutableArray object];
        [self addBox:[ANSWashBox create]];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)boxes {
    return [[self.mutableBoxes copy] autorelease];
}

#pragma mark -
#pragma mark Public methods

- (void)addBox:(ANSWashBox *)box {
    [self.mutableBoxes addObject:box];
}

- (void)removeBox:(ANSWashBox *)box {
    [self.mutableBoxes removeObject:box];
}

@end
