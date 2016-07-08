//
//  ANSComplexDispatcher.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSDispatcher.h"

#import "ANSCarWashComplex.h"

@interface ANSComplexDispatcher : ANSDispatcher
@property (nonatomic, readonly) NSTimer *timer;
@property (nonatomic, readonly) ANSCarWashComplex *carComplex;

- (instancetype)initWithComplex:(ANSCarWashComplex *)carComplex;

- (void)conveyCars;

@end
