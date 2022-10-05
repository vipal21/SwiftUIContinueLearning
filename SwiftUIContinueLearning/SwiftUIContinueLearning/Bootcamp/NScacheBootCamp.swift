//
//  NScacheBootCamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 03/10/22.
//

import SwiftUI

class CacheManager {
    private init(){}
    static let instance = CacheManager()
    var imageCache : NSCache<NSString,UIImage> = {
        let cache = NSCache<NSString,UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 //10mb
        return cache
    }()
    
    func add (image : UIImage , name:String){
        imageCache.setObject(image, forKey: name as NSString)
        print("Added tc cach")
    }
    func remove (name:String){
        imageCache.removeObject(forKey:name as NSString )
        print("Remove from cach")
    }
    func get (name:String) -> UIImage?{
       return imageCache.object(forKey: name as NSString)
    }
}
class NScacheBootCampViewModel : ObservableObject {
    @Published var image : UIImage?
    @Published var cacheimage : UIImage?
    let manager = CacheManager.instance
    let  imageName: String = "Screenshot"
    init(){
        
    }
    func getImageFromAssets() {
        image = UIImage(named: imageName)!
    }
    func saveToCache ()
    {
        if let image = image{
            manager.add(image: image, name: imageName)
        }
       
    }
    func removeFromCache() {
        
            manager.remove(name: imageName)
     
    }
    func getFromCache() {
    
        guard  let image1 = manager.get(name: imageName ) else {return}
        cacheimage = image1
        
      
    }
}
struct NScacheBootCamp: View {
    @StateObject var vm : NScacheBootCampViewModel = NScacheBootCampViewModel()
    var body: some View {
        VStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200,height: 200)
                    .cornerRadius(20)
            }
       
            HStack(spacing: 20) {
                Button("Save Cache") {
                    vm.saveToCache()
                }
                Button("Delete Cache") {
                    vm.removeFromCache()
                }
           
            }
            VStack {
                if let image = vm.cacheimage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 200)
                        .cornerRadius(20)
                }
           

                Button("Get From Cache") {
                    vm.removeFromCache()
                }
            }
            Spacer()
        }
    }
}

struct NScacheBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        NScacheBootCamp()
    }
}
