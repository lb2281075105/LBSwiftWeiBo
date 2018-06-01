//
//  LBHomeTabVController.swift
//  LBSwiftWeiBo
//
//  Created by liubo on 2017/12/4.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit
import SDWebImage
class LBHomeTabVController: LBBaseTableController {
    lazy var titleBtn : LBTitleButton = LBTitleButton()
    lazy var popoverAnimator : LBPopoverAnimator = LBPopoverAnimator {[weak self] (presented) -> () in
        self?.titleBtn.isSelected = presented
    }
    lazy var viewModels : [LBHStatusViewModel] = [LBHStatusViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 没有登录时设置的内容
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        setupNavigationBar()
        // 请求数据
        loadStatuses()
        // ----------- cellHeight -----------
        // 行高自动适应
//        tableView.rowHeight = UITableViewAutomaticDimension
        // 预估行高
        tableView.estimatedRowHeight = 200

    }
}
extension LBHomeTabVController {
    func setupNavigationBar() {
        // 设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        
        // 设置右侧的Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        // 设置titleView
        titleBtn.setTitle("CodeJCSON", for: .normal)
        titleBtn.addTarget(self, action: #selector(LBHomeTabVController.titleBtnClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

extension LBHomeTabVController {
    @objc func titleBtnClick(titleBtn : LBTitleButton) {
        titleBtn.isSelected = !titleBtn.isSelected
        
        // 弹出的控制器
        let popoVc = LBPopController()
        popoVc.transitioningDelegate = self
        // 保证下面控制器不被移除
        popoVc.modalPresentationStyle = .custom
        popoverAnimator.presentedFrame = CGRect(x: 100, y: 100, width: 180, height: 250)
        present(popoVc, animated: true, completion: nil)
    }
}

extension LBHomeTabVController : UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return LBPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension LBHomeTabVController{
    func loadStatuses() {
        LBNetWork.shareInstance.loadStatuses { (result, isSuccess) -> () in
            // 错误结果
            if isSuccess == false{
                print(isSuccess)
                return
            }
            
            // 获取可选类型中的数据
            guard let resultArray = result else {
                return
            }
            
            // 遍历微博对应的字典
            for statusDict in resultArray {
                let status = LBHStatusModel(dict: statusDict)
                let viewModel = LBHStatusViewModel(status: status)
                self.viewModels.append(viewModel)
            }
            // 缓存图片
            self.cacheImages(viewModels: self.viewModels)
//            // 刷新表视图
//            self.tableView.reloadData()
        }
    }
    private func cacheImages(viewModels : [LBHStatusViewModel]) {
        // 创建group
        let group = DispatchGroup()
        
        // 缓存图片
        for viewmodel in viewModels {
            for picURL in viewmodel.picURLs {
                group.enter()
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: picURL as URL, options: [], progress: nil, completed: { (_, _, _, _) -> Void in
                    group.leave()
                })

            }
        }
        
        // 刷新表格
//        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
//            print("刷新表格")
//            self.tableView.reloadData()
//        }
        self.tableView.reloadData()
    }
}

extension LBHomeTabVController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 创建cell:在storyboard中添加cell,并设置Identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "LBHomeCell") as!LBHomeTableVCell
        
        // 给cell设置数据
        cell.viewModel = viewModels[indexPath.row]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 获取模型对象
        let viewModel = viewModels[indexPath.row]

        return viewModel.cellHeight
    }
}
