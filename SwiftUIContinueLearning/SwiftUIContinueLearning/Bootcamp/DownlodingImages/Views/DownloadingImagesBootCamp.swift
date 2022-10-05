//
//  DownloadingImagesBootCamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 04/10/22.
//

import SwiftUI

/*
 Topic we are going to Learn
 Codable
 Background threads
 Weak self
 Combine
 Publisher and Sunscriber
 File Manager
 NSCahces
 */
/*
 Steps for any create any view with view Model
 1.Create viewModel instance
 2.Perform all oprations vsing that instance with @StateObject
 for example : class ClassName {
 @StateObject var vm = ViewModel()
    func doOprtion () {
        vm.doOpration()
    }
 }
 If you want to use ViewModel in class init then you have to use _vm = StateObject(wrappedValue)
 //StateObject(wrappedValue)
 */

struct DownloadingImagesBootCamp: View {
    @StateObject var vm: DownloadingImagesBootCampViewModel = DownloadingImagesBootCampViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.posts) { post in
                    RowView(post: post)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Downloading Images")
        }
    }
}

struct DownloadingImagesBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootCamp()
    }
}


