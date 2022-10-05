//
//  PhotoModelFileManager.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 04/10/22.
//

import Foundation
import SwiftUI
class PhotoModelFileManager {
    static let instance =  PhotoModelFileManager()
    let foldername = "MyAppImages"
    private init(){
        createFolderIfNeeded()
    }
   private func createFolderIfNeeded() {
       guard let url = getFolderPath() else{return}
       if !FileManager.default.fileExists(atPath: url.path) {
           do {
               try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: url, create: true)
               print("Folder created")
           } catch (let error) {
               print("Error : \(error.localizedDescription)")
           }
           
       }
    }
    // .../MyAppImages
    // .../MyAppImages/image.png
    private func getFolderPath() -> URL? {
        return FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(component: foldername)
     }
    
    private func getImagePath(key : String) -> URL? {
        guard let folder = getFolderPath() else {return nil}
        return folder.appendingPathComponent(key + ".png")
        
    }
    func add(key:String ,value: UIImage){
        guard let data = value.pngData(),
              let url = getImagePath(key:key) else { return }
        do {
            try  data.write(to: url)
            print("File added to folder")
        } catch let error {
            print("Error to write file : \(error.localizedDescription)")
        }
       
    }
    func get(key:String) -> UIImage? {
        guard let url = getImagePath(key: key),
              FileManager.default.fileExists(atPath: key )else {
            print("Error to get the file")
            return nil
        }
        return UIImage(contentsOfFile:url.path )
    }
}
