//
//  MyWorks.m
//  BXBook
//
//  Created by sunzhong on 15/8/12.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "MyWorks.h"
#import "WebUtil.h"
#import "WorksCell.h"
#import "PhotosController.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"

@implementation MyWorks
@synthesize taskId, pageType;

User* userMyWorks;
NSMutableArray *workArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    userMyWorks = self.user;
    NSLog(@"%@",userMyWorks.loginName);
    NSLog(@"%d",taskId);
    NSLog(@"%d",pageType);
    if (pageType == 0) {
      //  [self getTaskMyWorks:@"/memberAction!login.action"];
    }else if (pageType == 1){
        [self getAllMyWorks:@"/taskAction!taskByUserId.action"];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 300,70)];
}
- (void)menuButtonClicked:(int)index{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userMyWorks;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userMyWorks;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userMyWorks;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   // NSLog(@"itms count:%d", [itms count]);
    return [itms count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WorksCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"WorksCell" forIndexPath:indexPath];
    cell.imageview.image=[itms objectAtIndex:indexPath.row];
    cell.bounds=CGRectMake(0, 0, 90, 90);
     NSLog(@"itms count:%d", [itms count]);
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)getAllMyWorks:(NSString*)url {
    NSString *param = [NSString stringWithFormat:@"userid=%d", userMyWorks.userId];
    [self requestTck:url _param:param _callback:^(NSMutableDictionary *map) {
        NSLog(@"!!!!!!!!!!!!getAll:%@",map);
        NSArray* arr = [map objectForKey:@"list"];
        NSLog(@"arr大小：%d", [arr count]);
        workArr = [[NSMutableArray alloc] initWithCapacity:[arr count]];
        for (int i=0; i<[arr count]; i++) {
            NSDictionary* dic = [arr objectAtIndex:i];
            Work* work = [WorkDao decodeWork:dic];
            [workArr addObject:work];
             NSLog(@"%d:%@", i, [[workArr objectAtIndex:i] taskUrl]);
        }

        //显示在collectionView
        [self displayColletionView:workArr];
        
        

    } is_loading:YES is_backup:NO is_solveFail:YES _frequency:0];
}

- (void)displayColletionView:(NSMutableArray *)workArr{
    self.collectionview.backgroundColor=[UIColor whiteColor];
    [self.collectionview registerClass:[WorksCell class] forCellWithReuseIdentifier:@"WorksCell"];
    itms=[[NSMutableArray alloc]initWithCapacity:[workArr count]];
    for (int i=0; i<[workArr count]; i++) {
        NSString* workUrl = [[[workArr objectAtIndex:i] taskUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url=[NSURL URLWithString:workUrl];
    //    NSData* imageData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:NULL error:NULL];
        NSData* imageData = [NSData dataWithContentsOfURL:url];
        UIImage *imgFromUrl =[UIImage imageWithData:imageData];
        NSLog(@"workurl:%@",workUrl);
        NSLog(@"url:%@",url);
        NSLog(@"imageData:%@",imageData);
        NSLog(@"imgFromUrl:%@",imgFromUrl);
        [itms addObject:[UIImage imageNamed:@"answer4_1.png"]];
    }
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
}

- (void)getTaskMyWorks:(NSString*)url {
    
 //   NSString *param = [NSString stringWithFormat:@"userId=%d,taskId=%d", userMyWorks.userId, taskId];
  //  [self requestTck:url _param:param _callback:^(NSMutableDictionary *map){
        
  //  } is_loading:YES is_backup:NO is_solveFail:YES _frequency:0];
    
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end