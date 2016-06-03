//
//  ANSCreatureFemale.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCreatureFemale.h"

@implementation ANSCreatureFemale

- (void)performGenderSpecificOperation {
    [self giveBirth];
}

- (ANSCreature *)giveBirth {
    NSLog(@"%@ - i'am can give birth" , self.name);
    ANSCreature *child = [ANSCreature autoreleseObject];
    [self addChild:child];
    
    return child;
}

@end
