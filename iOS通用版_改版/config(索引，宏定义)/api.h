//
//  api.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/7.
//  Copyright © 2020 许广超. All rights reserved.
//

#ifndef api_h
#define api_h

#if defined(DEBUG)

#define MAINAPI @"" //开发
#define ServerAPI @"http://edu.sooc.com"//开发dangxiao
#define ServerID @"DEV_YTWLDX_SOOC"//开发

#else

#endif


//节点API版本号
#define API_VERSION_BASE @"1"


/**
 新登录
 */
#define API_Newlogin @"default/login"
#define API_info @"default/info"


/*登录按钮的节点*/
#define API_LoginClicked @"Oauth/authorize"
/*上传文件*/
#define API_Oauth_upload @"Oauth/authorize"
/*上传文件*/
#define API_File_upload @"uploader/saveFile"
/*课程分类*/
#define API_AllCourse @"Course/departMenu"
/*首页轮播图*/
#define API_lunboImage @"Sooc/index_tj"
/*获取项目是否收费状态*/
#define API_GetCourseConfig @"course/getCourseConfig"
/*获取项目平台有没有直播*/
#define API_live_isLive @"live/isLive"
/*全部课程*/
#define API_allNewCourse @"Course/allNewCourse"
/*课程详情*/
#define API_courseInfo @"Course/info"
/*课程列表*/
#define API_CourseCateList @"Course/newCatalog"

#endif /* api_h */
