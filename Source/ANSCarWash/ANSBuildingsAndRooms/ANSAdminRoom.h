//
//  ANSAdminRoom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSBoss.h"
#import "ANSAccountant.h"
#import "ANSFindingObject.h"

@interface ANSAdminRoom : NSObject <ANSFindingObject>
@property (nonatomic, readonly) NSArray *workers ;

- (instancetype)initWithAccountant:(ANSAccountant *)accountant boss:(ANSBoss *)boss;

- (void)addWorker:(id)worker;
- (void)removeWorker:(id)worker;
- (ANSAccountant *)firsAccountant;
- (ANSAccountant *)firsBoss;

@end
