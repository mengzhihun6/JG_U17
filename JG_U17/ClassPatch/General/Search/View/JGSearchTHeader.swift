//
//  JGSearchTHeader.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

typealias JGSearchTHeadMoreActionClosure = ()->Void

protocol JGSearchTHeadDelegate: class {
    func searchTHead(_ searchTHead: JGSearchTHeader, moreAction button: UIButton)
}



class JGSearchTHeader: JGBaseTableViewHeaderFooterView {

    weak var delegate: JGSearchTHeadDelegate?
    
    private var moreActionClosure: JGSearchTHeadMoreActionClosure?
    
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = UIColor.gray
        return tl
    }()
    
    lazy var moreButton: UIButton = {
        let mn = UIButton(type: .custom)
        mn.setTitleColor(UIColor.lightGray, for: .normal)
        mn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return mn
    }()
    
    @objc private func moreAction(button: UIButton) {
        delegate?.searchTHead(self, moreAction: button)
        
        guard let closure = moreActionClosure else { return }
        closure()
    }
    
    func moreActionClosure(_ closure: @escaping JGSearchTHeadMoreActionClosure) {
        moreActionClosure = closure
    }
    
    
    override func configUI() {
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(200)
        }
        
        contentView.addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        let line = UIView().then { $0.backgroundColor = UIColor.background }
        contentView.addSubview(line)
        line.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
