//
//  LineControl.m
//  BXBook
//
//  Created by sunzhong on 15/7/17.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "LineControl.h"

@implementation LineControl
@synthesize goldenLbl,lineContentLbl;
/*开发者在页面操作中，用这几个值*/
User *userLine;//当前登录用户
Game *gameLine;//当前游戏对象，存有所有题目及答案
int x1=0;
int x2=0;
int x3=0;
int z1=0;
int z2=0;
int z3=0;
int z4=0;
int z5=0;
int z6=0;
int cishu=0;
int right=0;
int wrong=0;
int tiaozhuan1=0;
int tiaozhuan2=0;
int tiaozhuan3=0;
int dangqian=0;
UIImageView* imageView;
UIImageView* imageView1;
UIImageView* imageView2;

int exitline = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    userLine = self.user;
   // gameLine = self.game;
    gameLine = [GameDao findGameByGameId:_gameChoiceNum];//根据关卡id读取到game表中的数据
    NSLog(@"line:当前登录用户：%@",userLine.loginName);
    NSLog(@"line:游戏表中的id：%d", gameLine.gameId);
    NSLog(@"line:此页面要显示的连线题内容如下：");
    NSLog(@"line:%d", gameLine.line.lineId);
    NSLog(@"line:%@", gameLine.line.question1);//问题1
    NSLog(@"line:%@", gameLine.line.question2);//问题2
    NSLog(@"line:%@", gameLine.line.question3);//问题3
    NSLog(@"line:%@", gameLine.line.answer1);//答案1
    NSLog(@"line:%@", gameLine.line.answer2);//答案2
    NSLog(@"line:%@", gameLine.line.answer3);//答案3
    NSLog(@"line:%d", gameLine.line.helpId);//helpId
    UIImage *image1=[UIImage imageNamed:@"lineImage1"];
    UIImage *image2=[UIImage imageNamed:@"lineImage2"];
    UIImage *image3=[UIImage imageNamed:@"lineImage3"];
    UIImage *image4=[UIImage imageNamed:@"lineImage4"];
    UIImage *image5=[UIImage imageNamed:@"lineImage5"];
    UIImage *image6=[UIImage imageNamed:@"lineImage6"];
    UIImage *image7=[UIImage imageNamed:@"lineImage7"];
    UIImage *image8=[UIImage imageNamed:@"lineImage8"];
    UIImage *image9=[UIImage imageNamed:@"lineImage9"];
    UIImage *image10=[UIImage imageNamed:@"lineImage10"];
    UIImage *image11=[UIImage imageNamed:@"lineImage11"];
    UIImage *image12=[UIImage imageNamed:@"lineImage12"];
    if(gameLine.line.lineId==11||gameLine.line.lineId==12){
        [_button1 setBackgroundImage:image1 forState:UIControlStateNormal];
        [_button2 setBackgroundImage:image6 forState:UIControlStateNormal];
        [_button3 setBackgroundImage:image2 forState:UIControlStateNormal];
        [_button4 setBackgroundImage:image4 forState:UIControlStateNormal];
        [_button5 setBackgroundImage:image3 forState:UIControlStateNormal];
        [_button6 setBackgroundImage:image5 forState:UIControlStateNormal];
    }
    else if(gameLine.line.lineId==2||gameLine.line.lineId==5){
        [_button1 setBackgroundImage:image12 forState:UIControlStateNormal];
        [_button2 setTitle:gameLine.line.answer1 forState:UIControlStateNormal];
        [_button3 setBackgroundImage:image8 forState:UIControlStateNormal];
        [_button4 setTitle:gameLine.line.answer2  forState:UIControlStateNormal];
        [_button5 setBackgroundImage:image11 forState:UIControlStateNormal];
        [_button6 setTitle: gameLine.line.answer3 forState:UIControlStateNormal];
    }
    else if(gameLine.line.lineId==8){
        [_button1 setBackgroundImage:image10 forState:UIControlStateNormal];
        [_button2 setTitle:gameLine.line.answer1 forState:UIControlStateNormal];
        [_button3 setBackgroundImage:image9 forState:UIControlStateNormal];
        [_button4 setTitle:gameLine.line.answer2  forState:UIControlStateNormal];
        [_button5 setBackgroundImage:image7 forState:UIControlStateNormal];
        [_button6 setTitle: gameLine.line.answer3 forState:UIControlStateNormal];
    }
    else
    { [_button1 setTitle:gameLine.line.question1 forState:UIControlStateNormal];
        [_button2 setTitle:gameLine.line.answer1 forState:UIControlStateNormal];
        [_button3 setTitle:gameLine.line.question2 forState:UIControlStateNormal];
        [_button4 setTitle:gameLine.line.answer2  forState:UIControlStateNormal];
        [_button5 setTitle:gameLine.line.question3 forState:UIControlStateNormal];
        [_button6 setTitle:gameLine.line.answer3  forState:UIControlStateNormal];
        
    }
    [goldenLbl setText:[NSString stringWithFormat:@"游戏币：%d", userLine.golden]];
    [lineContentLbl setText:gameLine.line.lineContent];
}
//跳转到下一页
-(void)nextpage1{
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PuzzleControl *puzzlecontrol = [mainStoryboard instantiateViewControllerWithIdentifier:@"Puzzle"];
    puzzlecontrol.user = userLine;
    puzzlecontrol.game = gameLine;
    [puzzlecontrol setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:puzzlecontrol animated:YES completion:nil];
}
//跳转到下一页
-(void)nextpage2{
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Cheats *Cheats = [mainStoryboard instantiateViewControllerWithIdentifier:@"Cheats"];
    Cheats.user = userLine;
  Cheats.game = gameLine;
    Cheats.flag1cheat=1;
    [Cheats setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:Cheats animated:YES completion:nil];
}

