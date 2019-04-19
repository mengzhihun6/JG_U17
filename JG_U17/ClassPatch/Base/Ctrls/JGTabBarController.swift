//
//  JGTabBarController.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/18.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

class JGTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tabBar.isTranslucent = false
        
        //创建子控制器
        setUpCtrls()
        
    }
    
    
    
    /// 创建子控制器
    func setUpCtrls() {
        
        /// 首页
        let homeVC = JGHomeController(titles: ["推荐","VIP","订阅","排行"],
                                      vcs: [JGBoutiqueListController(),
                                            JGVIPListController(),
                                            JGSubscibeListController(),
                                            JGRankListController() ],
                                      pageStyle: .navgationBarSegment)
        addChildViewController(homeVC, title: "首页", image: "tab_home", selImage: "tab_home_S")
        
        /// 分类
        let CatVC = JGCateListController()
        addChildViewController(CatVC, title: "分类", image: "tab_class", selImage: "tab_class_S")
        
        /// 书架
        let BookVC = JGBookController(titles: ["收藏","书单","下载"],
                                      vcs: [JGBookCollectListController(),
                                            JGBookDocumentListController(),
                                            JGBookDownloadListController() ],
                                      pageStyle: .navgationBarSegment)
        addChildViewController(BookVC, title: "书架", image: "tab_book", selImage: "tab_book_S")
        
        /// 我的
        let MineVC = JGMineController()
        addChildViewController(MineVC, title: "我的", image: "tab_mine", selImage: "tab_mine_S")
    }
    
    
    /// 添加子控制器
    ///
    /// - Parameters:
    ///   - VC: 子控制器
    ///   - title: 子控制器标题
    ///   - image: 正常状态下的图片
    ///   - selImage: 选中状态下的图片
    func addChildViewController(_ VC:UIViewController, title:String?, image:String?, selImage:String?) {
        
        VC.title = title
        let NorImg = UIImage.init(named: image!)
        let SelImg = UIImage.init(named: selImage!)
        VC.tabBarItem = UITabBarItem(title: nil, image: NorImg?.withRenderingMode(.alwaysOriginal), selectedImage: SelImg?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            VC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            
        }
        addChild(JGNavigationController(rootViewController: VC))
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
