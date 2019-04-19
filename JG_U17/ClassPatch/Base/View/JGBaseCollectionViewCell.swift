//
//  JGBaseCollectionViewCell.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/18.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit
import Reusable

class JGBaseCollectionViewCell: UICollectionViewCell ,Reusable{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI(){}
}
