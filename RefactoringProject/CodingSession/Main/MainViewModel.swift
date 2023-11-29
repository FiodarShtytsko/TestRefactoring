//
//  MainViewModel.swift
//  CodingSession
//
//  Created by Fiodar Shtytsko on 29/11/2023.
//

import Photos

final class MainViewModel {
    private(set) var assets: [PHAsset] = []

    func fetchVideoAssets(completion: @escaping () -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.video.rawValue)

        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        assets = fetchResult.objects(at: IndexSet(0..<fetchResult.count))
        completion()
    }
}
