//
//  commodityInfo.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/9.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface commodityInfo : NSObject

@property NSString *name;
@property NSString *mainImage;
@property NSNumber *price;
@property double lenght;
@property double height;
@property double width;
@property double weight;
@property int salesValume;
@property int hot;
@property enum color;
@property NSDate *entryTime;
@property int shopID;
@property int categoryLevelOne;
@property int categoryLevelTwo;

@end

NS_ASSUME_NONNULL_END
