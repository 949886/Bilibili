//
//  IPadHomeViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/8.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "IPadHomeViewController.h"
#import "IPadRecHomeViewController.h"

#import "SegmentedControl.h"

#import "extension.h"
#import "models.h"
#import "BilibiliAPI.h"

@import YYKit;
@import ReactiveObjC;

@interface IPadHomeViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) SegmentedControl * segmentedControl;

@property (nonatomic, strong) IPadRecHomeViewController * recHomeViewController;

@end

@implementation IPadHomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化NavigationBar的titleView
    SegmentedControl * segmentedControl = [[SegmentedControl alloc]initWithType:SegmentedControlTypeUnderlined];
    segmentedControl.frame = CGRectMake(0, 0, 400, 44);
    segmentedControl.index = 0;
    segmentedControl.color = [UIColor colorWithRed:1.000 green:0.329 blue:0.498 alpha:1.000];
    segmentedControl.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:16];
    segmentedControl.items = @[@"直播", @"推荐", @"番剧", @"分区"].mutableCopy;
    self.navigationItem.titleView = segmentedControl;
    self.segmentedControl = segmentedControl;
    
    [segmentedControl handleEventWithBlock:^(NSInteger index) { //监听点击
        [_scrollView setContentOffset:CGPointMake(index * _scrollView.width, 0) animated:YES];
    }];
    
    //监听ScrollView滚动
    [[_scrollView rac_valuesForKeyPath:@"contentOffset" observer:nil]subscribeNext:^(id x) {
        int page = _scrollView.contentOffset.x / _scrollView.width + 0.5;
        if(page != _segmentedControl.index)
            _segmentedControl.index = page;
    }];
    
    //Live
 
    //Recommendation
    _recHomeViewController = [IPadRecHomeViewController new];
    _recHomeViewController.view.frame = _scrollView.bounds;
    [_scrollView addSubview:_recHomeViewController.view];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Setup scrollView
    _scrollView.contentSize = CGSizeMake(_scrollView.width * 4, _scrollView.height);
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
