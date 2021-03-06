//
//  NBURLNavigation.m
//  NBRouter
//
//  Created by NapoleonBai on 16/10/18.
//  Copyright © 2016年 BaiZhiqiang. All rights reserved.
//

#import "NBURLNavigation.h"

@interface NBURLNavigation()

@property(nonatomic,strong,readwrite)UINavigationController *currentNavigationViewController;
@property(nonatomic,strong,readwrite)UIViewController *currentViewController;


@end

@implementation NBURLNavigation

NBSingletonM(NBURLNavigation)

- (UIViewController*)currentViewController {
    UIViewController* rootViewController = self.applicationDelegate.window.rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

- (UINavigationController*)currentNavigationViewController {
    UIViewController* viewController = self.currentViewController;

    if (viewController.navigationController) {
        return viewController.navigationController;
    }
    
    NSAssert(0, @"你可能遇到了一个假的导航栏控制器");
    return nil;
}

- (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (!viewController) {
        NSAssert(0, @"你可能写了一个假的跳转链接,导致我们没有找到目标控制器");
    }else {
        UINavigationController *navigationController = [NBURLNavigation sharedNBURLNavigation].currentNavigationViewController;
        if (navigationController) {
            [navigationController pushViewController:viewController animated:animated];
        }else{
            NSAssert(0, @"你可能遇到了一个假的导航栏控制器,无法进行push操作");
        }
    }
}

+ (void)presentViewController:(UIViewController *)viewController animated: (BOOL)flag completion:(void (^ __nullable)(void))completion
{
    if (!viewController) {
        NSAssert(0, @"你可能写了一个假的跳转链接,导致我们没有找到目标控制器");
    }else {
        UIViewController *currentViewController = [[NBURLNavigation sharedNBURLNavigation] currentViewController];
        if (currentViewController) {
            // 当前控制器存在
            [currentViewController presentViewController:viewController animated:flag completion:completion];
        } else {
            NSAssert(0, @"你可能在进行一个假的模态跳转操作,因为我们没有找到根控制器");
        }
    }
}

    
// 设置为根控制器
+ (void)setRootViewController:(UIViewController *)viewController
{
    NBURLNavigation *navigation = [NBURLNavigation sharedNBURLNavigation];
    if (!navigation.applicationDelegate.window) {
        navigation.applicationDelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [navigation.applicationDelegate.window makeKeyAndVisible];
    }
    navigation.applicationDelegate.window.rootViewController = viewController;
}


// 通过递归拿到当前控制器
- (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    } // 如果传入的控制器是导航控制器,则返回最后一个
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    } // 如果传入的控制器是tabBar控制器,则返回选中的那个
    else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    } // 如果传入的控制器发生了modal,则就可以拿到modal的那个控制器
    else {
        return viewController;
    }
}

+ (void)popTwiceViewControllerAnimated:(BOOL)animated {
    [NBURLNavigation popViewControllerWithTimes:2 animated:YES];
}

+ (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UINavigationController *currentViewController = [[NBURLNavigation sharedNBURLNavigation] currentNavigationViewController];
    NSAssert(currentViewController, @"当前控制器不是导航栏控制器");
    NSAssert(viewController, @"指定的ViewController不能为null");

    if(currentViewController && viewController){
        [currentViewController popToViewController:viewController animated:animated];
    }
}

+ (void)popViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated {
    
    UINavigationController *currentViewController = [[NBURLNavigation sharedNBURLNavigation] currentNavigationViewController];

    if(currentViewController){
        if (times==1) {
            [currentViewController popViewControllerAnimated:animated];
        }else{
            NSUInteger count = currentViewController.viewControllers.count;
            if (count > times){
                [currentViewController popToViewController:[currentViewController.viewControllers objectAtIndex:count-1-times] animated:animated];
            }else {
                // 如果times大于控制器的数量, 那么就直接后退到根控制器主页
                [currentViewController popToRootViewControllerAnimated:animated];
            }
        }
    }
}
+ (void)popToRootViewControllerAnimated:(BOOL)animated {
    [[NBURLNavigation sharedNBURLNavigation].currentNavigationViewController popToRootViewControllerAnimated:animated];
}

+ (void)dismissViewControllerWithTimes:(NSUInteger)times animated: (BOOL)flag completion: (void (^ __nullable)(void))completion {
    UIViewController *rootVC = [[NBURLNavigation sharedNBURLNavigation] currentViewController];
    
    if (rootVC) {
        // 如果dismiss 次数超过根控制器所在层,那么就直接退到根控制器层,不再向前处理
        while (times > 0 && rootVC.presentingViewController) {
            rootVC = rootVC.presentingViewController;
            times -= 1;
        }
        [rootVC dismissViewControllerAnimated:YES completion:completion];
    }
}


+ (void)dismissToRootViewControllerAnimated: (BOOL)animate completion: (void (^ __nullable)(void))completion {
    UIViewController *currentViewController = [[NBURLNavigation sharedNBURLNavigation] currentViewController];
    UIViewController *rootVC = currentViewController;
    while (rootVC.presentingViewController) {
        rootVC = rootVC.presentingViewController;
    }
    [rootVC dismissViewControllerAnimated:animate completion:completion];
}

@end
