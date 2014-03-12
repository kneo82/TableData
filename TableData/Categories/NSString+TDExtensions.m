//
//  NSString+TDExtensions.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/6/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "NSString+TDExtensions.h"

@implementation NSString (TDExtensions)

+ (NSString *)randomStringOfLength:(NSUInteger)lenght {
    char str[lenght + 1];
    
    for (NSUInteger index = 0; index < lenght; index++) {
        str[index] = (char)('!' + arc4random_uniform('~' - '!'));
    }
    
    str[lenght]='\0';
    
    NSString *randomString = [NSString stringWithCString:str encoding:NSASCIIStringEncoding];
    return randomString;
}

@end
