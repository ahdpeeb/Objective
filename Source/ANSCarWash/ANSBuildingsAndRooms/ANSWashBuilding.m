//
//  ANSWashBuilding.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWashBuilding.h"

#import "ANSConstants.h"

#import "NSObject+ANSExtension.h"

@interface ANSWashBuilding ()
@property (nonatomic, retain, readwrite) NSMutableArray *mutableBoxes;

@end

@implementation ANSWashBuilding
@dynamic boxes;

#pragma mark -
#pragma mark initialize / deallocate

- (instancetype)init {
    self = [super init];
    self.mutableBoxes = [NSMutableArray object];
    [self addBox:[ANSBox object]];
    
    return self;
}

- (void)dealloc {
    self.mutableBoxes = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)boxes {
    return [[self.mutableBoxes copy] autorelease];
}

#pragma mark -
#pragma mark Public methods

- (void)addBox:(ANSBox *)box {
    [self.mutableBoxes addObject:box];
}

- (void)removeBox:(ANSBox *)box {
    [self.mutableBoxes removeObject:box];
}

- (ANSBox *)freeBox {
    for (ANSBox *box in self.mutableBoxes) {
        if ([box isReady]) {
            return box;
        }
    }
    
    NSLog(@"%@", kANSallBoxesFul);
    
    return nil;
}

@end
