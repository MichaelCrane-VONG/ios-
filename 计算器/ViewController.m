//
//  ViewController.m
//  计算器
//
//  Created by myApple on 15/12/26.
//  Copyright © 2015年 myApple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *btnArray;
    NSArray *arr;
    UILabel *label;
    float btnWidth,screenHeight,screenWidth;
    int flag,changeNum;
    double sum,num,num3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor blackColor];
    arr=@[@"0        ",@".",@"=",@"1",@"2",@"3",@"+",@"4",@"5",@"6",@"-",@"7",@"8",@"9",@"x",@"AC",@"+/–",@"%",@"÷"];
    changeNum=1;
    btnArray=[[NSMutableArray alloc]initWithCapacity:16];
    screenHeight=self.view.frame.size.height;
    screenWidth=self.view.frame.size.width;
    btnWidth=screenWidth/4;
    for (int i=0; i<5; i++) {
        
        for (int j=0; j<4; j++) {
             if (i==0&&j==1) {
                    continue;
            }
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            if(i==0&&j==0)
            {
                    btn.frame=CGRectMake(j*btnWidth, screenHeight-(i+1)*btnWidth, (btnWidth*2)-1, btnWidth-1);
            }
            else
            {
                    btn.frame=CGRectMake(j*btnWidth, screenHeight-(i+1)*btnWidth, btnWidth-1, btnWidth-1);
            }
            
            if(j==3)
            {
                btn.backgroundColor=[UIColor orangeColor];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else
            {
                 btn.backgroundColor=[UIColor colorWithRed:217/255.0 green:218/255.0 blue:220/255.0 alpha:1];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            btn.titleLabel.font=[UIFont fontWithName:@"Heiti SC" size:30];
            
            [btnArray addObject:btn];
            [self.view addSubview:btn];
        }
    }

    for (int i=0; i<arr.count; i++) {
        [[btnArray objectAtIndex:i] setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
    }

    label=[[UILabel alloc]initWithFrame:CGRectMake(15, self.view.frame.size.height-btnWidth*6-5, self.view.frame.size.width-15*2,btnWidth)];
    label.backgroundColor=[UIColor blackColor];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont fontWithName:@"Heiti SC" size:72];
    label.text=@"0";
    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment=NSTextAlignmentRight;

    [self.view addSubview:label];
    
    for (int i=0; i<btnArray.count; i++) {
        [[btnArray objectAtIndex:i] addTarget:self action:@selector(btnTouchDown:) forControlEvents:UIControlEventTouchDown];
         [[btnArray objectAtIndex:i] addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [[btnArray objectAtIndex:i] addTarget:self action:@selector(btnTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
  }
}

-(void)labelContent:(id)sender
{
    
}

-(void)btnTouchDown:(UIButton *)sender
{

    sender.alpha=0.8;
    if ([sender.titleLabel.text isEqualToString:[arr objectAtIndex:0]]) {
        label.text=@"0";
    }
    else if ([sender.titleLabel.text isEqualToString:@"+"]) {
        num=label.text.doubleValue;
        sum=sum+num;
        flag=1;
        changeNum=1;
    }
    else if ([sender.titleLabel.text isEqualToString:@"-"]) {
        num=label.text.doubleValue;
        if(sum==0)
        {
            sum=num;
        }
        else
        {
            sum=sum-num;
        }
        flag=2;
        changeNum=1;
    }
    else if ([sender.titleLabel.text isEqualToString:@"x"]) {
        if(sum==0)sum=1;
        num=label.text.doubleValue;
        sum=sum*num;
        flag=3;
        changeNum=1;
    }
    else  if ([sender.titleLabel.text isEqualToString:@"÷"]) {
        num=label.text.doubleValue;
        if(sum==0)
        {
            sum=num;
        }
        else
        {
            sum=sum/num;
        }
        flag=4;
        changeNum=1;
    }
    else  if ([sender.titleLabel.text isEqualToString:@"AC"]) {
        label.text=@"0";
        num=0;
        sum=0;
        changeNum=1;
       [sender setTitle:@"C" forState:UIControlStateNormal];
    }
    else  if ([sender.titleLabel.text isEqualToString:@"C"]) {
        label.text=@"0";
        num=0;
        sum=0;
        changeNum=1;
        [sender setTitle:@"AC" forState:UIControlStateNormal];
    }
    else  if ([sender.titleLabel.text isEqualToString:@"+/–"]) {
        double num4=label.text.doubleValue;
        if (num4==0) {
            num4=0;
        }
        else
        {
             num4=-num4;
        }
        label.text=[NSString stringWithFormat:@"%g",num4];
        changeNum=1;
    }
    else  if ([sender.titleLabel.text isEqualToString:@"%"]) {
        double num4=label.text.doubleValue;
        num4=num4*0.01;
        label.text=[NSString stringWithFormat:@"%g",num4];
        changeNum=1;
    }
    else if ([sender.titleLabel.text isEqualToString:@"="]) {
        
        num=label.text.doubleValue;
        NSLog(@"%g",num);
        NSLog(@"%g",sum);
        switch (flag) {
            case 0:
                sum=label.text.doubleValue;
                break;
            case 1:
                sum=sum+num;
                break;
            case 2:
                sum=sum-num;
                break;
            case 3:
                sum=sum*num;
                break;
            case 4:
                sum=sum/num;
                break;
            default:
                break;
        }
        
         NSLog(@"%g",sum);
        if (isnan(sum)||isinf(sum))
        {
            label.text=@"不是数字";
        }
        else
        {
            label.text=[NSString stringWithFormat:@"%g",sum];
        }
        
        changeNum=1;
        flag=0;
        num=0;
        sum=0;
    }
    else {
        if(changeNum!=0)
        {
            label.text=@"";
        }
        label.text= [label.text stringByAppendingString:sender.titleLabel.text];
        changeNum=0;
    }

}

-(void)btnTouchUpInside:(UIButton *)sender
{
    sender.alpha=1;
}

-(void)btnTouchUpOutside:(UIButton *)sender
{
    sender.alpha=1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
