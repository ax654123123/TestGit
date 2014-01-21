//
//  DetailsViewController.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-3.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "DetailsViewController.h"
#import "ListViewController.h"
#import "HJManagedImageV.h"
#import "HJImageUtility.h"
#import "PlaceOrderView.h"
#import "RiLiViewController.h"
#import "WebViewViewController.h"
#import "LoginHomeViewController.h"


#define XuZhiTAG  111
#define RecallTAG 222
#define bookingTAG 333

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize scrollView = _scrollView;
@synthesize firstTopView = _firstTopView;
@synthesize secondDownView = _secondDownView;
@synthesize tableView = _tableView;
@synthesize placOrder = _placOrder;
@synthesize alinkId = _alinkId;
@synthesize timeArrary = _timeArrary;
@synthesize dicDetaile = _dicDetaile;
@synthesize textView = _textView;
@synthesize isSearchInto ;
@synthesize textView1 = _textView1;
#pragma mark - 初始化控件

- (UIScrollView*)scrollView
{
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height - 28-44)];
        _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(0, (self.view.frame.size.height - 44 -28)*2);
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_name_bg.png"]];
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 107);
        [_scrollView addSubview:imageView];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 44)];
        lable.backgroundColor = [UIColor clearColor];
        lable.textColor = [UIColor whiteColor];
        lable.textAlignment = 1;
        lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        lable.text = @"<北京双高铁5日游>居庸关四星古客栈，亲子游更优惠";
        [imageView addSubview:lable];

        UIButton* button = [UIButton buttonWithType:0];
        button.frame = CGRectMake( 248, 46, 255, 42);
        [button setBackgroundImage:[UIImage imageNamed:@"booking_confirm_button_bg.png"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"2258 元/人起" forState:UIControlStateNormal];
        [imageView addSubview:button];
        
//        UIButton* imagebutton = [UIButton buttonWithType:0];
//        imagebutton.frame = CGRectMake( 20, 55, 41, 41);
//        [imagebutton setBackgroundImage:[UIImage imageNamed:@"detail_faved_button.png"] forState:UIControlStateNormal];
//        [imageView addSubview:imagebutton];
        
    }
    return _scrollView;
}
- (UIView*)firstTopView
{
    if (_firstTopView == nil) {
        
        _firstTopView = [[UIView alloc] initWithFrame:CGRectMake(14, 120, self.view.frame.size.width-28, self.view.frame.size.height-44-28-120)];
        _firstTopView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:240.0/255.0 blue:235.0/255.0 alpha:1.0];
        _firstTopView.userInteractionEnabled = YES;
        
        
    }
    return _firstTopView;
}
- (UIView*)secondDownView
{
    if (_secondDownView == nil) {
        
        _secondDownView = [[UIView alloc] initWithFrame:CGRectMake(14, 0, self.view.frame.size.width-28, self.view.frame.size.height-44-28 + 120)];
        _secondDownView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:240.0/255.0 blue:235.0/255.0 alpha:1.0];
        
        
        
    }
    return _secondDownView;
}
- (PlaceOrderView*)placOrder
{
    if (_placOrder == nil) {
        
        _placOrder = [[PlaceOrderView alloc] init];
        _placOrder.backgroundColor = [UIColor clearColor];
        
        _placOrder.alpha = 0;
        _placOrder.bookView.clipsToBounds = YES;
       
        
    }
    return _placOrder;
}
#pragma mark - button 响应事件
- (void)GoBack:(id)sender
{
    [self.titleView quxiaoyemian];
    if (self.isSearchInto) {
        [self dismissModalViewControllerAnimated:YES];
    }else{

        if ([[self.navigationController.viewControllers objectAtIndex:2] isKindOfClass:[ListViewController class]]) {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
        }else{
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }
    }
    
}
- (void)nextDetaileViewController:(UIButton*)button
{
    DetailsViewController* detaile = [[DetailsViewController alloc] init];
    [self.navigationController pushViewController:detaile animated:YES];

}
//int numberpress = 0;
- (void)lijiyuding:(UIButton*)button
{
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    self.placOrder.alpha = 1;
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:1.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.placOrder cache:YES];//oglFlip, fromLeft
    [UIView commitAnimations];

    
}
- (void)pressButtonView:(UIButton*)button
{
    if (button.tag == XuZhiTAG) {
        
        
        
    }else if (button.tag == RecallTAG) {
        
        
        
    }else if (button.tag == bookingTAG) {
        
//        [self lijiyuding:button];
		if ([Global shared].sessionid != nil && ![[Global shared].sessionid isEqualToString:@""]) {
			WebViewViewController *detail = [[WebViewViewController alloc] init];
			NSString *strUrl = [NSString stringWithFormat:@"%@teamcode=%@&sessionid=%@",TEST_URL,[Global shared].jzluid,[Global shared].sessionid];
			detail.htmlString = strUrl;
			[self.navigationController pushViewController:detail animated:YES];
		}else {
			UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先登陆再预订" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
			ale.tag = 123123;
			[ale show];
		}


        
    }

}
- (void)huidioafangfa
{
	if ([Global shared].sessionid != nil && ![[Global shared].sessionid isEqualToString:@""]) {
		WebViewViewController *detail = [[WebViewViewController alloc] init];
		NSString *strUrl = [NSString stringWithFormat:@"%@teamcode=%@&sessionid=%@",TEST_URL,[Global shared].jzluid,[Global shared].sessionid];
		detail.htmlString = strUrl;
		[self.navigationController pushViewController:detail animated:YES];
	}
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag == 123123) {
		
		if (buttonIndex == 0) {
			LoginHomeViewController *longin = [[LoginHomeViewController alloc] init];
			longin.isPopToHome = YES;
			longin.delegate = self;
			[self.navigationController pushViewController:longin animated:YES];
		}
		
	}
}
- (void)showRiLi:(id)sender
{
    //    [self setAlertViewTitle:@"此功能尚未开发" queding:@"取消" quxiao:nil];
    //    numberpress ++;
    //    if (numberpress%2 == 1) {
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    //    }else if (numberpress%2 == 0){
    //    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    //    }
    self.placOrder.alpha = 1;
    
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:1.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.placOrder cache:YES];//oglFlip, fromLeft
    
    
    [UIView commitAnimations];

}
#pragma mark -  loadView
- (void)buildnav
{
    
    [self setBackButton];
//    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
//    UILabel* title_lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
//    title_lable.backgroundColor = [UIColor clearColor];
//    title_lable.text = @"当季精选";
//    title_lable.textAlignment = 1;
//    [title_lable setTextColor:[UIColor whiteColor]];
//    [title_lable setTextAlignment:UITextAlignmentCenter];
//    [title_lable setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:20]];
//    [titleView addSubview:title_lable];
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
//    UIBarButtonItem* barbutton = [[UIBarButtonItem alloc] initWithCustomView:view];
//    for (int i = 0; i < 2; i++) {
//        UIButton* button = [UIButton buttonWithType:0];
//        button.frame = CGRectMake( 55*i +20, 5, 35, 35);
//        if (i == 0) {
//            [button setBackgroundImage:[UIImage imageNamed:@"detail_ previous_button.png"] forState:UIControlStateNormal];
//        }else{
//            [button setBackgroundImage:[UIImage imageNamed:@"detail_next_button.png"] forState:UIControlStateNormal];
//        }
//        [button addTarget:self action:@selector(nextDetaileViewController:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:button];
//    }
//    self.navigationItem.rightBarButtonItem = barbutton;
//    self.navigationItem.titleView = titleView;
    SearchBar* titleView = [[SearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    self.titleView = titleView;
    self.navigationItem.titleView = titleView;

}
- (void)loadSubViewInTopView
{
    
    
    HJManagedImageV *image = [[HJManagedImageV alloc] initWithFrame:CGRectMake(0 , 0, self.firstTopView.frame.size.width , 557)];
    image.userInteractionEnabled = YES;
    self.topImage = image;
    
    [HJImageUtility queueLoadImageFromUrl:@"http://www.htyou.com//pic/photo/photo7284151595.jpg" imageView:image];
    [self.firstTopView addSubview:image];
    
//    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"delt.png"]]];
//    image.frame = CGRectMake(0 , 0, self.firstTopView.frame.size.width , 557);
//    image.userInteractionEnabled = YES;
//    [self.firstTopView addSubview:image];
    
    
    UIImageView *lineimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"detail_information_dot_line.png"]]];
    lineimage.frame = CGRectMake(15 , 557 + 20, self.firstTopView.frame.size.width - 30, 4);
    [self.firstTopView addSubview:lineimage];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0 , 557 + 30, 534, 218)];
    textView.backgroundColor = [UIColor clearColor];
    textView.showsVerticalScrollIndicator = NO;
    textView.delegate = self;
    self.jieshaotextView = textView;
    [self.firstTopView addSubview:textView];
    
