//
//  CookBookViewController.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/15.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class CookBookViewController: BaseViewController {

    //食材首页的推荐视图
    private var recommendView: CBRecommendView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMyNav() //导航
        downloadRecommendData()
        createHomePageView()
        // Do any additional setup after loading the view.
    }
    
    func createMyNav() {
        //扫一扫
        addNavBtn("saoyisao@2x", target: self, action: #selector(scanAction), isLeft: true)
        addNavBtn("search@2x", target: self, action: #selector(searchAction), isLeft: false)
    }
    
    
    //初始化视图
    func createHomePageView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        //推荐
        recommendView = CBRecommendView()
        view.addSubview(recommendView!)
        
        recommendView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        })
    }
    
    //扫一扫
    func scanAction() {
        
    }
    //搜索
    func searchAction() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadRecommendData() {
//methodName=SceneHome&token=&user_id=&version=4.5
        let dict = ["methodName":"SceneHome", "token":"", "user_id":"", "version":"4.5"]
        let downloader = KTCDownloader()
        //设置代理
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: dict)
        
        
    }
}

extension CookBookViewController: KTCDownloaderDelegate{

    //下载失败
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError){
        print(error)
    }
    
    //下载成功
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?){
        
        if let jsonData = data {
            let model = CBRecommendModel.parseModel(jsonData)
            //显示数据
            dispatch_async(dispatch_get_main_queue(), {
                [weak self] in
                self!.recommendView?.model = model
            })
        }
    }


}

