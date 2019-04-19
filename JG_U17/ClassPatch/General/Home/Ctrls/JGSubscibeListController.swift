//
//  JGSubscibeListController.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/18.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

class JGSubscibeListController: JGBaseController {

    private var subscribeList = [ComicListModel]()

    private lazy var collectionView: UICollectionView = {
        let lt = UCollectionViewSectionBackgroundLayout()
        lt.minimumInteritemSpacing = 5
        lt.minimumLineSpacing = 10
        let cw = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        cw.backgroundColor = UIColor.background
        cw.delegate = self
        cw.dataSource = self
        cw.alwaysBounceVertical = true
        cw.register(cellType: JGComicCCell.self)
        cw.register(supplementaryViewType: JGComicCHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
        cw.register(supplementaryViewType: JGComicCFooter.self, ofKind: UICollectionView.elementKindSectionFooter)
        cw.uHead = URefreshHeader{ [weak self] in self?.loadData() }
        cw.uFoot = URefreshTipKissFooter(with: "使用妖气币可以购买订阅漫画\nVIP会员购买还有优惠哦~")
        cw.uempty = UEmptyView { [weak self] in self?.loadData() }
        return cw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        loadData()
    }
    

    
    private func loadData() {
        
        ApiLoadingProvider.request(JGApi.subscribeList, model: SubscribeListModel.self) { (returnData) in
            
            self.collectionView.uHead.endRefreshing()
            self.collectionView.uempty?.allowShow = true
            
            self.subscribeList = returnData?.newSubscribeList ?? []
            self.collectionView.reloadData()
        }
    }
    
    
    
    override func configUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
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


extension JGSubscibeListController: UCollectionViewSectionBackgroundLayoutDelegateLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return subscribeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let comicList = subscribeList[section]
        return comicList.comics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: JGComicCHeader.self)
            let comicList = subscribeList[indexPath.section]
            head.iconView.kf.setImage(urlString: comicList.titleIconUrl)
            head.titleLabel.text = comicList.itemTitle
            head.moreButton.isHidden = !comicList.canMore
            head.moreActionClosure { [weak self] in
                let vc = JGComicListController(argCon: comicList.argCon, argName: comicList.argName, argValue: comicList.argValue)
                vc.title = comicList.itemTitle
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return head
        } else {
            let foot = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath, viewType: JGComicCFooter.self)
            return foot
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let comicList = subscribeList[section]
        return comicList.itemTitle?.count ?? 0 > 0 ? CGSize(width: screenWidth, height: 44) : CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return subscribeList.count - 1 != section ? CGSize(width: screenWidth, height: 10) : CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: JGComicCCell.self)
        cell.style = .withTitle
        let comicList = subscribeList[indexPath.section]
        cell.model = comicList.comics?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(Double(screenWidth - 10.0) / 3.0)
        return CGSize(width: width, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let comicList = subscribeList[indexPath.section]
        guard let model = comicList.comics?[indexPath.row] else { return }
        let vc = JGComicController(comicid: model.comicId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
