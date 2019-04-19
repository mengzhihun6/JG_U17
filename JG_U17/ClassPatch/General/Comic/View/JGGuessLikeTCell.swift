//
//  JGGuessLikeTCell.swift
//  JG_U17
//
//  Created by 郭军 on 2019/4/19.
//  Copyright © 2019 guojun. All rights reserved.
//

import UIKit

typealias JGGuessLikeTCellDidSelectClosure = (_ comic: ComicModel) -> Void


class JGGuessLikeTCell: JGBaseTableViewCell {

    
    private var didSelectClosure: JGGuessLikeTCellDidSelectClosure?
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        let cw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cw.backgroundColor = self.contentView.backgroundColor
        cw.delegate = self
        cw.dataSource = self
        cw.isScrollEnabled = false
        cw.register(cellType: JGComicCCell.self)
        return cw
    }()
    
    override func configUI() {
        let titileLabel = UILabel().then{
            $0.text = "猜你喜欢"
        }
        contentView.addSubview(titileLabel)
        titileLabel.snp.makeConstraints{
            $0.top.left.right.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titileLabel.snp.bottom).offset(5)
            $0.left.bottom.right.equalToSuperview()
        }
    }
    
    var model: GuessLikeModel? {
        didSet {
            self.collectionView.reloadData()
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


extension JGGuessLikeTCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.comics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.frame.width - 50) / 4)
        let height = collectionView.frame.height - 10
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: JGComicCCell.self)
        cell.style = .withTitle
        cell.model = model?.comics?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let comic = model?.comics?[indexPath.row],
            let didSelectClosure = didSelectClosure else { return }
        didSelectClosure(comic)
    }
    
    func didSelectClosure(_ closure: JGGuessLikeTCellDidSelectClosure?) {
        didSelectClosure = closure
    }
}
