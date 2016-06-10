//
//  ANSWashBuilding.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSBox.h"

@interface ANSWashBuilding : NSObject

@property (nonatomic, readonly) NSArray *boxes;

- (void)addBox:(ANSBox *)box;
- (void)removeBox:(ANSBox *)box;
- (ANSBox *)freeBox;

@end
