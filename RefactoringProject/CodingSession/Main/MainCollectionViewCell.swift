//
//  MainCollectionViewCell.swift
//  CodingSession
//
//  Created by Fiodar Shtytsko on 29/11/2023.
//

import UIKit

struct MainCollectionViewCellModel {
    let image: UIImage?
    let durationText: String
}

final class MainColletctionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MainColletctionViewCell"

    private lazy var thumbImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: MainCollectionViewCellModel) {
        thumbImageView.image = viewModel.image
        durationLabel.text = viewModel.durationText
    }
    
    private func setupViews() {
        contentView.addSubview(thumbImageView)
        contentView.addSubview(durationLabel)

        thumbImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        durationLabel.snp.makeConstraints { make in
            make.leading.equalTo(8)
            make.bottom.equalTo(-8)
        }
    }
}
