//
//  AppDelegate.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/7.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "AppDelegate.h"
#import "BasedUsingTabBarVC.h"
//#import "SC_NavigationController.h"
#import "YSYHasNetwork.h"
#import "LoginVC.h"
#import "GC_GuidVC.h"

@interface AppDelegate ()
@property(nonatomic,strong)BasedUsingTabBarVC *tabBarVC;
@property(nonatomic,strong)LoginVC *loginVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];

    [self AutoLogIn];
    
    //重新登录 和 登录成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginsucess) name:LoginSucceed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTab) name:@"relogin" object:nil];
    
    [self keyborbManager];
    //监听网络状态
    [self noticeNetWorking];
    
    return YES;
}

- (void)keyborbManager{
   IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
   keyboardManager.enable = YES; // 控制整个功能是否启用
   keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
   keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
   keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
   keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
   keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
   keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
   keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}

- (void)AutoLogIn{
    NSUserDefaults * firstLogin = [NSUserDefaults standardUserDefaults];
    BOOL isFirstTimeLogin =[firstLogin boolForKey:kIsFirstTimeLogin];
    if (isFirstTimeLogin == NO) {
        GC_GuidVC *vc = [[GC_GuidVC alloc]init];
        self.window.rootViewController = vc;
        vc.imgArr = @[@"引导页1",@"引导页2",@"引导页3"];
        vc.backBlock = ^{
            [firstLogin setBool:YES forKey:kIsFirstTimeLogin];
            [self changeTab];
        };
    }else{
        if (MESSAGE_CENTER.islogin) {
            [self httpAutoLogin];
        }else{
            [self changeTab];
        }
    }
}

#pragma mark --- 走接口自动登录
- (void)httpAutoLogin{
    //1.准备网址
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/index.php?r=v1/%@",MESSAGE_CENTER.xtdz,API_LoginClicked]];
    //2.准备请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //2.1设置请求方式
    [request setHTTPMethod:@"POST"];
    //2.2设置请求参数
    //#warning 设置请求参数,需要的是NSData类型
    NSDictionary *logRequestDic = [[NSUserDefaults standardUserDefaults]objectForKey:LoginRequest];
    NSString *basepara = [self dictionaryToJson:logRequestDic];
    NSData *param = [basepara dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:param];
    //3.创建链接对象,并发送请求,获取结果
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data == nil) {
        //解析失败
        MESSAGE_CENTER.islogin = NO;
    }else{
        //4.解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dict==nil || [dict isEqual:[NSNull null]]||dict.count == 0) {
             [[NSUserDefaults standardUserDefaults]setBool:NO forKey:LoginSucceed];
            return;
        }
        if ([dict[@"status"] intValue]==0) {
            //数据更新
            GC_UserModel *model = [[GC_UserModel alloc]init];
            [model mj_setKeyValues:dict[@"data"]];
            MESSAGE_CENTER.userModel = model;
            MESSAGE_CENTER.islogin = YES;
            MESSAGE_CENTER.oauth_token = dict[@"oauth_token"];
            MESSAGE_CENTER.oauth_token_secret = dict[@"oauth_token_secret"];
            MESSAGE_CENTER.islogin = YES;
        }else{
            MESSAGE_CENTER.islogin = NO;
        }
    }
    
    if (MESSAGE_CENTER.islogin) {
        [self joinTabBar];
    }else{
        [self changeTab];
    }
}

#pragma mark -- 进入TabBar
- (void)joinTabBar{
    self.tabBarVC = [[BasedUsingTabBarVC alloc]init];
    self.tabBarVC.delegate = (id)self;
    [self.window setRootViewController:self.tabBarVC];
}
#pragma mark - ------登陆成功通知
-(void)loginsucess{
    [self joinTabBar];
}
#pragma mark - ------重新登录
-(void)changeTab{
    self.loginVC = [[LoginVC alloc]init];
    [self.window setRootViewController:self.loginVC];
    MESSAGE_CENTER.islogin = NO;
}

#pragma mark -- 监听网络状态
- (void)noticeNetWorking{
    [YSYHasNetwork ysy_hasNetwork:^(bool has) {
        if (has == NO) {
            SCLog(@"网络连接失败！");
        }
    }];
}
#pragma mark - ------字典转字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (!dic ) {
        return nil;
    }
    NSString *newStr = [[NSString alloc]init];
    for (NSString *str in dic.allKeys) {
        newStr = [newStr stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",str,dic[str]]];
    }
    newStr = [newStr substringFromIndex:1];
    return newStr;
    
}
@end
