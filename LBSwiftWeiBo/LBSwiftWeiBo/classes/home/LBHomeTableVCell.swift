//
//  LBHomeTableVCell.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/15.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit
import SDWebImage
let edgeMargin : CGFloat = 15
class LBHomeTableVCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelWCons: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置微博正文的宽度约束
        contentLabelWCons.constant = UIScreen.main.bounds.width - 2 * edgeMargin
    }
    var viewModel : LBHStatusViewModel? {
        didSet {
            // nil值校验
            guard let viewModel = viewModel else {
                return
            }
            
            // 设置头像
//            iconView.sd_setImage(with: viewModel.profileURL! as URL, placeholderImage: UIImage(named: "avatar_default_small"))
//            
            // 设置认证的图标
            verifiedView.image = viewModel.verifiedImage
            
            // 昵称
            screenNameLabel.text = viewModel.status?.user?.screen_name
            
            // 会员图标
            vipView.image = viewModel.vipImage
            
            // 设置时间的Label
            timeLabel.text = viewModel.createAtText
            
            // 设置来源
            contentLabel.text = viewModel.status?.text
            
            // 设置昵称的文字颜色
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black: UIColor.orange
        }
    }

}
