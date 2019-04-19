//
//  JGReadBottomBar.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

class JGReadBottomBar: UIView {

    lazy var menuSlider: UISlider = {
        let mr = UISlider()
        mr.thumbTintColor = UIColor.theme
        mr.minimumTrackTintColor = UIColor.theme
        mr.isContinuous = false
        return mr
    }()
    
    lazy var deviceDirectionButton: UIButton = {
        let dn = UIButton(type: .system)
        dn.setImage(UIImage(named: "readerMenu_changeScreen_horizontal")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return dn
    }()
    
    lazy var lightButton: UIButton = {
        let ln = UIButton(type: .system)
        ln.setImage(UIImage(named: "readerMenu_luminance")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return ln
    }()
    
    lazy var chapterButton: UIButton = {
        let cn = UIButton(type: .system)
        cn.setImage(UIImage(named: "readerMenu_catalog")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return cn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        addSubview(menuSlider)
        menuSlider.snp.makeConstraints {
            $0.left.right.top.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 40))
            $0.height.equalTo(30)
            
        }
        
        addSubview(deviceDirectionButton)
        addSubview(lightButton)
        addSubview(chapterButton)
        
        
        
        
        
        let buttonArray = [deviceDirectionButton, lightButton, chapterButton]
        buttonArray.snp.distributeViewsAlong(axisType: .horizontal, fixedItemLength: 60, leadSpacing: 40, tailSpacing: 40)
        buttonArray.snp.makeConstraints {
            $0.top.equalTo(menuSlider.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
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
