//
//  JGSpecialCell.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

class JGSpecialCell: JGBaseTableViewCell {

    private lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.black
        tl.font = UIFont.systemFont(ofSize: 14)
        return tl
    }()
    
    private lazy var coverView: UIImageView = {
        let cw = UIImageView()
        cw.contentMode = .scaleAspectFill
        cw.layer.cornerRadius = 5
        cw.layer.masksToBounds = true
        return cw
    }()
    
    private lazy var tipLabel: UILabel = {
        let tl = UILabel()
        tl.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        tl.textColor = UIColor.white
        tl.font = UIFont.systemFont(ofSize: 9)
        return tl
    }()
    
    override func configUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.top.right.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            $0.height.equalTo(40)
        }
        
        contentView.addSubview(coverView)
        coverView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10))
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        coverView.addSubview(tipLabel)
        tipLabel.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        let line = UIView().then{
            $0.backgroundColor = UIColor.background
        }
        contentView.addSubview(line)
        line.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(10)
        }
    }
    
    
    var model: ComicModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.title
            coverView.kf.setImage(urlString: model.cover)
            tipLabel.text = "    \(model.subTitle ?? "")"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
