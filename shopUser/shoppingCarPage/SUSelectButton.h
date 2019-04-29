//
//  SUSelectButton.h
//  shopUser
//
//  Created by 李祎喆 on 2019/4/28.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SUSelectButton;

@protocol SUSelectButtonDelegate <NSObject>

-(void)SUSelectButtonChangeStatus:(SUSelectButton*)selectedButton;

@end


@interface SUSelectButton : UIButton

@property (nonatomic, weak) id<SUSelectButtonDelegate> selectDelegate;

@end

NS_ASSUME_NONNULL_END
