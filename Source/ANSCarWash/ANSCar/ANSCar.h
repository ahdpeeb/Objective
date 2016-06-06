//
//  ANSCar.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ANSCarStatusDirty,
    ANSCarStatusClead
} ANSCarStatus;

@interface ANSCar : NSObject
@property (nonatomic, assign) float         balans;
@property (nonatomic, assign) ANSCarStatus  status;

- (instancetype)initWithBalans:(float) balans;

@end
