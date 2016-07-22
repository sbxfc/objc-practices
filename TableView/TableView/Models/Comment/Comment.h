//
//  Comment.h
//  TableView
//
//  Created by sbxfc on 16/7/22.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic,copy,readonly) NSString* identifier;
@property (nonatomic,copy,readonly) NSString* name;
@property (nonatomic,copy,readonly) NSString* addr;
@property (nonatomic,copy,readonly) NSString* time;
@property (nonatomic,copy,readonly) NSString* content;
@property (nonatomic,copy,readonly) NSString* praise;

@end
