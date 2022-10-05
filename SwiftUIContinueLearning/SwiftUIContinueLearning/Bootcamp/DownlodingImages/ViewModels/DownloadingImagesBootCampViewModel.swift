//
//  DownloadingImagesBootCampViewModel.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 04/10/22.
//

import Foundation
import Combine
/*
 Steps for create ViweModel
 1. create class with ObservableObject
 2. create the proerties which you want to access inn Views as @Published.
 2. create init method
 3. create object of Model
 4. create mehtods and perfom opration on Model.
 5. if class need any utils (manager like DB manger) create instance and perform opration using that instance.
 
 ex:
 class ClassViewModel : ObservableObject {
 
 @Published var var1:int ...(Used in Views)
 @Published var objModel:Model = Model
 var localVar : String = ""
 let manager = Manager.instance
         func mehtodUsedForManagerOpration() {
            manager.doOpration()
         }
         func mehtodForOprationOnModel(){
            objModel.name = "john"
         }
 }
 */

class DownloadingImagesBootCampViewModel:ObservableObject{
    @Published var posts:[PhotoModel] = []
    var cancellable =  Set<AnyCancellable>()
    let photoServiceManager =  PhotoModelDataService.instance
    init(){
        addSubscriber()
    }
    func addSubscriber () {
        photoServiceManager.$post
            .sink { [weak self] returnedposts in
                guard let self = self else {return}
                self.posts = returnedposts
            }
            .store(in: &cancellable)
    }
}
