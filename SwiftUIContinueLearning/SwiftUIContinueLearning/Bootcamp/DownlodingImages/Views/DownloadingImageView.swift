//
//  DoenloadingImageView.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 04/10/22.
//

import SwiftUI


struct DownloadingImageView: View {
    @StateObject var vm: DownloadingImageViewModel
    init(url :String, key: String) {
        _vm = StateObject(wrappedValue: DownloadingImageViewModel(url: url , key: key) )
    }
    var body: some View {
        
        ZStack {
            if(vm.isLoading)
            {
                ProgressView()
                    .frame(width: 75,height: 75)
            }else if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 75,height: 75)
                    .clipped()
                    .clipShape(Circle())
            }
        }
    }
   
}

struct DownloadingImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
    }
}
