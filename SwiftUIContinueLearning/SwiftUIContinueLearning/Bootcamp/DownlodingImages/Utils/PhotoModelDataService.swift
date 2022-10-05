//
//  PhotoModelDataService.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 04/10/22.
//

import Foundation
import Combine
/*
 Steps for create any Manager (Singletone class)
 1.create class with final so no other call can inherite that class
 2.make init () private so no one can init() that class
 3.create object with static let.
 4.cerate mthods for that class.
 
 */
class PhotoModelDataService {
    static let instance = PhotoModelDataService()
    @Published var post :[PhotoModel] = []
    var cancellable =  Set<AnyCancellable>()
    
    private init(){
        downloadData()
    }
    /*
     Steps for Using Combine
     
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
     //7 cancle subscription if needed (the whole tak is cancellable so we need to stor in Any cancellable.)
     */
    func downloadData (){
        guard  let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            print("Invalide URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)      //1. create the publisher
            .subscribe(on: DispatchQueue.global(qos: .background))    //2. subscribe publisher on background threade
            .receive(on: DispatchQueue.main)   //3. recive on main thread
            .tryMap(HandelOuPut)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder()) //5. decode data
            //6. use item using sink we have two complitionbloks in first we are getting  compltion with two vlaues like finished and failure.and in second we arw fetting our actual data in receiveValue.
            .sink { completion in
                switch completion {
                case .finished :
                    print("finished")
                    break
                case .failure(let error) :
                    print("failure with error \(error.localizedDescription)")
                }
            } receiveValue: {[weak self] receivedPost in
                guard let  self = self else
                {return}
                self.post = receivedPost
            }
        //7 cancle subscription if needed (the whole tak is cancellable so we need to stor in Any cancellable.)
            .store(in: &cancellable)

        
         
    }
    
    private func HandelOuPut(output : URLSession.DataTaskPublisher.Output) throws -> Data {
        //output is tupple with two value (data,response)
        //4. tryMap (check the data is good or not)
       guard
        let response =  output.response as? HTTPURLResponse,
        response.statusCode >= 200 && response.statusCode < 300 else {
           throw URLError(.badServerResponse)
       }
        return output.data
        
    }
}
