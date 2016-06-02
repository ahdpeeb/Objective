//
//  ANSCreature.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSCreature : NSObject
typedef enum {
    ANSCreatureGenderNotDefine,
    ANSCreatureGenderMale,
    ANSCreatureGenderFemale,
} ANSCreatureGenderType;

@property (nonatomic, copy)     NSString                *name;
@property (nonatomic, assign)   NSUInteger              age;
@property (nonatomic, assign)   float                   weight;
@property (nonatomic, assign)   ANSCreatureGenderType   gender;
@property (nonatomic, readonly) NSArray                 *children;

- (void)deallocate;

- (instancetype)initWithName:(NSString*) name;

- (void)addChild:(ANSCreature *)creature;

- (void)removeChild:(ANSCreature *)creature;

- (void)saySomething;

- (void)familySayHi;

- (void)goFight;

- (ANSCreature *)giveBirth;

- (void) performGenderSpecificOperation;

@end
