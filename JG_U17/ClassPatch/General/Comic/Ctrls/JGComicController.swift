//
//  JGComicController.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

protocol JGComicViewWillEndDraggingDelegate: class {
    func comicWillEndDragging(_ scrollView: UIScrollView)
}


class JGComicController: JGBaseController {

    private var comicid: Int = 0

    private lazy var mainScrollView: UIScrollView = {
        let sw = UIScrollView()
        sw.delegate = self
        return sw
    }()
    
    private lazy var detailVC: JGDetailController = {
        let dc = JGDetailController()
        dc.delegate = self
        return dc
    }()
    
    private lazy var chapterVC: JGChapterController = {
        let cc = JGChapterController()
        cc.delegate = self
        return cc
    }()
    
    private lazy var navigationBarY: CGFloat = {
        return navigationController?.navigationBar.frame.maxY ?? 0
    }()
    
    private lazy var commentVC: JGCommentController = {
        let cc = JGCommentController()
        cc.delegate = self
        return cc
    }()
    
    private lazy var pageVC: JGPageController = {
        return JGPageController(titles: ["详情", "目录", "评论"],
                                   vcs: [detailVC, chapterVC, commentVC],
                                   pageStyle: .topTabBar)
    }()
    
    private lazy var headView: JGComicHeader = {
        return JGComicHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBarY + 150))
    }()
    
    private var detailStatic: DetailStaticModel?
    private var detailRealtime: DetailRealtimeModel?
    
    convenience init(comicid: Int){
        self.init()
        self.comicid = comicid
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        edgesForExtendedLayout = .top
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        JGAppDelegate.changeOrientationTo(landscapeRight: false)
        loadData()
    }
    
    private func loadData() {
        
        let grpup = DispatchGroup()
        
        grpup.enter()
        ApiLoadingProvider.request(JGApi.detailStatic(comicid: comicid),
                                   model: DetailStaticModel.self) { [weak self] (detailStatic) in
                                    self?.detailStatic = detailStatic
                                    self?.headView.detailStatic = detailStatic?.comic
                                    
                                    self?.detailVC.detailStatic = detailStatic
                                    self?.chapterVC.detailStatic = detailStatic
                                    self?.commentVC.detailStatic = detailStatic
                                    
                                    ApiProvider.request(JGApi.commentList(object_id: detailStatic?.comic?.comic_id ?? 0,
                                                                         thread_id: detailStatic?.comic?.thread_id ?? 0,
                                                                         page: -1),
                                                        model: CommentListModel.self,
                                                        completion: { [weak self] (commentList) in
                                                            self?.commentVC.commentList = commentList
                                                            grpup.leave()
                                    })
        }
        
        grpup.enter()
        ApiProvider.request(JGApi.detailRealtime(comicid: comicid),
                            model: DetailRealtimeModel.self) { [weak self] (returnData) in
                                self?.detailRealtime = returnData
                                self?.headView.detailRealtime = returnData?.comic
                                
                                self?.detailVC.detailRealtime = returnData
                                self?.chapterVC.detailRealtime = returnData
                                
                                grpup.leave()
        }
        
        grpup.enter()
        ApiProvider.request(JGApi.guessLike, model: GuessLikeModel.self) { (returnData) in
            self.detailVC.guessLike = returnData
            grpup.leave()
        }
        
        grpup.notify(queue: DispatchQueue.main) {
            self.detailVC.reloadData()
            self.chapterVC.reloadData()
            self.commentVC.reloadData()
        }
    }

    override func configUI() {
        
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.usnp.edges).priority(.low)
            $0.top.equalToSuperview()
        }
        
        let contentView = UIView()
        mainScrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().offset(-navigationBarY)
        }
        
        addChild(pageVC)
        contentView.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        mainScrollView.parallaxHeader.view = headView
        mainScrollView.parallaxHeader.height = navigationBarY + 150
        mainScrollView.parallaxHeader.minimumHeight = navigationBarY
        mainScrollView.parallaxHeader.mode = .fill
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationController?.barStyle(.clear)
        mainScrollView.contentOffset = CGPoint(x: 0, y: -mainScrollView.parallaxHeader.height)
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


extension JGComicController: UIScrollViewDelegate, JGComicViewWillEndDraggingDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -scrollView.parallaxHeader.minimumHeight {
            navigationController?.barStyle(.theme)
            navigationItem.title = detailStatic?.comic?.name
        } else {
            navigationController?.barStyle(.clear)
            navigationItem.title = ""
        }
    }
    
    func comicWillEndDragging(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            mainScrollView.setContentOffset(CGPoint(x: 0,
                                                    y: -self.mainScrollView.parallaxHeader.minimumHeight),
                                            animated: true)
        } else if scrollView.contentOffset.y < 0 {
            mainScrollView.setContentOffset(CGPoint(x: 0,
                                                    y: -self.mainScrollView.parallaxHeader.height),
                                            animated: true)
        }
    }
}
