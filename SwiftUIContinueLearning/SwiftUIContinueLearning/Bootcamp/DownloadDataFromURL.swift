//
//  CombineBootCamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 30/09/22.
//

import SwiftUI

struct PostModel:Codable,Identifiable {
    let userId : Int
    let id : Int
    let title : String
    let body : String

}
class DownloadDataFromURLViewModel : ObservableObject {
    @Published var post : [PostModel] = []
    init() {
        getPost()
    }
    func getPost() {
       guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")else
        {return}
        downloadData(fromURL: url) { data in
            if let data = data {
                guard let  postData = try? JSONDecoder().decode(PostModel.self, from: data) else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.post.append(postData)
                    
                }
                
            }else {
                print("No data return")
            }
        }
        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data ,
//                    error == nil ,let  response = response as? HTTPURLResponse,
//                  response.statusCode >= 200 && response.statusCode < 300 else {
//                print("Error in Downloading Data")
//                return
//            }
//
//
//
//            print("Sucessfully download data : \(data)")
//            let jsonString = String(data: data, encoding: .utf8)
//            guard let  postData = try? JSONDecoder().decode(PostModel.self, from: data) else {
//                return
//            }
//            self.post.append(postData)
//        }.resume()
    }
    func downloadData (fromURL url : URL , complitionHandler : @escaping (_ data :Data?) -> Void ){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data ,
                    error == nil ,let  response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                complitionHandler(nil)
                print("Error in Downloading Data")
                return
            }
            complitionHandler(data)
        }.resume()
    }
    
}
struct DownloadDataFromURL: View {
    @StateObject  var vm:DownloadDataFromURLViewModel = DownloadDataFromURLViewModel()
    var body: some View {
        List {
            ForEach(vm.post) { item in
                VStack(alignment: .leading, spacing: 10){
                    Text("\(item.title)")
                        .font(.headline)
                    Text("\(item.body)")
                        .font(.subheadline)
                }
               
            }
        }.listStyle(.plain)
    }
}

struct DownloadDataFromURL_Previews: PreviewProvider {
    static var previews: some View {
        DownloadDataFromURL()
    }
}
