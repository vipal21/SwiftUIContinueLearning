//
//  RowView.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 04/10/22.
//

import SwiftUI

struct RowView: View {
    var post:PhotoModel
    var body: some View {
        HStack {
            DownloadingImageView(url:post.url, key: "\(post.id)" )
            VStack (alignment:.leading){
                Text("\(post.title)")
                    .font(.headline)
                Text("\(post.url)")
                    .foregroundColor(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(post: PhotoModel(id: 1, albumId: 1, title: "title", url: "url", thumbnailUrl: "thumbnailUrl"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
