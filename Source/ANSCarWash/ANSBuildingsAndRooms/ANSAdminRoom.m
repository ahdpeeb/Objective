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
@property (nonatomic, retain, readwrite) ANSAccountant *accountant;
@property (nonatomic, retain, readwrite) ANSDirector *direcrot;

@end

@implementation ANSAdminRoom

- (ANSAccountant *)addAccountantToRoom {
    ANSAccountant *accountant = self.accountant;
    if (!accountant) {
        ANSAccountant *bookkeeper = [ANSAccountant object];
        accountant = bookkeeper;
        [bookkeeper release];
    }
    
    return accountant;
    
}

- (void)removeAccountantFromRoom {
    self.accountant = nil;
}

- (ANSDirector *)addDirectorToRoom {
    ANSDirector *director = self.direcrot;
    if (!director) {
        ANSDirector *boss = [ANSDirector object];
        director = boss;
        [boss release];
    }
    
    return director;
}

- (void)removeDirectorFromRoom {
    self.direcrot = nil;
}

@end
