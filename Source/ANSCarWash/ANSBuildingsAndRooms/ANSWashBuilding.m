//
//  ANSWashBuilding.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWashBuilding.h"
#import "NSObject+ANSExtension.h"

static NSString * const kANSallBoxesFul = @"No sutable box for car";

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
    [self addBox:[ANSWashBox new]];
    
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

- (void)addBox:(ANSWashBox *)box {
    [self.mutableBoxes addObject:box];
}

- (void)removeBox:(ANSWashBox *)box {
    [self.mutableBoxes removeObject:box];
}

- (ANSWashBox *)freeBox {
    for (ANSWashBox *box in self.mutableBoxes) {
        if ([box isReady]) {
            return box;
        }
    }
    
    NSLog(@"%@", kANSallBoxesFul);
    
    return nil;
}

@end
