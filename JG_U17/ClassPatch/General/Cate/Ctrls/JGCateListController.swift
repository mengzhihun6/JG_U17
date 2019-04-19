//
//  JGCateListController.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/18.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

class JGCateListController: JGBaseController {

    private var searchString = ""
    private var topList = [TopModel]()
    private var rankList = [RankingModel]()
    
    private lazy var searchButon: UIButton = {
        let sn = UIButton(type: .system)
        sn.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 30)
        sn.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        sn.layer.cornerRadius = 15
        sn.setTitleColor(.white, for: .normal)
        sn.setImage(UIImage(named: "nav_search")?.withRenderingMode(.alwaysOriginal), for: .normal)
        sn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        sn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        sn.addTarget(self, action:#selector(searchAction), for: .touchUpInside)
        return sn
    }()
    
    private lazy var collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.minimumInteritemSpacing = 10
        lt.minimumLineSpacing = 10
        let cw = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        cw.backgroundColor = UIColor.white
        cw.delegate = self
        cw.dataSource = self
        cw.alwaysBounceVertical = true
        cw.register(cellType: JGCateListRankCell.self)
        cw.register(cellType: JGCateListTopCell.self)
        cw.uHead = URefreshHeader { [weak self] in self?.loadData() }
        cw.uempty = UEmptyView { [weak self] in self?.loadData() }
        return cw
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
           loadData()
    }
    
    private func loadData() {
        ApiLoadingProvider.request(JGApi.cateList, model: CateListModel.self) { (returnData) in
            self.collectionView.uempty?.allowShow = true
            
            self.searchString = returnData?.recommendSearch ?? ""
            self.topList = returnData?.topList ?? []
            self.rankList = returnData?.rankingList ?? []
            
            self.searchButon.setTitle(self.searchString, for: .normal)
            self.collectionView.reloadData()
            self.collectionView.uHead.endRefreshing()
        }
    }
    
    @objc private func searchAction() {
        navigationController?.pushViewController(JGSearchController(), animated: true)
    }
    
    override func configUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.titleView = searchButon
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil,
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil,
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
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


extension JGCateListController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return topList.prefix(3).count
        } else {
            return rankList.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: JGCateListTopCell.self)
            cell.model = topList[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: JGCateListRankCell.self)
            cell.model = rankList[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: section == 0 ? 0 : 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(Double(screenWidth - 40.0) / 3.0)
        return CGSize(width: width, height: (indexPath.section == 0 ? 55 : (width * 0.75 + 30)))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let model = topList[indexPath.row]
            var titles: [String] = []
            var vcs: [UIViewController] = []
            for tab in model.extra?.tabList ?? [] {
                guard let tabTitle = tab.tabTitle else { continue }
                titles.append(tabTitle)
                vcs.append(JGComicListController(argCon: tab.argCon,
                                                    argName: tab.argName,
                                                    argValue: tab.argValue))
            }
            let vc = JGPageController(titles: titles, vcs: vcs, pageStyle: .topTabBar)
            vc.title = model.sortName
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.section == 1 {
            let model = rankList[indexPath.row]
            let vc = JGComicListController(argCon: model.argCon,
                                              argName: model.argName,
                                              argValue: model.argValue)
            vc.title = model.sortName
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
