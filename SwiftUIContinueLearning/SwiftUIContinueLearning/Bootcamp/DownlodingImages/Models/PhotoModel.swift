//
//  PhotoModel.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 04/10/22.
//

import Foundation
//{
//    "albumId": 1,
//    "id": 1,
//    "title": "accusamus beatae ad facilis cum similique qui sunt",
//    "url": "https://via.placeholder.com/600/92c952",
//    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
//  }
struct PhotoModel: Identifiable,Codable {
    let id: Int
    let albumId:Int
    let title :String
    let url: String
    let thumbnailUrl:String
    
}
