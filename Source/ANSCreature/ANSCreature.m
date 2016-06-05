//
//  ANSCreature.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCreature.h"

static NSString * const kANSHi = @"Hi";

@interface ANSCreature ()
@property (nonatomic, retain) NSMutableArray *mutableChildren;

@end

@implementation ANSCreature

@dynamic children; //I'am responsible for property implementation, do not create new field

#pragma mark -
#pragma mark Init / deallocate

- (void)dealloc {
    self.name = nil;
    self.mutableChildren = nil;
    
    [super dealloc];
}

- (instancetype)initWithName:(NSString*) name {
    self = [super init];
    if (self) {
        self.mutableChildren = [NSMutableArray object];
        self.name = name;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)children {
    return [[self.mutableChildren copy] autorelease];
}

#pragma mark -
#pragma mark Public implementation

- (void)addChild:(ANSCreature *)creature {
    NSMutableArray *children = self.mutableChildren;
    
    if(![children containsObject:creature]) {
        [children addObject:creature];
    }
}

- (void)removeChild:(ANSCreature *)creature {
    NSMutableArray *children = self.mutableChildren;
    
    if ([children containsObject:creature]) {
        [children removeObject:creature];
    }
}

- (void)saySomething {
    NSLog(@"%@", kANSHi);
}

- (void)familySayHi {
    [self saySomething];
    for (ANSCreature *creatureChildren in self.mutableChildren) {
        [creatureChildren saySomething];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Name - %@, age - %lu, Children - %@",
            self.name,
            (unsigned long)self.age,
            self.children];
}

- (void)performGenderSpecificOperation {
    NSLog(@"super");
}

@end
