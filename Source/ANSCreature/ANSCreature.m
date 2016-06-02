//
//  ANSCreature.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCreature.h"
#import "NSObject+ANSObjectExtension.h"

const static NSString *string = @"Hi";

@interface ANSCreature ()
@property (nonatomic, retain) NSMutableArray *mutableChildren;

@end

@implementation ANSCreature
@dynamic children; //I'am responsible for property implementation, do not create new field

#pragma mark -
#pragma mark Init / deallocate

- (void)deallocate {
    self.name = nil;
    self.mutableChildren = nil;
    
    [super dealloc];
}

- (instancetype)initWithName:(NSString*) name {
    self = [super init];
    if (self) {
        self.mutableChildren = [NSMutableArray autoreleseObject];
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
    NSLog(@"%@", string);
}

- (void)familySayHi {
    [self saySomething];
    for (ANSCreature *creatureChildren in self.mutableChildren) {
        [creatureChildren saySomething];
    }
}

- (void)goFight {
    NSLog(@"%@ - i'am go to fing", self.name);
}

- (ANSCreature *)giveBirth {
    NSLog(@"%@ - i'am can give birth" , self.name);
    
    return [ANSCreature autoreleseObject];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Name - %@, age - %lu, Children - %@", self.name, (unsigned long)self.age, self.children];
}

- (void)performGenderSpecificOperation {
    NSLog(@"super");
}

@end
