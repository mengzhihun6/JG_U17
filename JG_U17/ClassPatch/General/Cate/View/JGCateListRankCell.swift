//
//  JGCateListRankCell.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

class JGCateListRankCell: JGBaseCollectionViewCell {
    
    private lazy var iconView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        return iw
    }()
    
    private lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = .black
        return tl
    }()
    
    override func configUI() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.masksToBounds = true
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(contentView.snp.width).multipliedBy(0.75)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(iconView.snp.bottom)
        }
    }
    
    var model: RankingModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.cover)
            titleLabel.text = model.sortName
        }
    }
    
    
}
