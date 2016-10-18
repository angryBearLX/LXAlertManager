//
//  LXAlertManager.m
//  juanpi3
//
//  Created by Liu on 15/12/7.
//  Copyright © 2015年 Liu. All rights reserved.
//

#import "LXAlertManager.h"
#import <objc/runtime.h>

@implementation LXAlertManager

+ (instancetype)shareInstance
{
    static LXAlertManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LXAlertManager alloc] init];
    });
    return manager;
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)otherTitles dismissBlock:(AlertDismissBlock)dismiss presentVC:(UIViewController *)presentVC
{
    LXAlertManager *manager = [self shareInstance];
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:manager
                                                  cancelButtonTitle:cancelTitle
                                                  otherButtonTitles:nil, nil];
        alertView.dismissBlock = dismiss;
        for (NSString *str in otherTitles) {
            [alertView addButtonWithTitle:str];
        }
        [alertView show];
    }
    else {
        UIAlertController *alerController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        alerController.dismissBlock = dismiss;
        
        NSInteger index = 0;
        for (NSString *str in otherTitles) {
            UIAlertAction *others = [UIAlertAction actionWithTitle:str
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (alerController.dismissBlock) {
                                                                   alerController.dismissBlock(action.buttonIndex.integerValue, action.cancelIndex.integerValue);
                                                               }
                                                           }];
            others.buttonIndex = [NSNumber numberWithInteger:index];
            others.buttonIndex = [NSNumber numberWithInteger:otherTitles.count];
            [alerController addAction:others];
            index++;
        }
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           if (alerController.dismissBlock) {
                                                               alerController.dismissBlock(action.buttonIndex.integerValue, action.cancelIndex.integerValue);
                                                           }
                                                       }];
        cancel.cancelIndex = [NSNumber numberWithInteger:otherTitles.count];
        cancel.buttonIndex = [NSNumber numberWithInteger:otherTitles.count];
        [alerController addAction:cancel];
        
        [presentVC presentViewController:alerController animated:YES completion:nil];
    }
}

+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)otherTitles inView:(UIView *)view dismissBlock:(AlertDismissBlock)dismiss presentVC:(UIViewController *)presentVC
{
    LXAlertManager *manager = [self shareInstance];
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title
                                                           delegate:manager
                                                  cancelButtonTitle:nil
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:nil, nil];
        sheet.dismissBlock = dismiss;
        for (NSString *str in otherTitles) {
            [sheet addButtonWithTitle:str];
        }
        [sheet addButtonWithTitle:cancelTitle];
        sheet.cancelButtonIndex = otherTitles.count;
        [sheet showInView:view];
    }
    else {
        UIAlertController *alerController = [UIAlertController
                                             alertControllerWithTitle:title
                                             message:message
                                             preferredStyle:UIAlertControllerStyleActionSheet];
        alerController.dismissBlock = dismiss;
        
        NSInteger index = 0;
        for (NSString *str in otherTitles) {
            UIAlertAction *others = [UIAlertAction actionWithTitle:str
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (alerController.dismissBlock) {
                                                                   alerController.dismissBlock(action.buttonIndex.integerValue, action.cancelIndex.integerValue);
                                                               }
                                                           }];
            others.buttonIndex = [NSNumber numberWithInteger:index];
            others.buttonIndex = [NSNumber numberWithInteger:otherTitles.count];
            [alerController addAction:others];
            index++;
        }
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           if (alerController.dismissBlock) {
                                                               alerController.dismissBlock(action.buttonIndex.integerValue, action.cancelIndex.integerValue);
                                                           }
                                                       }];
        
        cancel.cancelIndex = [NSNumber numberWithInteger:otherTitles.count];
        cancel.buttonIndex = [NSNumber numberWithInteger:otherTitles.count];
        [alerController addAction:cancel];
        
        [presentVC presentViewController:alerController animated:YES completion:nil];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.dismissBlock) {
        alertView.dismissBlock(buttonIndex, alertView.cancelButtonIndex);
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.dismissBlock) {
        actionSheet.dismissBlock(buttonIndex, actionSheet.cancelButtonIndex);
    }
}

@end

const static NSString *kAlertViewDissmissBlock = @"kAlertViewDissmissBlock";
@implementation UIAlertView (LXDismissBlock)

- (void)setDismissBlock:(AlertDismissBlock)dismissBlock
{
    objc_setAssociatedObject(self, &kAlertViewDissmissBlock, dismissBlock, OBJC_ASSOCIATION_COPY);
}

- (AlertDismissBlock)dismissBlock
{
    return objc_getAssociatedObject(self, &kAlertViewDissmissBlock);
}

@end

const static NSString *kActionSheetDissmissBlock = @"kActionSheetDissmissBlock";
@implementation UIActionSheet (LXDismissBlock)

- (void)setDismissBlock:(AlertDismissBlock)dismissBlock
{
    objc_setAssociatedObject(self, &kActionSheetDissmissBlock, dismissBlock, OBJC_ASSOCIATION_COPY);
}

- (AlertDismissBlock)dismissBlock
{
    return objc_getAssociatedObject(self, &kActionSheetDissmissBlock);
}

@end

const static NSString *kAlertControllerDissmissBlock = @"kAlertControllerDissmissBlock";
@implementation UIAlertController (LXDismissBlock)

- (void)setDismissBlock:(AlertDismissBlock)dismissBlock
{
    objc_setAssociatedObject(self, &kAlertControllerDissmissBlock, dismissBlock, OBJC_ASSOCIATION_COPY);
}

- (AlertDismissBlock)dismissBlock
{
    return objc_getAssociatedObject(self, &kAlertControllerDissmissBlock);
}

@end

const static NSString *kAlertActionCancelIndex = @"kAlertActionCancelIndex";
const static NSString *kAlertActionButtonIndex = @"kAlertActionButtonIndex";
@implementation UIAlertAction (LXActionIndex)

- (void)setCancelIndex:(NSNumber *)cancelIndex
{
    objc_setAssociatedObject(self, &kAlertActionCancelIndex, cancelIndex, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)cancelIndex
{
    return objc_getAssociatedObject(self, &kAlertActionCancelIndex);
}

- (void)setButtonIndex:(NSNumber *)buttonIndex
{
    objc_setAssociatedObject(self, &kAlertActionButtonIndex, buttonIndex, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)buttonIndex
{
    return objc_getAssociatedObject(self, &kAlertActionButtonIndex);
}

@end