- (IBAction)button7:(UIButton *)sender {
    x1=1;
    if(x2==1) x2=0;
    if(x3==1) x3=0;
    
}
- (IBAction)button9:(UIButton *)sender {
    x2=1;
    if(x1==1) x1=0;
    if(x3==1) x3=0;
}
- (IBAction)button11:(UIButton *)sender {
    x3=1;
    if(x1==1) x1=0;
    if(x2==1) x2=0;
}



- (IBAction)button8:(UIButton *)sender {
    if(x1==1&&z1==0&&z4==0&&cishu<3)
    {
        [self huaxian1:_button1 btn:_button2 ];
        //[self.view addSubview:imageView1];
        //CGContextClearRect(UIGraphicsGetCurrentContext(),self.view.frame);
        x1=2;
        z1=1;
        z4=1;
        right++;
        dangqian=1;
    }
    
    if(x2==1&&z1==0&&z5==0&&cishu<3)
    {
        
        [self huaxian1:_button3 btn:_button2 ];
        x2=2;
        z1=1;
        z5=1;
        wrong++;
        dangqian=2;
        
        
    }
    if(x3==1&&z1==0&&z6==0&&cishu<3)
    {
        
        [self huaxian1:_button5 btn:_button2 ];
        x3=2;
        z1=1;
        z6=1;
        wrong++;
        dangqian=3;    }
    
    
}



- (IBAction)button10:(UIButton *)sender {
    if(x1==1&&z2==0&&z4==0&&cishu<3)
    {
        
        [self huaxian2:_button1 btn:_button4 ];
        x1=3;
        wrong++;
        dangqian=4;
        z2=1;
        z4=1;
    }
    if(x2==1&&z2==0&&z5==0&&cishu<3)
    {
        
        [self huaxian2:_button3 btn:_button4 ];
        x2=3;
        right++;
        dangqian=5;
        z2=1;
        z5=1;
        
    }
    if(x3==1&&z2==0&&z6==0&&cishu<3)
    {
        
        [self huaxian2:_button5 btn:_button4 ];
        x3=3;
        wrong++;
        dangqian=6;
        z2=1;
        z6=1;
    }
    
    
}



- (IBAction)button12:(UIButton *)sender {
    if(x1==1&&z3==0&&z4==0&&cishu<3)
    {
        
        [self huaxian3:_button1 btn:_button6 ];
        x1=4;
        wrong++;
        dangqian=7;
        z3=1;
        z4=1;
    }
    
    if(x2==1&&z3==0&&z5==0&&cishu<3)
    {
        
        [self huaxian3:_button3 btn:_button6 ];
        x2=4;
        wrong++;
        dangqian=8;
        z3=1;
        z5=1;
    }
    
    if(x3==1&&z3==0&&z6==0&&cishu<3)
    {
        
        [self huaxian3:_button5 btn:_button6 ];
        x3=4;
        right++;
        dangqian=9;
        z3=1;
        z6=1;
        
        //  CGContextClearRect(UIGraphicsGetCurrentContext(),self.view.frame);
    }
    
}

