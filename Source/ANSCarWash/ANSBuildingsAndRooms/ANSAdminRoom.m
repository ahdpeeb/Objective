//
//  ANSAdminRoom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAdminRoom.h"
#import "NSObject+ANSExtension.h"

@interface ANSAdminRoom ()
@property (nonatomic, retain, readwrite) ANSAccountant  *accountant;
@property (nonatomic, retain, readwrite) ANSBoss        *boss;

@end

@implementation ANSAdminRoom

#pragma mark -
#pragma mark PublicMethods

+ (ANSAdminRoom *)create {
    ANSAdminRoom *room = [ANSAdminRoom object];
    [room addAccountant];
    [room addBoss];
    
    return room;
}

- (ANSAccountant *)addAccountant {
    ANSAccountant *accountant = self.accountant;
    if (!self.accountant) {
        ANSAccountant *bookkeeper = [ANSAccountant object];
        accountant = bookkeeper;
    }
    
    return accountant;
    
}

- (void)removeAccountant {
    self.accountant = nil;
}

- (ANSBoss *)addBoss {
    ANSBoss *boss = self.direcrot;
    if (!boss) {
        ANSBoss *director = [ANSBoss object];
        boss = director;
       
    }
    
    return boss;
}

- (void)removeDirector {
    self.boss = nil;
}

@end
