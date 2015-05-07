//
//  ToolsColor.h
//  CsWeibo
//
//  Created by niuwan on 15/5/7.
//  Copyright (c) 2015年 niuwan. All rights reserved.
//

#ifndef CsWeibo_OHToolsColor_h
#define CsWeibo_OHToolsColor_h

//RGB颜色
#define OHColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
//随机色,alpha = 1
#define OHRandomColor OHColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.0)

#endif
