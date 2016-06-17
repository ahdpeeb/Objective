//
//  ANSQueue.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 17.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSQueue.h"

#import "NSObject+ANSExtension.h"

@interface ANSQueue ()
@property (nonatomic, retain) NSMutableArray *objects;

@end

@implementation ANSQueue

@dynamic count;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.objects = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.objects.count;
}

#pragma mark -
#pragma mark Public Methods 

- (void)enqueue:(id)object {
    NSMutableArray *objects = self.objects;
    if (![objects containsObject:object]) {
        [objects addObject:object];
     }
}
- (id)dequeue {
    NSMutableArray *objects = self.objects;
    id object = [objects firstObject];
    [objects removeObject:object];
    
    return object;
}

@end
