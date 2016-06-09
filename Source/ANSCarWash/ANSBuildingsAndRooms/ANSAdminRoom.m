//
//  ANSAdminRoom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAdminRoom.h"

#import "NSObject+ANSExtension.h"

@interface ANSAdminRoom ()
@property (nonatomic, retain) NSMutableArray *mutableWorkers;

@end

@implementation ANSAdminRoom

#pragma mark -
#pragma mark initialize / deallocate

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

- (void)dealloc {
    self.mutableWorkers = nil;
    
    [super dealloc];
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

- (NSArray *)findWorkerWithClass:(Class)anyClass {
    NSMutableArray *mutableArray = [NSMutableArray object];
    for (id worker in self.mutableWorkers) {
        if ([worker isKindOfClass:[anyClass class]]) {
            [mutableArray addObject:worker];
        }
    }
    
    return [mutableArray copy];
}

- (ANSAccountant *)firsAccountant {
    NSArray *accountants = [self findWorkerWithClass:[ANSAccountant class]];
    
    return [accountants objectAtIndex:0];
}

- (ANSAccountant *)firsBoss {
    NSArray *bosses = [self findWorkerWithClass:[ANSAccountant class]];
    
    return [bosses objectAtIndex:0];
}

@end
