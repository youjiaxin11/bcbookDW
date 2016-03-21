//
//  BaseControl.h
//  BXBook
//
//  Created by sunzhong on 15/7/16.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "UserDao.h"
#import "User.h"
#import "GameDao.h"
#import "Game.h"
#import "Line.h"
#import "Puzzle.h"
#import "Shoot.h"
#import "Task.h"
#import "CWStarRateView.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoPlay.h"
#import "PlayMusicImpl.h"
#import <AVFoundation/AVFoundation.h>
//#import "WebUtil.h"
#import "WorkDao.h"
#import "TimeUtil.h"
#import "DataUtil.h"
//#import "GraphKit.h"
#import "TaskDao.h"
#import "UserTask.h"
#import "HelpDao.h"
#import "SqliteUtil.h"
#import "Questions.h"
#import "QuestionsDao.h"
#import "Friend.h"
#import "CDSideBarController.h"
#import "Behaviour.h"
#import "BehaviourDao.h"


typedef void(^ResponseCallback)(NSMutableDictionary*);

@interface BaseControl : UIViewController<UIAlertViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, AVAudioRecorderDelegate,UICollectionViewDelegate,UITableViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,CDSideBarControllerDelegate>
{
    CDSideBarController *sideBar;
}




@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;



//弹出窗口
- (void) prompt:(NSString*) message;
- (void) prompt2:(NSString*) message;
- (void) prompt3:(NSString*) message;

//Puzzle
- (void) promptPuzzle:(NSString*) message;
- (void) promptCheats:(NSString*) message;
- (void) promptNotFinish:(NSString*) message;

//Line
- (void) promptLine1:(NSString*) message;
- (void) promptLine2:(NSString*) message;
- (void) promptLine3:(NSString*) message;
- (void) promptLine4:(NSString*) message;
//Shoot
- (void) promptShootFinish:(NSString*) message;
- (void) promptShootNotFinish:(NSString*) message;
- (void) promptGoldenNotEnough:(NSString*) message;

#pragma mark 请求TCK服务器
#pragma _partUrl 接口路径，只需要后面一截
#pragma _param 参数，多个参数用&隔开
#pragma _callback 回调函数的block
#pragma is_loading 如果为yes就表示要开启一个UIActivityIndicatorView
#pragma is_backup 是否需要备份数据(一般查询的数据需要备份，提交的数据不需要)
#pragma is_solveFail 调用接口失败时，是否内部处理错误
#pragma _frequency 调用接口的频率(单位：秒)，及时调接口，就传入0
- (void)requestTck:(NSString*)_partUrl _param:(NSString*)_param _callback:(ResponseCallback)_callback is_loading:(BOOL)is_loading is_backup:(BOOL)is_backup is_solveFail:(BOOL)is_solveFail _frequency:(int)_frequency;

//#pragma mark 获取导航条上级控制器
//- (BaseControl*)getNavigationControl;

@end
