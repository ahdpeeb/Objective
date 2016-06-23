//
//  ANSPurse.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSObservableObjectTest.h"

@class ANSPurse;

typedef NS_ENUM (uint8_t, ANSPurseState) {
    ANSPurseEmpty,
    ANSPurseNonEmpty
};

@protocol ANSPurseObserver <NSObject>

@optional
- (void)purseDidBecomeEmpty:(ANSPurse *)purse;
- (void)purseDidBecomeNonEmpty:(ANSPurse *)purse;

@end

@interface ANSPurse : ANSObservableObjectTest

@property (nonatomic, assign) ANSPurseState     purseState;
@property (nonatomic, assign) NSUInteger        money;


@end
