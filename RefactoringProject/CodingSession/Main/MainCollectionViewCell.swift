//
//  MainCollectionViewCell.swift
//  CodingSession
//
//  Created by Fiodar Shtytsko on 29/11/2023.
//

import UIKit
import Photos

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

    func configure(with asset: PHAsset) {
        let requestOptions = PHImageRequestOptions()
        
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        
        let targetSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { [weak self] (image, _) in
            self?.thumbImageView.image = image
        }
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        formatter.unitsStyle = .positional
        
        durationLabel.text = formatter.string(from: asset.duration)
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
