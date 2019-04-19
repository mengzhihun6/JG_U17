//
//  JGDetailController.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//  详情

import UIKit

class JGDetailController: JGBaseController {

    weak var delegate: JGComicViewWillEndDraggingDelegate?
    
    var detailStatic: DetailStaticModel?
    var detailRealtime: DetailRealtimeModel?
    var guessLike: GuessLikeModel?
    
    private  lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.delegate = self
        tw.backgroundColor = UIColor.background
        tw.dataSource = self
        tw.separatorStyle = .none
        tw.register(cellType: JGDescriptionTCell.self)
        tw.register(cellType: JGOtherWorksTCell.self)
        tw.register(cellType: JGTicketTCell.self)
        tw.register(cellType: JGGuessLikeTCell.self)
        return tw
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    override func configUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {$0.edges.equalTo(self.view.usnp.edges) }
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

extension JGDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegate?.comicWillEndDragging(scrollView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailStatic != nil ? 4 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 1 && detailStatic?.otherWorks?.count == 0) ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return JGDescriptionTCell.height(for: detailStatic)
        } else if indexPath.section == 3{
            return 200
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: JGDescriptionTCell.self)
            cell.model = detailStatic
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: JGOtherWorksTCell.self)
            cell.model = detailStatic
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: JGTicketTCell.self)
            cell.model = detailRealtime
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: JGGuessLikeTCell.self)
            cell.model = guessLike
            cell.didSelectClosure { [weak self] (comic) in
                let vc = JGComicController(comicid: comic.comic_id)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = JGOtherWorksController(otherWorks: detailStatic?.otherWorks)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (section == 1 && detailStatic?.otherWorks?.count == 0) ? CGFloat.leastNormalMagnitude : 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
