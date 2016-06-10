//
//  ANSAdminRoom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSRoom.h"

#import "NSObject+ANSExtension.h"

@interface ANSRoom ()
@property (nonatomic, retain) NSMutableArray *mutableWorkers;

@end

@implementation ANSRoom

#pragma mark -
#pragma mark initialize / deallocate

- (void)dealloc {
    self.mutableWorkers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableWorkers = [NSMutableArray new];
    
    return self;
}

- (instancetype)initWithAccountant:(ANSAccountant *)accountant
                              boss:(ANSBoss *)boss
{
    self = [super init];
    if (self) {
        self.mutableWorkers = [NSMutableArray new];
        [self.mutableWorkers addObject:accountant];
        [self.mutableWorkers addObject:boss];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)workers {
    return [[self.mutableWorkers copy] autorelease];
}

#pragma mark -
#pragma mark Public methods

- (void)addWorker:(id)worker {
    NSMutableArray *workers = self.mutableWorkers;
    if (![workers containsObject:worker]){
        [workers addObject:worker];
    }
}

- (void)removeWorker:(id)worker {
    [self.mutableWorkers removeObject:worker];
}

- (NSArray *)objectsWithClass:(Class)class {
    NSMutableArray *mutableArray = [NSMutableArray object];
    for (id worker in self.mutableWorkers) {
        if ([worker isKindOfClass:class]) {
            [mutableArray addObject:worker];
        }
    }
    
    return [mutableArray copy];
}

- (ANSAccountant *)firsAccountant {
    NSArray *accountants = [self objectsWithClass:[ANSAccountant class]];
    
    return [accountants objectAtIndex:0];
}

- (ANSAccountant *)firsBoss {
    NSArray *bosses = [self objectsWithClass:[ANSAccountant class]];
    
    return [bosses objectAtIndex:0];
}

@end
