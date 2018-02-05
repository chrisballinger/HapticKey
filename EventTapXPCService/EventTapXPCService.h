//
//  EventTapXPCService.h
//  EventTapXPCService
//
//  Created by Chris Ballinger on 2/4/18.
//  Copyright © 2018 Yoshimasa Niwa. All rights reserved.
//

#import <Foundation/Foundation.h>
@import EventTap;

NS_ASSUME_NONNULL_BEGIN
@interface EventTapXPCService : NSObject <EventTapXPCServiceProtocol>

@property (nonatomic, strong, nullable) id<EventTapXPCListener> listener;

@end
NS_ASSUME_NONNULL_END