//    UIImageView *jieshaoimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"jieshao.png"]]];
//    jieshaoimage.frame = CGRectMake(0 , 557 + 30, 534, 218);
//    [self.firstTopView addSubview:jieshaoimage];
    
    
//    UIButton* praisebutton = [UIButton buttonWithType:0];
//    praisebutton.frame = CGRectMake( 547, 557 + 30, 85, 76);
//    [praisebutton setBackgroundImage:[UIImage imageNamed:@"detail_praise"] forState:UIControlStateNormal];
//    [praisebutton setTitle:@"93%" forState:UIControlStateNormal];
//    praisebutton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//    [praisebutton setTitleEdgeInsets:UIEdgeInsetsMake(25, 0, 0, 0)];
//    praisebutton.userInteractionEnabled = NO;
//    
//    [self.firstTopView addSubview:praisebutton];
    
//    UIButton* visit_backbutton = [UIButton buttonWithType:0];
//    visit_backbutton.frame = CGRectMake( 641, 557 + 30, 85, 76);
//    [visit_backbutton setBackgroundImage:[UIImage imageNamed:@"detail_visit_back"] forState:UIControlStateNormal];
//    [visit_backbutton setTitle:@"57" forState:UIControlStateNormal];
//    [visit_backbutton setTitleEdgeInsets:UIEdgeInsetsMake(25, 0, 0, 0)];
//    visit_backbutton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//    visit_backbutton.userInteractionEnabled = NO;
//    [self.firstTopView addSubview:visit_backbutton];
    
    UIImageView *traffic_bg_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"detail_traffic_bg.png"]]];
    traffic_bg_imageView.frame = CGRectMake(547 , 557 + 30 + 86, 180, 71);
    [self.firstTopView addSubview:traffic_bg_imageView];
    
    UIImageView *feiji1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"detail_traffic_plane"]]];
    feiji1.frame = CGRectMake(2 , 5, 60, 60);
    [traffic_bg_imageView addSubview:feiji1];
    
    UIImageView *feiji2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"detail_traffic_plane"]]];
    feiji2.frame = CGRectMake( 110, 5, 60, 60);
    [traffic_bg_imageView addSubview:feiji2];
    
    
    UIImageView *check_start_time = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"detail_check_start_time.png"]]];
    check_start_time.frame = CGRectMake(547 , 557 + 30 + 30, 180, 46);
    check_start_time.userInteractionEnabled = YES;
    [self.firstTopView addSubview:check_start_time];
    
