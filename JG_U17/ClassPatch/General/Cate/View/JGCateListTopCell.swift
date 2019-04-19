//
//  JGCateListTopCell.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

class JGCateListTopCell: JGBaseCollectionViewCell {
    
    private lazy var iconView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        return iw
    }()
    
    override func configUI() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.masksToBounds = true
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    
    var model: TopModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.cover)
        }
    }
    
}
