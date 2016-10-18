//
//  LXAlertManager.h
//  juanpi3
//
//  Created by Liu on 15/12/7.
//  Copyright © 2015年 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AlertDismissBlock)(NSInteger index, NSInteger cancelIndex);

@interface LXAlertManager : NSObject<UIAlertViewDelegate, UIActionSheetDelegate>

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)otherTitles dismissBlock:(AlertDismissBlock)dismiss presentVC:(UIViewController *)presentVC;
+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)otherTitles inView:(UIView *)view dismissBlock:(AlertDismissBlock)dismiss presentVC:(UIViewController *)presentVC;


@end

@interface UIAlertView (LXDismissBlock)

@property (nonatomic, copy) AlertDismissBlock dismissBlock;

@end

@interface UIActionSheet (LXDismissBlock)

@property (nonatomic, copy) AlertDismissBlock dismissBlock;

@end

@interface UIAlertController (LXDismissBlock)

@property (nonatomic, copy) AlertDismissBlock dismissBlock;

@end

@interface UIAlertAction (LXActionIndex)

@property (nonatomic, strong) NSNumber *cancelIndex;
@property (nonatomic, strong) NSNumber *buttonIndex;

@end