//    UIButton *chaKanButton = [UIButton buttonWithType:0];
//    chaKanButton.frame = CGRectMake(547 , 557 + 30 + 86 +81, 180, 46);
//    [chaKanButton addTarget:self action:@selector(showRiLi:) forControlEvents:UIControlEventTouchUpInside];
//    [self.firstTopView addSubview:chaKanButton];

}
- (void)loadSubViewInDownView
{
//   UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 550 , self.view.frame.size.height - 28-44)];
//    scrollView.backgroundColor = [UIColor clearColor];
//    scrollView.scrollEnabled = NO;
//    scrollView.delegate = self;
//    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.showsHorizontalScrollIndicator = NO;
//    [self.secondDownView addSubview:scrollView];
//    
//    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"xingcheng.png"]]];
//    image.frame = CGRectMake(0 , 0, 550, 912);
//    [scrollView addSubview:image];
//    scrollView.contentSize = CGSizeMake(0, image.frame.size.height+200);
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 550 , self.view.frame.size.height - 28-44 - 50)];
    textView.backgroundColor = [UIColor clearColor];
    textView.showsVerticalScrollIndicator = NO;
    textView.delegate = self;
    self.textView = textView;
    textView.text = @"\n\n\n\n\n\n线路详情：\n\n\n第1天 长滩岛\n\n参考航班:长沙-长滩岛\n指定时间地点集合前往黄花机场,乘坐国际豪华客机前往世界排名第三、被世界旅游杂志评定为世界上最美丽的海滩，且享有“日光浴天堂”美誉的～【长滩岛】，飞机抵达后，专车接往（大约2小时）码头快艇大约15分钟即可以抵达最美丽的长滩岛，伴着点点的星光，即将开始我们精彩的行程。\n入住酒店后到次日早餐前的时间段为自由活动时间，请游客注意自身安全。用餐：无\n住宿：ALTA VISTA半山海景酒店或同级\n\n第2天 长滩岛\n\n抵达长滩岛后由专人为您办理酒店入住手续，充分的休息让您一洗旅途的劳顿。中午时分于酒店集合，岛上欢迎午餐后，导游会热情带领亲爱的贵宾探索长滩岛全长七公里白沙滩：海天一色、清静的白沙滩，水波涟涟，如诗如画。在岛上的二号码头处，有一条专卖各种纪念品的巷子，这是整个长滩岛最热闹的地方，聚集着来自世界各地的游客，最有名的就是购物街—D-MALL。走过D-mall,我们顺着沙滩往北走,大概半个小时的时间可以到长滩岛最有名的【圣母岩礁】（Willy's Rock）, 礁岩矗立海中，居民在上面供奉一尊圣母像，所以取名圣母岩礁. 退潮时，甚至可从沙滩走到礁岩。也因为圣母岩礁位于海中，能清楚眺望整片白沙海滩，以及清澈见底的汪洋，绝佳的地理位置，是游客拍照留念的好地方。最后前往西北海岸“伊里岸海滩”，又名【星期五海滩】，此处乃是长滩岛沙质最细、最柔、最白、最美沙滩地段，当地人称为「粉末沙」Powder Sand，当其细白沙藏在透明清澈海水里，形成牛乳状粉细，游泳戏水岸边，就像漫步于牛乳湖的享受，傍晚时分来到长滩岛的标志性沙雕，并可亲自来个沙滩堆沙，堆城堡发挥您艺术的想象力或您可悠闲躺在椰林沙滩下，享受海天一色、碧海蓝天的海景或漫步在美丽宁静的白色沙滩上，看夕阳西下，美不胜收。【沙雕】成为近年长滩岛的商标，长滩上不难发现高超作品。\n傍晚是长滩岛最美也是最适合活动的时候，最美的落日景观，色彩变幻璀璨美丽，黄昏时分，可自费【风帆出海看日落】：看着夕阳缓缓下沉到海平面，金黄色的阳光洒在水面上，真希望时间能就此停止。加上椰子树和船只的剪影，此时是长滩岛街道沸腾时光，从1号码头到3好码头之间，各家饭店酒馆无不使尽绝招好吸引客人上门。现场表演天天有，让你舍不得只在一家坐太久。\n入住酒店后到次日早餐前的时间段为自由活动时间，请游客注意自身安全。\n用餐：早中\n住宿：ALTA VISTA半山海景酒店或同级\n\n第3天 长滩岛\n\n长滩岛—自由活动—长滩岛\n（推荐自费：长滩岛出海游、水上活动、全装备气瓶潜水、海底漫步、热力推荐\nTRINITY SPA至尊黄金6合1、LAVA STONE能量火山热石SPA）\n1、长滩出海游：早餐后，搭乘由导游特地安排的螃蟹船出海，来一趟海上巡礼。接着来趟海上垂钓之旅，在此您将成为钓鱼高手，因为鱼量实在太多，会让您不由自主的钦佩自己钓技高超。而后转往「鳄鱼岛」旁边的「珊瑚花园」浮潜，海中珊瑚铺满海底，在透明的海水中，你可以和色彩斑斓品种多样的热带鱼一起遨游，这是另一个世界。旁边的鳄鱼岛如同一条超级大鳄鱼一样栩栩如生，您不禁会赞叹上帝的造化。近午，前往景致优美的海湾，享受精心为您安排独具风味的海鲜烧烤BAR.B.Q盛会 (含饮料)，在大自然美景下享用一顿别具风格的海岛午餐。餐毕前往水上乐园俱乐部(自费参加所需项目)，这里有丰富的水上项目，价格合理公道。\n2、【BANANA香蕉船】这是海上活动最经典也是最普遍的项目，更是许多人出国必玩的活动之一，不用高超的技术、不用过人的胆识，只要带着超HIGH的心情就可以啦。其它水上项目如水上摩托、拖曳伞、飞鱼等应有尽有。\n3、如果浮潜活动您觉得还不够尽兴，想近距离接触那些美丽的珊瑚和热带鱼，不要紧，我们会给您安排让您既兴奋又刺激的【全装备气瓶潜水】或轻松悠哉的【海底漫步】自费活动，绝对会让您意犹未尽，零距离的感觉！深海处有各式各样的海洋生物，因此愈来愈多潜水运动爱好者都被吸引前来探索海底的宝藏，长滩岛有先进完善的潜水设备，不管您是否会潜水，都不用担心，因为我们聘有专业潜水导师及导游为您提供培训和服务。更设有其它水上活动设施、包括滑水、冲浪、滑浪风帆、水面滑翔，、环岛飞行等等，应有尽有。\n4、若想身心放松，您可以自费选择体验亚洲非常有名的【TRINITY SPA至尊黄\n金6合1】或【LAVASTONE能量火山热石SPA】：其特有的秘制配方去角质、\n金铂精油按摩、菲律宾特色诺丽果汁，一定会让您欢心而去，满意而归。\n入住酒店后到次日早餐前的时间段为自由活动时间，请游客注意自身安全。\n用餐：早\n住宿：ALTA VISTA半山海景酒店或同级\n\n第4天 长滩岛\n\n今日享受没有MORING CALL的早晨，在饭店中享受早餐后，在四公里细白沙滩上漫步，蓝天碧海加上原始风光，白沙滩、阳光及清澈海景，诗情画意美景。 可选择轻松自在的享受饭店设施，或亦可参加户外休闲自费活动。可自费参加导游安排刺激的【ATV沙滩摩托车】带各位前往前往本岛最高点－【LUHO地标】，这是观赏整个长滩岛全貌的最佳地点，您可在此留下自己倩影。接着前往【POCK BEACH】，在这里才感觉到长滩岛的魅力，海天一线，天空和海是同一颜色。在此拍照、休息，且可在此欣赏不同风情的长滩岛，而后我们去往蝴蝶谷去参观水果蝙蝠，它的翅膀张开是比一个成人的双臂臂展还要长哦，相信一定会让你大吃一惊。\n精力充沛的你还可前往D Mall采购旅游纪念品，有各式的衣服、鞋子、纪念品、手工艺业品，个性彩绘T-SHIRT!如果对零嘴小吃有兴趣在超级市场内也可以找到具有特色的零嘴喔!也可自己安排日光浴，享用一杯长滩岛特有的芒果冰沙相信定能令您放松心情舒筋活骨一番。夜晚降临，长滩岛的璀璨灯光又会亮起，此时您和您的伴侣自费用一餐浪漫的【长滩岛沙滩BBQ晚餐】，边欣赏菲律宾乐队的激情表演，边品尝晚餐，不时会有菲律宾特色的火舞表演，一定会让您大吃一惊。\n晚上21:00后，是属于PUB的时间，COCO MANGAS是长滩岛最有有名的酒吧，酒吧有一种特色文化，叫做15杯----就是15种酒类各一杯，如果您一口气喝光还有神秘礼物哦！\n入住酒店后到次日早餐前的时间段为自由活动时间，请游客注意自身安全。\n用餐：早\n住宿：ALTA VISTA半山海景酒店或同级\n\n第5天 长沙\n\n参考航班:长滩岛-长沙\n经过了一夜的疯狂，导游贴心的帮您准备一个没有Morning Call的早晨，您可以悠闲地躺在沙滩的躺椅上做个日光浴悠闲的享受海天一色的美景。或在D-MALL再次搜刮一番，为家人朋友捎带心仪的特色礼品和特产。于指定时间，整理好行装后，让我们向美丽的长滩岛说”我一定要回来”，随后我们依依不舍的前往机场，办理出境手续，戴着满意的收获与回忆返回长沙！\n用餐：早\n住宿：无 ";
    
    [self.secondDownView addSubview:textView];
    
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, textView.frame.size.height , textView.frame.size.width, 140)];
    [self.secondDownView addSubview:buttonView];
    
