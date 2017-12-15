//
//  LBHomeTableVCell.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/15.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit
let edgeMargin : CGFloat = 15
class LBHomeTableVCell: UITableViewCell {

    @IBOutlet weak var contentLabelWCons: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置微博正文的宽度约束
        contentLabelWCons.constant = UIScreen.main.bounds.width - 2 * edgeMargin
    }

}
