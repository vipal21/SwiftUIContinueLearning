//
//  DownloadingImageViewModel.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 04/10/22.
//

import Foundation
import Combine
import SwiftUI

class DownloadingImageViewModel: ObservableObject{
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = false
    
    let manger = PhotoModelCacheManager.instance
   // let fm = PhotoModelFileManager.instance
    
    let urlString : String
    let imageKey : String
    
    var cancellable = Set<AnyCancellable>()
    
    init(url : String , key : String) {
        self.urlString = url
        self.imageKey = key
        getImage()
    }
    func getImage() {
        if let cacheImage = manger.get(key: self.imageKey) {
            image = cacheImage
            print("Get image from cm")
        }else{
            downloadImage()
        }
    }

    func downloadImage() {
        print("Downloading image now ..!")
        let url = urlString
        isLoading = true
        guard let url = URL(string:url)else {return}
        URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _  in
                self?.isLoading = false
            } receiveValue: { [weak self] returnimage in
                guard let image = returnimage,
                      let self = self
                       else {
                    self?.isLoading = false
                    return
                }
                self.isLoading = false
                self.image = image
                
                self.manger.add(key: self.imageKey , value: image)
            }
            .store(in: &cancellable)

                
    }
}