//    UIButton *buttonXuZhi = [UIButton buttonWithType:0];
//    buttonXuZhi.frame = CGRectMake(10, 10, 255, 46);
//    [buttonXuZhi setBackgroundImage:[UIImage imageNamed:@"detail_attention_button_bg.png"] forState:UIControlStateNormal];
//    [buttonXuZhi addTarget:self action:@selector(pressButtonView:) forControlEvents:UIControlEventTouchUpInside];
//    buttonXuZhi.tag = XuZhiTAG;
//    [buttonView addSubview:buttonXuZhi];
    
//    UIButton *buttonRecall = [UIButton buttonWithType:0];
//    buttonRecall.frame = CGRectMake(275, 10, 255, 46);
//    [buttonRecall setBackgroundImage:[UIImage imageNamed:@"detail_recall_button_bg.png"] forState:UIControlStateNormal];
//    [buttonRecall addTarget:self action:@selector(pressButtonView:) forControlEvents:UIControlEventTouchUpInside];
//    buttonRecall.tag = RecallTAG;
//    [buttonView addSubview:buttonRecall];
    UITextView *textView1 = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 519, 46)];
    textView1.backgroundColor = [UIColor clearColor];
    textView1.showsVerticalScrollIndicator = NO;
    textView1.delegate = self;
    textView1.font = [UIFont systemFontOfSize:14];
