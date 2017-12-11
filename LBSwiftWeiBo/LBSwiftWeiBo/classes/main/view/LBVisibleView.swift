//
//  LBVisibleView.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/7.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBVisibleView: UIView {

    class func visitorView() -> LBVisibleView{
        return Bundle.main.loadNibNamed("LBVisibleView", owner: nil, options: nil)?.first as!LBVisibleView
    }

}
