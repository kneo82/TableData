//
//  TDObervableModel.m
//  TableData
//
//  Created by Oleksa Korin on 10/3/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDObervableModel.h"

@interface TDObervableModel ()
@property (nonatomic, assign)    TDModelState        state;

@end

@implementation TDObervableModel

#pragma mark -
#pragma mark Public

- (void)load {
    if (kTDModelLoading == self.state) {
        return;
    }
    
    if (kTDModelLoaded == self.state) {
        [self notifyObserversOfDidLoad];
        return;
    }
    
    [self prepareForLoad];
    
    self.state = kTDModelLoading;
    [self notifyObserversOfWillLoad];
    
    [self performLoading];
}

- (void)dump {
    if (kTDModelUnloaded == self.state
        || kTDModelNotLoaded == self.state)
    {
        return;
    }
    
    self.state = kTDModelUnloaded;
    
    [self notifyObserversOfDidUnload];
}

- (void)notifyObserversOfWillLoad {
    [self notifyObserversWithSelector:@selector(modelWillLoad:)];
}

- (void)notifyObserversOfDidLoad {
    [self notifyObserversWithSelector:@selector(modelDidLoad:)];
}

- (void)notifyObserversOfDidUnload {
    [self notifyObserversWithSelector:@selector(modelDidUnload:)];
}

#pragma mark -
#pragma mark Private

- (void)prepareForLoad {
    
}

- (void)performLoading {
    
}

- (void)finishLoading {
    self.state = kTDModelLoaded;
    
    [self notifyObserversOfDidLoad];
}

@end
