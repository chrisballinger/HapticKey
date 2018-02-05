//
//  HTKEvent.m
//  HapticKey
//
//  Created by Yoshimasa Niwa on 12/14/17.
//  Copyright © 2017 Yoshimasa Niwa. All rights reserved.
//

#import "HTKEvent.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HTKEvent

- (instancetype)init
{
    return [self initWithPhase:HTKEventPhaseBegin];
}

- (instancetype)initWithPhase:(HTKEventPhase)phase
{
    if (self = [super init]) {
        _phase = phase;
    }
    return self;
}

// MARK: NSCoding

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:@(self.phase) forKey:NSStringFromSelector(@selector(phase))];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    NSNumber *number = [aDecoder decodeObjectOfClass:NSNumber.class forKey:NSStringFromSelector(@selector(phase))];
    if (!number) { return nil; }
    return [self initWithPhase:number.unsignedIntegerValue];
}

// MARK: NSSecureCoding

+ (BOOL) supportsSecureCoding {
    return YES;
}

@end

NS_ASSUME_NONNULL_END
