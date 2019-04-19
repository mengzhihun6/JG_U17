//
//  JGComicCHeader.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/18.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

typealias JGComicCHeadMoreActionClosure = ()->Void

protocol JGComicCHeadDelegate:class {
    func comicCHead(_ comicCHead: JGComicCHeader, moreAction button: UIButton)

}

class JGComicCHeader: JGBaseCollectionReusableView {
    
    weak var delegate: JGComicCHeadDelegate?

    private var moreActionClosure: JGComicCHeadMoreActionClosure?
    
    lazy var iconView: UIImageView = {
        return UIImageView()
    }()
    
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = .black
        return tl
    }()
    
    lazy var moreButton: UIButton = {
        let mn = UIButton(type: .system)
        mn.setTitle("•••", for: .normal)
        mn.setTitleColor(UIColor.lightGray, for: .normal)
        mn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        mn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return mn
    }()
    
    @objc func moreAction(button: UIButton) {
        delegate?.comicCHead(self, moreAction: button)
        
        guard let closure = moreActionClosure else { return }
        closure()
    }
    
    func moreActionClosure(_ closure: JGComicCHeadMoreActionClosure?) {
        moreActionClosure = closure
    }
    
    
    override func configUI() {
        
        addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(5)
            $0.centerY.height.equalTo(iconView)
            $0.width.equalTo(200)
        }
        
        addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.width.equalTo(40)
        }
    }
    
    
}
