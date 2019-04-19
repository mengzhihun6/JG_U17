//
//  JGSearchTFooter.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

class USearchCCell: JGBaseCollectionViewCell {
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = UIColor.darkGray
        return tl
    }()
    override func configUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.background.cgColor
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)) }
    }
}

typealias JGSearchTFootDidSelectIndexClosure = (_ index: Int, _ model: SearchItemModel) -> Void

protocol JGSearchTFootDelegate: class {
    func searchTFoot(_ searchTFoot: JGSearchTFooter, didSelectItemAt index: Int, _ model: SearchItemModel)
}



class JGSearchTFooter: JGBaseTableViewHeaderFooterView {

    weak var delegate: JGSearchTFootDelegate?
    
    private var didSelectIndexClosure: JGSearchTFootDidSelectIndexClosure?
    
    private lazy var collectionView: UICollectionView = {
        let lt = UCollectionViewAlignedLayout()
        lt.minimumInteritemSpacing = 10
        lt.minimumLineSpacing = 10
        lt.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        lt.horizontalAlignment = .left
        lt.estimatedItemSize = CGSize(width: 100, height: 40)
        let cw = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        cw.backgroundColor = UIColor.white
        cw.dataSource = self
        cw.delegate = self
        cw.register(cellType: USearchCCell.self)
        return cw
    }()
    
    var data: [SearchItemModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func configUI() {
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension JGSearchTFooter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: USearchCCell.self)
        cell.layer.cornerRadius = cell.bounds.height * 0.5
        cell.titleLabel.text = data[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.searchTFoot(self, didSelectItemAt: indexPath.row, data[indexPath.row] )
        
        guard let closure = didSelectIndexClosure else { return }
        closure(indexPath.row, data[indexPath.row])
    }
    
    func didSelectIndexClosure(_ closure: @escaping JGSearchTFootDidSelectIndexClosure) {
        didSelectIndexClosure = closure
    }
}
