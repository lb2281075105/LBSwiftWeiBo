//
//  LBOauthController.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/14.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit
import SVProgressHUD
class LBOauthController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏按钮
        setUpNavigationBar()
        // 加载网页
        loadPage()
    }
}

extension LBOauthController{
    func setUpNavigationBar() {
        // 设置导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(LBOauthController.closeItemClick))

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(LBOauthController.fillItemClick))
        
        title = "登录页面"
    }
    func loadPage() {
        // 加载网页
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        
        guard let url = NSURL(string: urlString) else {
            return
        }
        let request = NSURLRequest.init(url: url as URL)
        
        webView.loadRequest(request as URLRequest)
    }
}

extension LBOauthController {
    @objc func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func fillItemClick() {
        let jsCode = "document.getElementById('userId').value='17078075655';document.getElementById('passwd').value='LB1314lb';"
        
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

extension LBOauthController : UIWebViewDelegate {
    // webView开始加载网页
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    // webView网页加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    // webView加载网页失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    
    // 当准备加载某一个页面时,会执行该方法
    // 返回值: true:继续加载该页面 false:不会加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // 获取加载网页的NSURL
        guard let url = request.url else {
            return true
        }
        // 获取url中的字符串
        let urlString = url.absoluteString
        // 判断该字符串中是否包含code
        guard urlString.contains("code=") else {
            return true
        }
        // 获取code
        guard let code = urlString.components(separatedBy: "code=").last else {
            return true
        }
        print("code=" + code)
        // 请求accessToken
        loadAccessToken(code: code)
        
        return false
    }
}

extension LBOauthController {
    /// 请求AccessToken
    func loadAccessToken(code : String) {
        LBNetWork.shareInstance.loadAccessToken(code: code) { (result, isSuccess) in
            // 错误校验
            if isSuccess == false {
                print(isSuccess)
                return
            }
            
            // 正确获取
            /*
             ["expires_in": 157679999, "access_token": 2.00LoeuYGxtnivD584d955f18VkZKMB, "remind_in": 157679999, "isRealName": true, "uid": 6012695655]
            */
            guard let accountDict = result else {
                print("没有获取授权后的数据")
                return
            }
            let account = LBUserAccount(dict: accountDict)
            
            // 请求用户信息
            // 在回调里面调用方法需要加上self
            self.loadUserInfo(account: account)
        }
    }
    
    
    // 请求用户信息
    func loadUserInfo(account : LBUserAccount) {
        // 获取AccessToken
        guard let accessToken = account.access_token else {
            return
        }
        
        // 获取uid
        guard let uid = account.uid else {
            return
        }
        
        // 发送网络请求
        LBNetWork.shareInstance.loadUserInfo(access_token: accessToken, uid: uid) { (result, isSuccess) -> () in
            // 错误结果
            if isSuccess == false {
                print(isSuccess)
                return
            }
            
            guard let userInfoDict = result else {
                return
            }
            
            // 从字典中取出昵称和用户头像地址
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            print(result ?? "")
            
            // 获取沙盒路径
            var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            accountPath = (accountPath as NSString).appendingPathComponent("lbuserAccount.plist")
            print("打印沙盒路径" + accountPath)
            
            // 保存对象
            NSKeyedArchiver.archiveRootObject(account, toFile: accountPath)
        }
    }
}
