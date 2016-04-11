//
//  FriendLevel.m
//  BXBook
//
//  Created by sunzhong on 15/8/12.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "FriendLevel.h"
#import "FriendCell.h"
#import "Myfriend.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "NotebookController.h"

@interface FriendLevel () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_msgList;
}

@end

static NSString * const RCellIdentifier = @"FriendCell";

@implementation FriendLevel
User* userFriendlevel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    userFriendlevel = self.user;
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userFriendlevel.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"FriendLevel-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    _msgList = [NSMutableArray arrayWithCapacity:6];
    //    for (int i=0; i<6; i++) {
    //        Friend *friend = [[Friend alloc] init];
    //        friend.friendId = i+1;
    //        friend.friendName = @"Ming";
    //        friend.golden  = 1000;
    //        [_msgList addObject:friend];
    //
    //    }
    Friend *friend = [[Friend alloc] init];
    friend.friendName = @"Ming";
    friend.golden  = 3000;
    [_msgList addObject:friend];
    
    Friend *friend2 = [[Friend alloc] init];
    friend2.friendName = @"Meimei";
    friend2.golden  = 998;
    [_msgList addObject:friend2];
    
    Friend *friend3 = [[Friend alloc] init];
    friend3.friendName = @"Siyu";
    friend3.golden  = 980;
    [_msgList addObject:friend3];
    
    Friend *friend4 = [[Friend alloc] init];
    friend4.friendName = @"Ran";
    friend4.golden  = 870;
    [_msgList addObject:friend4];
    
    Friend *friend5 = [[Friend alloc] init];
    friend5.friendName = @"Kai";
    friend5.golden  = 680;
    [_msgList addObject:friend5];
    
    Friend *friend6 = [[Friend alloc] init];
    friend6.friendName = @"Song";
    friend6.golden  = 340;
    [_msgList addObject:friend6];
    
    
    self.friendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.friendTableView.backgroundColor = [UIColor clearColor];
    
    UINib *chatNib = [UINib nibWithNibName:@"FriendCell" bundle:[NSBundle bundleForClass:[FriendCell class]]];
    
    [self.friendTableView registerNib:chatNib forCellReuseIdentifier:RCellIdentifier];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 300,70)];
}
- (void)menuButtonClicked:(int)index{
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userFriendlevel.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"Friendlevel-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userFriendlevel;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userFriendlevel;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userFriendlevel;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userFriendlevel;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _msgList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Friend *fri = _msgList[indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:RChatFontSize];
    CGFloat height = [fri.friendName sizeWithFont:font constrainedToSize:CGSizeMake(150, 10000)].height;
    CGFloat lineHeight = [font lineHeight];
    
    return RCellHeight + height - lineHeight+20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:RCellIdentifier];
    [cell bindMessage:_msgList[indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
