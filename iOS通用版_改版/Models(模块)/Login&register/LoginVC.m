//
//  LoginVC.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/9.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "LoginVC.h"
#import "NSString+Hashing.h"
#import "GC_TextField.h"

@interface LoginVC ()

@property(nonatomic,strong)GC_TextField *userNameField;
@property(nonatomic,strong)GC_TextField *passwordField;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)NSArray *textFieldArr;

@end

@implementation LoginVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navbar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self setRACSignal];
}

- (void)setRACSignal
{
    //创建用户信号通道
    RACSignal *userNameSignal = [self.userNameField.rac_textSignal map:^id(id value) {
        return @([self isValidUsername:value]);
    }];
    
    //创建密码信号道
    RACSignal *passwordSignal = [self.passwordField.rac_textSignal map:^id(id value) {
        return @([self isValidPassword:value]);
    }];
    
    // 通过信号道返回的值，设置文本字体颜色
    RAC(self.userNameField, textColor) = [userNameSignal map:^id(id value) {
        return [value boolValue] ? Color_title_white : Color_ffea00;
    }];
    
     //通过信号道返回的值，设置文本字体颜色
    RAC(self.passwordField, textColor) = [passwordSignal map:^id(id value) {
        return [value boolValue] ? Color_title_white : Color_ffea00;
    }];
    
    // 创建登陆按钮信号道，并合并用户名和密码信号道
    RACSignal *loginSignal = [RACSignal combineLatest:@[userNameSignal,passwordSignal] reduce:^id(NSNumber *userNameValue, NSNumber *passwordValue){
        return @([userNameValue boolValue] && [passwordValue boolValue]);
    }];
    
    // 订阅信号
   [loginSignal subscribeNext:^(id boolValue) {
       if ([boolValue boolValue]) {
           self.loginBtn.userInteractionEnabled = YES;
           [self.loginBtn setBackgroundColor:Color_title_white];
       }else {
           self.loginBtn.userInteractionEnabled = NO;
           [self.loginBtn setBackgroundColor:Color_title_white30];
       }
   }];
   
   [[self.loginBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(UIButton *sender) {
//       [self loginServe];
       SCHttpRequest *request = [[SCHttpRequest alloc]initWithApi:API_Newlogin params:@{@"account":_userNameField.text,@"password":_passwordField.text.MD5Digest}];
       request.needToken = NO;
       
      [[SCToolManager shareInstance]doPOSTConnect:request start:^(SCHttpRequest * _Nonnull req) {
          
      } success:^(SCHttpRequest * _Nonnull req, SCHttpResponse * _Nonnull resp) {
          if (resp.resultcode == 200) {
              MESSAGE_CENTER.oauth_token = resp.dictionary[@"access_token"];
              [self getInfo];
          }else{
              ALERT_FAIL(resp.resultMsg);
              SCLog(@"%@", resp.resultMsg);
          }
      } failure:^(SCHttpRequest * _Nonnull req, NSError * _Nonnull error) {
          
      } finish:^(SCHttpRequest * _Nonnull req, BOOL success) {
          
      }];
   }];
}

//登录
- (void)loginServe{
    if (MAINAPI.length == 0 || MAINAPI == nil) {
        //走节点
        SCHttpRequest *request = [[SCHttpRequest alloc]initWithApi:API_Newlogin params:@{@"account":_userNameField.text,@"password":_passwordField.text.MD5Digest}];
        
        [[SCToolManager shareInstance]doGETConnect:request start:^(SCHttpRequest * _Nonnull req) {
            
        } success:^(SCHttpRequest * _Nonnull req, SCHttpResponse * _Nonnull resp) {
            if (resp.resultcode == 200) {

            }else{
                ALERT_FAIL(resp.resultMsg);
            }
        } failure:^(SCHttpRequest * _Nonnull req, NSError * _Nonnull error) {
            
        } finish:^(SCHttpRequest * _Nonnull req, BOOL success) {
            
        }];
    }else{
        //走云端
        [self loadDataWithCloud];
    }
}


- (void)getInfo{
    SCHttpRequest *request = [[SCHttpRequest alloc]initWithApi:API_info params:nil];
    
    [[SCToolManager shareInstance]doGETConnect:request start:^(SCHttpRequest * _Nonnull req) {
        
    } success:^(SCHttpRequest * _Nonnull req, SCHttpResponse * _Nonnull resp) {
        if (resp.resultcode == 200) {
            
        }else{
            ALERT_FAIL(resp.resultMsg);
        }
    } failure:^(SCHttpRequest * _Nonnull req, NSError * _Nonnull error) {
        
    } finish:^(SCHttpRequest * _Nonnull req, BOOL success) {
        
    }];
}

/**
 节点
 */
/**
 登录走节点
 */
-(void)loadDataWithServer{
    
    __weak __typeof__(self) weakSelf = self;
    
    //手机系统版本号
    NSString *strSysVersion    = [[UIDevice currentDevice] systemVersion];
    //手机型号
    NSString* phoneModel       = [[UIDevice currentDevice] model];
//    NSString * UUID            = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSDictionary *dic = @{@"email":_userNameField.text,@"pwd":_passwordField.text.MD5Digest,@"soocversion":strSysVersion,@"soocdevice":phoneModel};

    SCHttpRequest *request = [[SCHttpRequest alloc]initWithApi:API_Oauth_upload params:dic];
    
    [[SCToolManager shareInstance]doGETConnect:request start:^(SCHttpRequest * _Nonnull req) {
        
    } success:^(SCHttpRequest * _Nonnull req, SCHttpResponse * _Nonnull resp) {
        if (resp.resultcode == 0) {
            __typeof__(self) strongSelf = weakSelf;
            GC_UserModel *model = [[GC_UserModel alloc]init];
            [model mj_setKeyValues:resp.dictionary];
            MESSAGE_CENTER.userModel = model;
            MESSAGE_CENTER.count = strongSelf.userNameField.text;
            MESSAGE_CENTER.password = strongSelf.userNameField.text;
            MESSAGE_CENTER.islogin = YES;
            MESSAGE_CENTER.oauth_token = resp.originalDictionary[@"oauth_token"];
            MESSAGE_CENTER.oauth_token_secret = resp.originalDictionary[@"oauth_token_secret"];
            
            //保存登陆请求的信息  用于自动登陆验证
            [[NSUserDefaults standardUserDefaults]setObject:dic forKey:LoginRequest];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter]postNotificationName:LoginSucceed object:nil];
            });
            
        }else{
            ALERT_FAIL(resp.resultMsg);
        }
    } failure:^(SCHttpRequest * _Nonnull req, NSError * _Nonnull error) {
        
    } finish:^(SCHttpRequest * _Nonnull req, BOOL success) {
        
    }];
}