//    textView1.text = [NSString stringWithFormat:@"%@\n%@", [self.dicDetaile objectForKey:@"Important"],[self.dicDetaile objectForKey:@"noImportant"]];
    self.textView1 = textView1;
    [buttonView addSubview:textView1];
    
    UIButton *buttonbooking = [UIButton buttonWithType:0];
    buttonbooking.frame = CGRectMake(10, 56, 519, 54);
    [buttonbooking setBackgroundImage:[UIImage imageNamed:@"detail_second_booking_button_bg.png"] forState:UIControlStateNormal];
    [buttonbooking addTarget:self action:@selector(pressButtonView:) forControlEvents:UIControlEventTouchUpInside];
    [buttonbooking setTitle:@"立即预订" forState:UIControlStateNormal];
    [buttonbooking setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonbooking.tag = bookingTAG;
    [buttonView addSubview:buttonbooking];
    
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(535, 80, 205 , self.view.frame.size.height - 28-44 + 120)];
    sc.backgroundColor = [UIColor clearColor];
    sc.showsVerticalScrollIndicator = NO;
    sc.showsHorizontalScrollIndicator = NO;
    sc.contentSize = CGSizeMake(0, (self.view.frame.size.height - 44 -28)*2);
    [self.secondDownView addSubview:sc];
    
    for (int i = 0; i < 2; i ++) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"menu%d.jpg",i%3+1 ]]];
        image.frame = CGRectMake(10 , 180*i +10, 180, 140);
        image.backgroundColor = [UIColor lightGrayColor];
        image.userInteractionEnabled = YES;
        [sc addSubview:image];
        if (i == 0) {
            image.image = [UIImage imageNamed:@"ipad-(3)"];
        }else {
           image.image = [UIImage imageNamed:@"ipad-(4)"];
        }
        
        UIButton *button = [UIButton buttonWithType:0];
        [button addTarget:self action:@selector(youcetupianpress:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        button.frame = CGRectMake(0, 0, 180, 140);
        [image addSubview:button];

    }
    
}
- (void)youcetupianpress:(id)sender
{
    UIButton* button = (UIButton*)sender;
    WebViewViewController *detail = [[WebViewViewController alloc] init];
    if (button.tag == 0) {
        detail.htmlString = LIFTTUIJIAN_URL;
    } else if (button.tag == 1) {
        detail.htmlString = RIGHTTUIJIAN_URL;
    }
    [self.navigationController pushViewController:detail animated:YES];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;

}
#pragma mark -  系统fangfa
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];
    
    

    
//    [self.scrollView addSubview:self.firstTopView];
//    [self.scrollView addSubview:self.secondDownView];
//    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.placOrder];
    [self buildnav];
    [self loadSubViewInTopView];
    [self loadSubViewInDownView];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-15) style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.pagingEnabled = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:240.0/255.0 blue:235.0/255.0 alpha:1.0];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setValue:self.alinkId forKey:@"lineid"];
    [TXASIHttp ytxASIHTTPRequest:@"ipad_queryTourTeam.action" viewController:self parm:parm];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    self.secondDownView = nil;
    self.firstTopView = nil;
    self.scrollView = nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
