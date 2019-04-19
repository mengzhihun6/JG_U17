//
//  JGDescriptionTCell.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

class JGDescriptionTCell: JGBaseTableViewCell {

    lazy var textView: UITextView = {
        let tw = UITextView()
        tw.isUserInteractionEnabled = false
        tw.textColor = UIColor.gray
        tw.font = UIFont.systemFont(ofSize: 15)
        return tw
    }()
    
    
    override func configUI() {
        let titileLabel = UILabel().then{
            $0.text = "作品介绍"
        }
        contentView.addSubview(titileLabel)
        titileLabel.snp.makeConstraints{
            $0.top.left.right.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(textView)
        textView.snp.makeConstraints{
            $0.top.equalTo(titileLabel.snp.bottom)
            $0.left.right.bottom.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        }
    }
    
    var model: DetailStaticModel? {
        didSet{
            guard let model = model else { return }
            textView.text = "【\(model.comic?.cate_id ?? "")】\(model.comic?.description ?? "")"
        }
    }
    
    class func height(for detailStatic: DetailStaticModel?) -> CGFloat {
        var height: CGFloat = 50.0
        guard let model = detailStatic else { return height }
        let textView = UITextView().then{ $0.font = UIFont.systemFont(ofSize: 15) }
        textView.text = "【\(model.comic?.cate_id ?? "")】\(model.comic?.description ?? "")"
        height += textView.sizeThatFits(CGSize(width: screenWidth - 30, height: CGFloat.infinity)).height
        return height
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
