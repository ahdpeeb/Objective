//
//  ANSWorker.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ANSProffesionUnemployed,
    ANSProffesionCarWasher,
    ANSProffesionAccounter,
    ANSProffesionDirector
} ANSProffesionType;

@interface ANSWorker : NSObject
@property (nonatomic, assign) float             monthlyIncome;
@property (nonatomic, assign) ANSProffesionType proffesion;
@property (nonatomic, assign) NSInteger         yearsOfExperience;
@property (nonatomic, assign) float             currentBalance;

- (instancetype)initWorker;

@end
