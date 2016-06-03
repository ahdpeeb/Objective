//
//  main.m
//  Objective-C
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSCreatureFemale.h"
#import "ANSCreatureMale.h"
#import "NSObject+ANSObjectExtension.h"
#import "ANSRandom.h"

static const int kANSCount = 10;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *creaturesArray = [NSMutableArray autoreleseObject];
        for (int index = 0; index < kANSCount; index ++) {
            NSString *name = [NSString stringWithFormat:@"Human %d", index];
            ANSCreature *creature = ()[ANSCreature object];
        
            [creaturesArray addObject: creature];
            
            [creature dealloc];
        }
        
        for (int index = 0; index < creaturesArray.count; index ++) {
            ANSCreature *creature = [creaturesArray objectAtIndex:index];
            
            ANSCreature *child1 = [ANSCreature autoreleseObject];
            [creature addChild:child1];
            
            [child1 dealloc];
            
            ANSCreature *child2 = [ANSCreature autoreleseObject];
            [creature addChild:child2];
            
            [child2 dealloc];
            
            if (creature.gender == ANSCreatureGenderMale) {
                [creature goFight];
            } else {
                [creature giveBirth];
            }
        }
    }
    
    return 0;
}
