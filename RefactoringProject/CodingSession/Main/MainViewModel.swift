//
//  MainViewModel.swift
//  CodingSession
//
//  Created by Fiodar Shtytsko on 29/11/2023.
//

import Photos
import UIKit

final class MainViewModel {
    private(set) var cellViewModels: [MainCollectionViewCellModel] = []
    
    func fetchVideoAssets(completion: @escaping () -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.video.rawValue)
        
        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        var tempViewModels = [MainCollectionViewCellModel]()
        let group = DispatchGroup()
        
        fetchResult.enumerateObjects { [weak self] (asset, _, _) in
            group.enter()
            self?.loadImage(for: asset) { image in
                guard let self = self else { return }
                let durationText = self.formatDuration(asset.duration)
                let viewModel = MainCollectionViewCellModel(image: image, durationText: durationText)
                tempViewModels.append(viewModel)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.cellViewModels = tempViewModels
            completion()
        }
    }
    
}

private extension MainViewModel {
    func loadImage(for asset: PHAsset, completion: @escaping (UIImage?) -> Void) {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        let targetSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        
        manager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { (image, _) in
            completion(image)
        }
    }
    
    func formatDuration(_ duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        formatter.unitsStyle = .positional
        return formatter.string(from: duration) ?? ""
    }
}
