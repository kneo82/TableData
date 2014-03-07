//
//  NSBundle+TDExtensions.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/6/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (TDExtensions)

// Following methods load class from nib with the same name as class
- (id)loadClass:(Class)theClass;

- (id)loadClass:(Class)theClass
          owner:(id)owner;

- (id)loadClass:(Class)theClass
          owner:(id)owner
        options:(NSDictionary *)options;

- (id)loadClass:(Class)theClass
          owner:(id)owner
        options:(NSDictionary *)options
        nibName:(NSString *)nibName;

@end