/**
 登录走云端
 */
- (void)loadDataWithCloud{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [para setObject:_userNameField.text forKey:@"account"];
    [para setObject:@"2" forKey:@"app_type"];//党校走云端需要增加此参数
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/index.php?m=api&c=Index&a=getSnsList",MAINAPI];
    
    [manager POST:url parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self responseCloudFinished:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/**
获取到云端数据
*/
-(void)responseCloudFinished:(id )operation
{
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:operation options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    if ([data[@"status"] integerValue] == 0) {
        NSInteger count = [data[@"count"] intValue];
        switch (count) {
            case 0://节点列表中没有数据
                ALERT_FAIL(@"账号不存在！");
                break;
            case 1://有一个节点
                //获取到当前数据
                {
                    NSDictionary *dic = data[@"lists"][0];
                    //记录节点地址
                    [self recordServerInfoWithMc:dic[@"sqmc"]
                                           Snsid:dic[@"snsid"]
                                            Xtdz:dic[@"xtdz"]];
                    //登录节点
                    [self loadDataWithServer];
                }
                break;
            default:
                {
                           UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                           NSArray *arr = data[@"lists"];
                           
                           for (int i =0; i<arr.count; i++) {
                               
                               UIAlertAction *action = [UIAlertAction actionWithTitle:arr[i][@"sqmc"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                   
                                   NSDictionary *dic = arr[i];
                                   //记录节点地址
                                   [self recordServerInfoWithMc:dic[@"sqmc"]
                                                          Snsid:dic[@"snsid"]
                                                           Xtdz:dic[@"xtdz"]];
                                   //登录节点
                                   [self loadDataWithServer];
                                   
                               }];
                               
                               [sheet addAction:action];
                               
                           }
                           UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                               
                           }];
                           
                           [sheet addAction:action1];
                           
                           [self presentViewController:sheet animated:YES completion:nil];
                           
                       }
                break;
        }
    }
}

- (void)recordServerInfoWithMc:(NSString *)mc Snsid:(NSString *)snsid Xtdz:(NSString *)xtdz{
    
    //记录节点地址
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    /*节点域名*/
//    [userDefaults setObject:xtdz forKey:@"xtdz"];
    MESSAGE_CENTER.xtdz = xtdz;
    
    /*节点名称*/
    [userDefaults setObject:mc forKey:@"sqmc"];
    
    /*节点ID*/
    [userDefaults setObject:snsid forKey:@"snsid"];
    
    [userDefaults synchronize];
}