//    if (scrollView.contentSize.height  < scrollView.contentOffset.y + self.view.frame.size.height - 28-44) {
//        scrollView.scrollEnabled = NO;
//    }else if (scrollView.contentOffset.y < 0){
//        
//    scrollView.scrollEnabled = NO;
//    
//    }else{
//    scrollView.scrollEnabled = YES;
//    }
}
#pragma mark tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
        return 2;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellheight = self.view.frame.size.height - 28-44;
    
    if (indexPath.row == 0) {
        return cellheight;
    }else
    return cellheight + 120;
}

- (void)buildCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row == 0) {
        
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_name_bg.png"]];
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 107);
        imageView.userInteractionEnabled = YES;
        [cell addSubview:imageView];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 44)];
        lable.backgroundColor = [UIColor clearColor];
        lable.textColor = [UIColor whiteColor];
        lable.textAlignment = 1;
        lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        lable.text = @"<北京双高铁5日游>居庸关四星古客栈，亲子游更优惠";
        lable.tag = 123;
        [imageView addSubview:lable];
        
        UIButton* button = [UIButton buttonWithType:0];
        button.frame = CGRectMake( 248, 46, 255, 42);
        [button setBackgroundImage:[UIImage imageNamed:@"booking_confirm_button_bg.png"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = 1234;
        [button setTitle:@"2258 元/人起" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(lijiyuding:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        
//        UIButton* imagebutton = [UIButton buttonWithType:0];
//        imagebutton.frame = CGRectMake( 20, 55, 41, 41);
//        [imagebutton setBackgroundImage:[UIImage imageNamed:@"detail_faved_button.png"] forState:UIControlStateNormal];
//        [imageView addSubview:imagebutton];
        

        
        [cell addSubview:self.firstTopView];
        
        UIButton *chaKanButton = [UIButton buttonWithType:0];
        chaKanButton.frame = CGRectMake(547 , 557 + 30 + 86 +51, 180, 80);
        [chaKanButton addTarget:self action:@selector(showRiLi:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:chaKanButton];
    }else {
    
        [cell addSubview:self.secondDownView];
        
    }
    
}
- (void)onClickcell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath
{
   UILabel *lable =(UILabel*) [cell viewWithTag:123];
    lable.text = [self.dicDetaile objectForKey:@"tourproname"];
   UIButton *button = (UIButton*)[cell viewWithTag:1234];

    [button setTitle:[NSString stringWithFormat:@"%@ 元/人起",[self.dicDetaile objectForKey:@"adultprice"]] forState:UIControlStateNormal];

//    if (indexPath.row == 0) {
//        [cell addSubview:self.firstTopView];
//    }else {   
//        [cell addSubview:self.secondDownView];
//    }
    
}
- (UITableViewCell*)contructRow:(UITableView*)tableview indexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifierSection = @"contructRow";
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifierSection];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierSection];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_bg"]];//[UIImage imageNamed:@"home_bg"]];
        [self buildCell:cell indexPath:indexPath];
    }
    [self onClickcell:cell indexPath:indexPath];
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell =nil;
    cell = [self contructRow:tableView indexPath:indexPath];
    
    return cell;
}
#pragma mark - 详情view 蛋疼。
- (void)buildOneViewInTheDown:(NSDictionary*)dic number:(int)i
{
    
    
   NSString *str = [NSString stringWithFormat:@"%@", [[[dic objectForKey:@"value1"] objectAtIndex:i] objectForKey:@"journeycontent"]];
    CGSize labelSize = [str sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(786, 1024) lineBreakMode:NSLineBreakByWordWrapping];
    
    UIView *view = [[UIView alloc] init];
    UILabel *dijitian_lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 44)];
    dijitian_lable.backgroundColor = [UIColor clearColor];
    dijitian_lable.textColor = [UIColor greenColor];
    dijitian_lable.textAlignment = 1;
    dijitian_lable.text = [NSString stringWithFormat:@"    第%d天  %@--%@", i+1,[[[dic objectForKey:@"value1"] objectAtIndex:i] objectForKey:@"startspot"],[[[dic objectForKey:@"value1"] objectAtIndex:i] objectForKey:@"endspot"]];
    dijitian_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [view addSubview:dijitian_lable];
    
    
    UILabel *xiangqing_lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, view.frame.size.width, labelSize.height)];
    xiangqing_lable.backgroundColor = [UIColor clearColor];
    xiangqing_lable.textColor = [UIColor blackColor];
    xiangqing_lable.textAlignment = 0;
    xiangqing_lable.text = str;
    xiangqing_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [view addSubview:xiangqing_lable];
    
    UILabel *baikuang_lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 80 + labelSize.height, view.frame.size.width, 20)];
    baikuang_lable.backgroundColor = [UIColor whiteColor];
    baikuang_lable.textColor = [UIColor blackColor];
    baikuang_lable.textAlignment = 1;
    baikuang_lable.text = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"value1"] objectAtIndex:i] objectForKey:@"dinner"]];
    baikuang_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [view addSubview:baikuang_lable];
    
    UILabel *baikuang_lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 120 + labelSize.height, view.frame.size.width, 20)];
    baikuang_lable1.backgroundColor = [UIColor whiteColor];
    baikuang_lable1.textColor = [UIColor blackColor];
    baikuang_lable1.textAlignment = 1;
    baikuang_lable1.text = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"value1"] objectAtIndex:i] objectForKey:@"hotel"]];
    baikuang_lable1.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [view addSubview:baikuang_lable1];
    
    view.frame = CGRectMake(0, (120 + labelSize.height)*i + 30, self.textView.frame.size.width, (120 + labelSize.height)*i );
    [self.secondDownView addSubview:view];
    
}
#pragma mark - ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSDictionary *dic =  [TXASIHttp requestJson:request];
     [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"ASIHTTPRequest-----------%@",dic);
    if ([[dic objectForKey:@"status"] isEqualToString:@"1"]) {
        
        
        if (![[dic objectForKey:@"value"] isKindOfClass:[NSArray class]]) {
            
            self.dicDetaile = [dic objectForKey:@"value"];
            [self.tableView reloadData];
            [Global shared].jzluid = [self.dicDetaile objectForKey:@"jzluid"];
            
            NSString *booknotes = [self.dicDetaile objectForKey:@"booknotes"];
            self.jieshaotextView.text = [NSString stringWithFormat:@"线路介绍：\n%@",booknotes];
            
            self.placOrder.detileTitleLable.text = [self.dicDetaile objectForKey:@"tourproname"];
            NSString *Important = [[dic objectForKey:@"value"] objectForKey:@"important"];
            NSString *noImportant = [self.dicDetaile objectForKey:@"noImportant"];
            
            if ([Important isEqualToString:@""] && Important == nil) {
                Important = @"";
            }
            if ([noImportant isEqualToString:@""] && noImportant == nil) {
                noImportant = @"";
            }
//            self.textView1.text = [NSString stringWithFormat:@"%@\n%@", Important,noImportant];;
            
            NSMutableString *mutablestring = [[NSMutableString alloc] init];
            for (int i = 0; i < [[dic objectForKey:@"value1"] count]; i++) {
                
//                [self buildOneViewInTheDown:dic number:i];
                
                [mutablestring appendString:[NSString stringWithFormat:@"\n\n第%d天  %@--%@", i+1,[[[dic objectForKey:@"value1"] objectAtIndex:i] objectForKey:@"startspot"],[[[dic objectForKey:@"value1"] objectAtIndex:i] objectForKey:@"endspot"]]];
                
                [mutablestring appendString:[NSString stringWithFormat:@"\n\n\n%@", [[[dic objectForKey:@"value1"] objectAtIndex:i] objectForKey:@"journeycontent"]]];
//                dinner
//                hotel
            }
            
            
            [mutablestring appendString:[NSString stringWithFormat:@"\n\n%@\n%@", Important,noImportant]];
            

            NSString *str = [NSString stringWithFormat:@"\n\n\n\n\n\n线路详情：%@",mutablestring];
            if (![str isEqualToString:@""] && str != nil) {
                self.textView.text = str;
            }
            
            
            NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
            [parm setValue:self.alinkId forKey:@"lineid"];
//            [parm setValue:@"5078" forKey:@"lineid"];
            
            [TXASIHttp ytxASIHTTPRequest:@"ipad_queryTourAblums.action" viewController:self parm:parm];
        }else{
            
            if ([[[dic objectForKey:@"value"] objectAtIndex:0] objectForKey:@"seq"]) {
               
                NSString *pic =  [[[dic objectForKey:@"value"] objectAtIndex:0] objectForKey:@"pic"];
                [HJImageUtility queueLoadImageFromUrl:[NSString stringWithFormat:@"http://ipad.htyou.com/%@",pic] imageView:self.topImage
                 ];

                
            }else{
                NSString *time = [[[dic objectForKey:@"value"] objectAtIndex:0] objectForKey:@"tourdate"];
                
                NSMutableArray *dateArrary = [NSMutableArray arrayWithCapacity:0];
                NSMutableArray *priceArrary = [NSMutableArray arrayWithCapacity:0];
                NSMutableArray *yuliuArrary = [[NSMutableArray alloc] init];
                for (int i = 0; i < [[dic objectForKey:@"value"] count]; i ++) {
                    
                    [dateArrary addObject:[[[dic objectForKey:@"value"] objectAtIndex:i] objectForKey:@"tourdate"]];
                    [priceArrary addObject:[[[dic objectForKey:@"value"] objectAtIndex:i] objectForKey:@"adultprice "]];
                    [yuliuArrary addObject:[[[dic objectForKey:@"value"] objectAtIndex:i] objectForKey:@"haveqty "]];
                }
                
                TuNiuIpadAppDelegate *delegate = (TuNiuIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
                delegate.dateArrary = dateArrary;
                delegate.priceArrary = priceArrary;
                delegate.yuliuArrary = yuliuArrary;
                
                RiLiViewController *viewcon = [[RiLiViewController alloc] initWithNibName:@"RiLiViewController" bundle:nil];
                viewcon.delegate =self;
                viewcon.view.frame = CGRectMake(0, 50, 500, 300);
                [_placOrder.bookView addSubview:viewcon.view];
                [Global shared].riliviewcontroller = viewcon;
                
                
                
                self.timeArrary = [dic objectForKey:@"value"];
                NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
                [parm setValue:self.alinkId forKey:@"lineid"];
                [parm setValue:time forKey:@"tourdate"];
//                [parm setValue:@"5078" forKey:@"lineid"];
//                [parm setValue:@"2013-11-20" forKey:@"tourdate"];

                [TXASIHttp ytxASIHTTPRequest:@"ipad_getTourTeam.action" viewController:self parm:parm];
            }
        }
    }else {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"线路不存在";
//        [hud hide:YES afterDelay:2];
    }
    
   
}

- (void)requestFailed:(ASIHTTPRequest *)request

{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    hud.labelText = @"网络请求失败";
    hud.mode = MBProgressHUDModeText;
    
    [hud hide:YES afterDelay:2];
    
}
#pragma mark - RiLiViewControllerDelegate
- (void)dianjitilipush:(NSDate*)date
{
    [self.placOrder zhixing];
    
//    WebViewViewController *detail = [[WebViewViewController alloc] init];
//    NSString *strUrl = [NSString stringWithFormat:@"%@teamcode=%@&sessionid=%@",TEST_URL,[Global shared].jzluid,[Global shared].sessionid];
//    detail.htmlString = strUrl;
//    [self.navigationController pushViewController:detail animated:YES];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    [parm setValue:self.alinkId forKey:@"lineid"];
    [parm setValue:[[[dateFormatter stringFromDate:date] componentsSeparatedByString:@" "] objectAtIndex:0] forKey:@"tourdate"];
    //                [parm setValue:@"5078" forKey:@"lineid"];
    //                [parm setValue:@"2013-11-20" forKey:@"tourdate"];
    
    [TXASIHttp ytxASIHTTPRequest:@"ipad_getTourTeam.action" viewController:self parm:parm];

}
@end
