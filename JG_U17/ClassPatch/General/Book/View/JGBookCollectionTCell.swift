//
//  JGBookCollectionTCell.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

class JGBookCollectionTCell: JGBaseTableViewCell {

    private lazy var imgView:UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    private lazy var TitleLbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.hex(hexString: "333333")
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private lazy var DescLbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.hex(hexString: "666666")
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.numberOfLines = 0
        return lbl
    }()
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func configUI() {

        self.contentView.addSubview(imgView)
        self.contentView.addSubview(TitleLbl)
        self.contentView.addSubview(DescLbl)
        
        imgView.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview().offset(10)
            maker.bottom.equalToSuperview().offset(-10)
            maker.width.equalTo(130)
            maker.height.equalTo(100)
        }
        
        TitleLbl.snp.makeConstraints { (maker) in
            maker.left.equalTo(imgView.snp.right).offset(10)
            maker.right.equalToSuperview().offset(-10)
            maker.top.equalTo(imgView).offset(10)
        }
        
        DescLbl.snp.makeConstraints { (maker) in
            maker.left.equalTo(imgView.snp.right).offset(10)
            maker.right.equalToSuperview().offset(-10)
            maker.top.equalTo(TitleLbl.snp.bottom).offset(15)
        }
    }
    
    
    var model: BookRankingListModel? {
        didSet {
            guard let model = model else { return }
            imgView.kf.setImage(urlString: model.cover)
            TitleLbl.text = "\(model.title ?? "")榜"
            DescLbl.text = model.subTitle
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
