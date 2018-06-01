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
    // 转发微博文本
    @IBOutlet weak var retweetedContentLabel: UILabel!
    // 转发微博背景视图
    @IBOutlet weak var retweetedBgView: UIView!
    // 底部工具栏视图
    @IBOutlet weak var bottomToolView: UIView!
    // 集合视图到工具栏间距
    @IBOutlet weak var picViewBottomCons: NSLayoutConstraint!
    // 转发微博文本到原创微博文本底部的间距
    @IBOutlet weak var retweetedContentLabelTopCons: NSLayoutConstraint!
    
    // 集合视图
    @IBOutlet weak var picCollectionView: LBImageCollectionView!
    // 集合视图的高度
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    // 集合视图的宽度
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置微博正文的宽度约束
        contentLabelWCons.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        // 流水布局,设置单元格的大小
//        let layout = picCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
//        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
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
            print("哈哈 我的高度")
            print(picViewSize.height)
            picCollectionView.picURLs = viewModel.picURLs
            
            // ------------------------- mark -- 转发微博的相关信息 -----------------
            // 设置转发微博的正文
            if viewModel.status?.retweeted_status != nil {
                // 设置转发微博的正文
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name, let retweetedText = viewModel.status?.retweeted_status?.text {
                    retweetedContentLabel.text = "@" + "\(screenName): " + retweetedText
                    
                    // 设置转发正文距离顶部的约束
                    retweetedContentLabelTopCons.constant = 15
                }
                
                // 设置背景显示
//                retweetedBgView.isHidden = false
            } else {
                // 设置转发微博的正文
                retweetedContentLabel.text = nil
                
                // 设置背景显示
//                retweetedBgView.isHidden = true
                
                // 设置转发正文距离顶部的约束
                retweetedContentLabelTopCons.constant = 0
            }
            
            // 计算cell的高度
            if viewModel.cellHeight == 0 {
                // 强制布局
                layoutIfNeeded()
                
                let viewSize1 = CGSize(width: UIScreen.main.bounds.size.width - 2 * edgeMargin, height: CGFloat(MAXFLOAT))
                let viewSize2 = CGSize(width: UIScreen.main.bounds.size.width - 2 * edgeMargin, height: CGFloat(MAXFLOAT))
                let contentLabel_height = contentLabel.text?.boundingRect(with: viewSize1, options: [.usesLineFragmentOrigin], context: nil).height ?? 0
                let retweetedLabel_height = retweetedContentLabel.text?.boundingRect(with: viewSize2, options: [.usesLineFragmentOrigin], context: nil).height ?? 0
                print("北京惟易")
                print(contentLabel_height,retweetedLabel_height)
                // cellHeight -- 时间最大值maxY + 间距(15) + 微博文本的高度 + 间距(15) + 转发微博的高度 + 间距(10) + 集合视图的高度 + 间距(10) + 获取底部工具栏的maxY
                
//                viewModel.cellHeight = picCollectionView.frame.maxY + 40
                viewModel.cellHeight = timeLabel.frame.maxY + edgeMargin + contentLabel_height + retweetedLabel_height + edgeMargin + picViewSize.height + itemMargin + 40
            }
        }
        
    }
    

}
extension LBHomeTableVCell {
    func calculatePicViewSize(count : Int) -> CGSize {
        // 没有配图
        if count == 0 {
            picViewBottomCons.constant = 0
            return CGSize.zero
        }
        
        // 有配图需要改约束有值
        picViewBottomCons.constant = -10
        
        // 取出picCollectionView对应的layout
        let layout = picCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        // 单张配图
        if count == 1 {
            // 取出图片
            let urlString = viewModel?.picURLs.last?.absoluteString
            let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: urlString)

            // 设置一张图片是layout的itemSize
            layout.itemSize = CGSize(width: (image?.size.width)! * 2, height: (image?.size.height)! * 2)

            return CGSize(width: image!.size.width * 2, height: image!.size.height * 2)
        }
        
        // 计算出来imageViewWH
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
        
        // 设置其他张图片时layout的itemSize
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
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
        print("picViewH :::\(picViewH,rows,imageViewWH)")
        // 计算picView的宽度
        let picViewW = UIScreen.main.bounds.width - 2 * edgeMargin
        
        return CGSize(width: picViewW, height: picViewH)
    }
}

