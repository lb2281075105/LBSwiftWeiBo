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
let itemMargin : CGFloat = 10
class LBHomeTableVCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelWCons: NSLayoutConstraint!
    
    @IBOutlet weak var picCollectionView: LBImageCollectionView!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置微博正文的宽度约束
        contentLabelWCons.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        // 流水布局,设置单元格的大小
        let layout = picCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
    }
    var viewModel : LBHStatusViewModel? {
        didSet {
            // nil值校验
            guard let viewModel = viewModel else {
                return
            }
            // 用户头像nil验证
            guard let profile_url = viewModel.profileURL else {
                return;
            }
            // 设置头像
            iconView.sd_setImage(with: profile_url as URL, placeholderImage: UIImage(named: "avatar_default_small"))
            
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
            
            // 计算picView的宽度和高度的约束
            let picViewSize = calculatePicViewSize(count: viewModel.picURLs.count)
            picViewWCons.constant = picViewSize.width
            picViewHCons.constant = picViewSize.height
            
            picCollectionView.picURLs = viewModel.picURLs
        }
    }

}
extension LBHomeTableVCell {
    func calculatePicViewSize(count : Int) -> CGSize {
        // 没有配图
        if count == 0 {
            return CGSize.zero
        }
        
        // 计算出来imageViewWH
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
        
        // 四张配图
        if count == 4 {
            let picViewWH = imageViewWH * 2 + itemMargin
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        // 其他张配图
        // 计算行数
        let rows = CGFloat((count - 1) / 3 + 1)
        
        // 计算picView的高度
        let picViewH = rows * imageViewWH + (rows - 1) * itemMargin
        
        // 计算picView的宽度
        let picViewW = UIScreen.main.bounds.width - 2 * edgeMargin
        
        return CGSize(width: picViewW, height: picViewH)
    }
}