// 验证用户名
- (BOOL)isValidUsername:(NSString *)username {
    
    // 验证用户名 - 手机号码
//    NSString *regEx = @"^1[3|4|5|7|8][0-9]\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
//
//    return [phoneTest evaluateWithObject:username];
    if (username.length >0) {
        return YES;
    }else{
        return NO;
    }
}

// 验证密码 - 由数字和26个英文字母组成的字符串
- (BOOL)isValidPassword:(NSString *)password {
    
//    NSString *regEx = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
//    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
//    return [passwordTest evaluateWithObject:password];
    if (password.length >0) {
        return YES;
    }else{
        return NO;
    }
}
-(void)createUI{
    
    UIImageView *bgImage = [UIImageView new];
    bgImage.image = [UIImage imageNamed:@"渐变底图"];
    [self.view addSubview:bgImage];
    bgImage.whc_TopSpace(0).whc_LeftSpace(0).whc_Width(SIZEWIDTH).whc_BottomSpace(0);
    bgImage.userInteractionEnabled = YES;
    
    UIImageView *bImage = [UIImageView new];
    bImage.image = [UIImage imageNamed:@"登录页背景图"];
    [bgImage addSubview:bImage];
    bImage.whc_LeftSpace(0).whc_Width(SIZEWIDTH).whc_BottomSpace(0).whc_Height(260);
    bImage.contentMode = UIViewContentModeScaleAspectFill;
    
    UIImageView *touImg = [UIImageView new];
    touImg.layer.cornerRadius = 97/2;
    touImg.layer.masksToBounds = true;
    [bgImage addSubview:touImg];
    touImg.whc_CenterX(0).whc_TopSpace(SafeAreaTopHeight+50).whc_Size(97, 97);
    touImg.image = [UIImage imageNamed:@"186"];

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    UILabel *nameL = [UILabel new];
    nameL.textColor = Color_title_white;
    nameL.font = Fone_title36;
    nameL.text = [infoDictionary objectForKey:@"CFBundleName"];
    [bgImage addSubview:nameL];
    nameL.whc_CenterX(0).whc_TopSpaceToView(30, touImg).whc_HeightAuto().whc_WidthAuto();
    
    UIImageView *userImg = [UIImageView new];
    [bgImage addSubview:userImg];
    userImg.image = [UIImage imageNamed:@"登录-用户名"];
    userImg.whc_LeftSpace(30).whc_TopSpaceToView(50, nameL).whc_Size(30, 30);
    
    UIImageView *passImg = [UIImageView new];
    [bgImage addSubview:passImg];
    passImg.image = [UIImage imageNamed:@"登录-密码"];
    passImg.whc_LeftSpace(30).whc_TopSpaceToView(25, userImg).whc_Size(30, 30);
 
    self.userNameField = [GC_TextField new];
    [bgImage addSubview:self.userNameField];
    self.userNameField.placeholder = @"请输入账号";
    self.userNameField.placeHolderNormalColor = Color_title_white70;
    self.userNameField.whc_CenterYToView(0, userImg).whc_Height(30).whc_RightSpace(30).whc_LeftSpaceToView(15, userImg);
    
    UIView *line = [UIView new];
    [bgImage addSubview:line];
    line.backgroundColor = Color_title_white;
    line.whc_LeftSpaceEqualView(_userNameField).whc_RightSpaceEqualView(_userNameField
                                                                        ).whc_Height(1).whc_TopSpaceToView(0, _userNameField);
    self.passwordField = [GC_TextField new];

        [bgImage addSubview:self.passwordField];
        self.passwordField.placeholder = @"请输入密码";
    self.passwordField.placeHolderNormalColor = Color_title_white70;

        self.passwordField.whc_CenterYToView(0, passImg).whc_Height(30).whc_RightSpace(30).whc_LeftSpaceToView(15, passImg);
        
        UIView *line1 = [UIView new];
        [bgImage addSubview:line1];
        line1.backgroundColor = Color_title_white;
        line1.whc_LeftSpaceEqualView(_passwordField).whc_RightSpaceEqualView(_passwordField
                                                                            ).whc_Height(1).whc_TopSpaceToView(0, _passwordField);
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    [loginBtn setTitleColor:Color_Main forState:(UIControlStateNormal)];
    loginBtn.backgroundColor = Color_title_white30;
    [bgImage addSubview:loginBtn];
    loginBtn.whc_LeftSpace(35).whc_TopSpaceToView(50, line1).whc_RightSpace(35).whc_Height(50);
    self.loginBtn  = loginBtn;
}

@end
