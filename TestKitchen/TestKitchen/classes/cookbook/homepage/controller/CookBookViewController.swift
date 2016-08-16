//
//  CookBookViewController.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/15.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class CookBookViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createMyNav() //导航
        self.downloadRecommendData()
        // Do any additional setup after loading the view.
    }
    
    func createMyNav() {
        //扫一扫
        addNavBtn("saoyisao@2x", target: self, action: #selector(scanAction), isLeft: true)
        addNavBtn("search@2x", target: self, action: #selector(searchAction), isLeft: false)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CookBookViewController: KTCDownloaderDelegate{

    //下载失败
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError){
        print(error)
    }
    
    //下载成功
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?){
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(str)
    }


}

