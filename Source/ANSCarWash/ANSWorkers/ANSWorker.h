//
//  ANSWorker.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANSCarWashComplexProtocol.h"

typedef enum {
    ANSUnemployed,
    ANSWasher,
    ANSAccounter,
    ANSDirector
} ANSProffesionType;

@interface ANSWorker : NSObject <ANSCarWashComplexProtocol>
@property (nonatomic, assign)           float             income;
@property (nonatomic, assign)           ANSProffesionType proffesion;
@property (nonatomic, assign)           NSInteger         yearsOfExperience;
@property (nonatomic, assign, readonly) float             money;

- (void)giveMoney:(float)number;
- (void)acceptMoney:(float)number;
- (void)countMoney;

@end
