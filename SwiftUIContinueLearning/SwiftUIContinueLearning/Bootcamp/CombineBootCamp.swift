//
//  CombineBootCamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 01/10/22.
//

import SwiftUI
import Combine

struct PostsModel:Codable,Identifiable {
    let userId : Int
    let id : Int
    let title : String
    let body : String

}
class CombineBootCampViewModel : ObservableObject{
    @Published var posts:[PostsModel] = []
    var cancleables = Set<AnyCancellable>()
    init() {
        getData()
    }
    func getData(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        //1. signup for subscription for the packge
        //2. the compnay would make the packge behind the scene
        //3. recive your packge at your door
        //4. check the packge damaged or not
        //5. oprn and check the item is correct or not
        //6. use the item
        //7. canclelable at any time.
        
        //1. create the publisher
        //2. subscribe publisher on background threade
        //3. recive on main thread
        //4. tryMap (check the data is good or not)
        //5. decode data
        //6. use item
        //7 cancle subscription if needed
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
          
            .tryMap(handleOutput)
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: {[weak self] returnposts in
                self?.posts = returnposts

            })
//            .sink { completion in
////                switch completion {
////                case .finished :
////                    print("Finished")
////                case .failure(let error) :
////                    print("There was an error \(error)")
////                }
//                print(completion)
//            } receiveValue: {[weak self] returnposts in
//                self?.posts = returnposts
//            }
            .store(in: &cancleables)

        
    }
    func handleOutput (output: URLSession.DataTaskPublisher.Output) throws -> Data {
    
        guard let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
        
    }
    
}
struct CombineBootCamp: View {
    @StateObject var vm: CombineBootCampViewModel = CombineBootCampViewModel()
    var body: some View {
        List {
            ForEach(vm.posts) { item in
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

struct CombineBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        CombineBootCamp()
    }
}
