//
//  PFSlideViewControllers.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/16/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFSlideViews.h"
#import "PFHomeSettingsView.h"
#import "PFHomeUsersView.h"

@interface PFSlideViews () <UIScrollViewDelegate> {
    CGFloat maxX;
}

@property (nonatomic, strong) PFHomeSettingsView *homeSettingsView;
@property (nonatomic, strong) PFHomeUsersView *homeUsersView;

@property (nonatomic, strong) NSArray *arrItemViews;
@property (nonatomic, strong) NSMutableArray *arrCurrentItemViews;
@property (nonatomic, assign) int currentIndexPage;
@property (nonatomic, strong) NSMutableDictionary *dicCacheSubviews;
@end

@implementation PFSlideViews

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        
        self.pagingEnabled = YES;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.alwaysBounceHorizontal = YES;
        self.alwaysBounceVertical = YES;
        
        _arrItemViews = @[[PFHomeUsersView className], [PFHomeSettingsView className]];
        _arrCurrentItemViews = [NSMutableArray array];
        _dicCacheSubviews = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)loadItemViews{
    self.contentSize = CGSizeMake(self.frame.size.width*2, self.frame.size.height);
    maxX = self.contentSize.width - self.frame.size.width;
    
//    [self scrollRectToVisible:CGRectInset([self bounds], 10, 10) animated:NO];
    
    _homeSettingsView = [[PFHomeSettingsView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _homeSettingsView.backgroundColor = [UIColor blueColor];
    
    [_homeSettingsView loadView];
    
    _homeUsersView = [[PFHomeUsersView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _homeUsersView.backgroundColor = [UIColor yellowColor];
        
    [self addSubview:_homeUsersView];
    [self addSubview:_homeSettingsView];
}

-(void)loginCompleted{
    [_homeUsersView loadView];
}

-(void)loadSubviewsOnScrollViewByIndex:(NSArray*)indexes{
    PFView *subview;
    NSMutableArray *arrIndexesToRemove = [NSMutableArray array];
    for (NSNumber *index in indexes) {
        subview = _dicCacheSubviews[index];
        if (!subview) {
            subview = (PFView*)[[[self classForIndex:[index intValue]] alloc]init];
            [subview setFrame:CGRectMake([index intValue]*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            [subview loadView];
            [_dicCacheSubviews setObject:subview forKey:index];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > maxX) {
        [scrollView setContentOffset:CGPointMake(maxX, 0) animated:NO];
    }
    else if (scrollView.contentOffset.x < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
    if (scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0) animated:NO];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"scrollViewWillEndDragging: velocity = %@, target = %@", NSStringFromCGPoint(velocity), NSStringFromCGPoint(*targetContentOffset));
    
    if (velocity.x <= -1 && scrollView.contentOffset.x < scrollView.frame.size.width/2) {
        [[SlideNavigationController sharedInstance] openMenu:MenuLeft withCompletion:^{
            
        }];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"DidEndDragging: %d", decelerate);
    
    _currentIndexPage = (int)roundf(scrollView.contentOffset.x/scrollView.frame.size.width);
    
    NSLog(@"done, %d", _currentIndexPage);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating: %.f", scrollView.decelerationRate);
}

-(void)prepareItemViewsForCurrentIndex:(int)index{
    NSArray *arrIndexesPreparing = [self getIndexes:index];
    for (NSNumber *index in arrIndexesPreparing) {
        
    }
}

-(NSArray*)getIndexes:(int)currentIdx{
    return @[@(currentIdx-1), @(currentIdx), @(currentIdx+1)];
}

-(int)indexOfClass:(Class)class{
    if ([class isSubclassOfClass:[PFHomeSettingsView class]]) {
        return 1;
    }
    else if ([class isSubclassOfClass:[PFHomeUsersView class]]) {
        return 0;
    }
    else{
        return -1;
    }
}

-(Class)classForIndex:(int)index{
    if (index == 0) {
        return [PFHomeUsersView class];
    }
    else if (index == 1) {
        return [PFHomeSettingsView class];
    }
    else {
        return [NSNull class];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touches");
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
