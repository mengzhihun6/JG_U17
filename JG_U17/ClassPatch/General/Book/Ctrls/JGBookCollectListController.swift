//
//  JGBookCollectListController.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

class JGBookCollectListController: JGBaseController {

    private lazy var tableView:UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.backgroundColor = UIColor.white
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.register(cellType: JGBookCollectionTCell.self)
        tb.uHead = URefreshHeader { [weak self] in self?.loadData() }
        tb.uFoot = URefreshDiscoverFooter()
        tb.uempty = UEmptyView(verticalOffset: -(tb.contentInset.top)) { self.loadData() }
        return tb
    }()
    
    private var rankList = [BookRankingListModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadData()
        
    }
    

    override func configUI() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }
    
    
    
    private func loadData() {
        
        ApiLoadingProvider.request(JGApi.rankList, model: RankListModel.self) { [weak self] (returnData) in
            self?.rankList = returnData?.rankinglist ?? [];
            self?.tableView.uHead.endRefreshing()
            self?.tableView.uempty?.allowShow = true
            self?.tableView.reloadData()
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

extension JGBookCollectListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: JGBookCollectionTCell.self)
        cell.model = rankList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}