-(void) huaxian1:(UIButton *)btn1 btn:(UIButton *)btn2 {
    
    imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:imageView];
    self.view.backgroundColor=[UIColor whiteColor];
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),btn1.frame.origin.x+242,btn1.frame.origin.y+35);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), btn2.frame.origin.x-5, btn2.frame.origin.y+35);
    //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cishu++;
}

-(void) huaxian2:(UIButton *)btn1 btn:(UIButton *)btn2 {
    //NSMutableArray *array=[[NSMutableArray alloc]init];
    // for(int index=0;index<10;index++)
    imageView1=[[UIImageView alloc] initWithFrame:self.view.frame];
    // [array addObject:imageView];
    
    [self.view addSubview:imageView1];
    self.view.backgroundColor=[UIColor whiteColor];
    UIGraphicsBeginImageContext(imageView1.frame.size);
    [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),btn1.frame.origin.x+242,btn1.frame.origin.y+35);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), btn2.frame.origin.x-5, btn2.frame.origin.y+35);
    //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView1.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cishu++;
}
-(void) huaxian3:(UIButton *)btn1 btn:(UIButton *)btn2 {
    //NSMutableArray *array=[[NSMutableArray alloc]init];
    // for(int index=0;index<10;index++)
    imageView2=[[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:imageView2];
    self.view.backgroundColor=[UIColor whiteColor];
    UIGraphicsBeginImageContext(imageView2.frame.size);
    [imageView2.image drawInRect:CGRectMake(0, 0, imageView2.frame.size.width, imageView2.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),btn1.frame.origin.x+242,btn1.frame.origin.y+35);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), btn2.frame.origin.x-5, btn2.frame.origin.y+35);
    //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView2.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cishu++;
}
- (IBAction)qingchu:(UIButton *)sender {
    [self deleteLine];
    
    
}
- (void)deleteLine {
    
    [self.view addSubview:imageView];
    CGContextClearRect(UIGraphicsGetCurrentContext(),self.view.frame);
    [imageView removeFromSuperview];
    [self.view addSubview:imageView1];
    CGContextClearRect(UIGraphicsGetCurrentContext(),self.view.frame);
    [imageView1 removeFromSuperview];
    [self.view addSubview:imageView2];
    CGContextClearRect(UIGraphicsGetCurrentContext(),self.view.frame);
    [imageView2 removeFromSuperview];
    x1=0;x2=0;x3=0;z1=0;z2=0;z3=0;z4=0;z5=0;z6=0;
    cishu=0;right=0;wrong=0;tiaozhuan1=0;tiaozhuan2=0;tiaozhuan3=0; dangqian=0;
    
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(tiaozhuan1==1) {if(buttonIndex==0) {[self nextpage1];[self deleteLine];}}
    if(tiaozhuan3==1){if(buttonIndex==0) {[self nextpage2];[self deleteLine];}}
    if (exitline == 1) {//如果强行退出
        if(buttonIndex==0){
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            GameChoice *gamechoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameChoice"];
            gamechoice.user = userLine;;
            [gamechoice setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:gamechoice animated:YES completion:nil];
            [self deleteLine];
        }
    }
}




- (IBAction)tijiao:(UIButton *)sender {
    userLine.answerTimes ++;
    gameLine.line.answerTimes++;
    if(right==3)
    { [self promptLine1:@"恭喜你，闯关成功！"];tiaozhuan1=1;
        if(gameLine.gameId%2==0) userLine.golden=userLine.golden+2;
        if(gameLine.gameId%2==1) userLine.golden=userLine.golden+1;
        userLine.answerRightTimes++;
        gameLine.line.rightTimes++;
        NSLog(@"golden:%d", userLine.golden);
    }
    
    else if((right<3&&wrong==0)||(right==0&&wrong<3))
    { [self promptLine3:@"你还没有答完题答题哟！"];tiaozhuan2=1;}
    else if((right+wrong==3)&&right<3)
    { [self promptLine2:@"很抱歉，答错了！去看看通关秘籍吧！"];tiaozhuan3=1;}
    [UserDao updateUser:userLine];
    [GameDao updateLine:gameLine.line];
}

- (IBAction)gotoLineCheat:(id)sender {//直接跳转到通关秘籍
    [self nextpage2];
    [self deleteLine];
}

//左滑退出
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        exitline = 1;
        [self prompt2:@"退出游戏将会失去本关的游戏币哟！"];
    }
}




@end