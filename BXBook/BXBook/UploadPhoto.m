//
//  UploadPhoto.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "UploadPhoto.h"

@implementation UploadPhoto
@synthesize contentimageview;
@synthesize contenttextview;
@synthesize lastChosenMediaType;

User* userUploadPhoto;
Task* taskUploadPhoto;
NSString* str1_photo;
NSString* str2_photo;
NSString* str3_photo;
NSString* str4_photo;
NSString* taskTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    userUploadPhoto = self.user;
    taskUploadPhoto = self.task;
    if (taskUploadPhoto == nil) {
        taskTitle = @"思维图";
    }else{
        taskTitle = taskUploadPhoto.taskTitle;
    }
    NSLog(@"photo : %@",userUploadPhoto.loginName);
    NSLog(@"任务名：%@",taskTitle);

    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userUploadPhoto.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"UploadPhoto-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
}

- (IBAction)addPhoto:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请选择图片来源" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [alert show];
}

#pragma 拍照选择模块
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1)
        [self shootPiicturePrVideo];
    else if(buttonIndex==2)
        [self selectExistingPictureOrVideo];
}
#pragma  mark- 拍照模块
//从相机上选择
-(void)shootPiicturePrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}
//从相册中选择
-(void)selectExistingPictureOrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma 拍照模块
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.lastChosenMediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([lastChosenMediaType isEqual:(NSString *) kUTTypeImage])
    {
        //记录行为数据
        NSString* timeNow = [TimeUtil getTimeNow];
        Behaviour *behaviour = [[Behaviour alloc]init];
        behaviour.userId = userUploadPhoto.userId;
        behaviour.doWhat = @"上传－本地";
        behaviour.doWhere = @"UploadPhoto-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info";
        behaviour.doWhen = timeNow;
        [BehaviourDao addBehaviour:behaviour];
        
        //保存在本地相册
        UIImage *chosenImage=[info objectForKey:UIImagePickerControllerEditedImage];
        contentimageview.image=chosenImage;
        UIImageWriteToSavedPhotosAlbum(contentimageview.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contexInfo:), nil );
        
        //获取当前时间
     //   NSString* timeNow = [TimeUtil getTimeNow];
        //保存在本机沙盒
        str1_photo = [userUploadPhoto.loginName stringByAppendingString:@"+"];
        str2_photo = [str1_photo stringByAppendingString:[NSString stringWithFormat:@"%@+", taskTitle]];
        str3_photo = [str2_photo stringByAppendingString:timeNow];
        str4_photo = [str3_photo stringByAppendingString:@"+photo.png"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:str4_photo];   // 保存文件的名称
        NSData *imagData = UIImagePNGRepresentation(chosenImage);
        [imagData writeToFile: filePath  atomically:YES];
        
        
        MyWork *work = [[MyWork alloc]init];
        work.workId = 100;
        work.userId = userUploadPhoto.userId;
        work.taskTitle = taskTitle;
        work.type = 1;
        work.uploadTime = timeNow;
        work.filePath = filePath;
        
        NSLog(@"----即将上传的作品");
        NSLog(@"作品信息：1:%d－－－2:%d－－－3:%@－－－4:%@－－－5:%d－－－6:%@",work.workId,work.userId,work.uploadTime,work.taskTitle,work.type,work.filePath);
        
        [MyWorkDao addMyWork:work.workId andUserId:work.userId andTaskTitle:work.taskTitle andUploadTime:work.uploadTime andType:work.type andFilePath:work.filePath];
       
        [WorkDao insertWork:userUploadPhoto.userId taskId:taskUploadPhoto.taskId taskUrl:nil recPN:0 recCN:0 golden:0 uplT:timeNow score:0 loca:0];
    }
    if([lastChosenMediaType isEqual:(NSString *) kUTTypeMovie])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持图片格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediatypes count]>0){
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.mediaTypes=mediatypes;
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        NSString *requiredmediatype=(NSString *)kUTTypeImage;
        NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
}


//上传作品
- (IBAction)uploadWorks:(id)sender{
        [self createSelfPrompt:@"已保存在本地，服务器正在建设中" image:[UIImage imageNamed:@"happy.jpg"]];
    
}

-(void) imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:(NSError*)error contexInfo:(void*) contextInfo{
    if (!error) {
       // [self prompt:@"成功保存到本地相册"];
    }else {
       // [self prompt:[error description]];
    }
}


//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"lefttaskinfo");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

