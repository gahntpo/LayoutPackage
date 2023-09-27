//
//  ImageAspectView.swift
//  LayoutProject
//
//  Created by Karin Prater on 12.09.2023.
//

import SwiftUI

public struct ImageAspectView: View {
    
    let imageName: String
    let frameAspectRatio: CGFloat
    let cornerRadius: CGFloat
    
    public init(imageName: String,
                frameAspectRatio: CGFloat = 1,
                cornerRadius: CGFloat = 0) {
        self.imageName = imageName
        self.frameAspectRatio = frameAspectRatio
        self.cornerRadius = cornerRadius
    }
    
    public var body: some View {
        Color.cyan
            .aspectRatio(frameAspectRatio, contentMode: .fit)
            .overlay {
                Image(imageName, bundle: .module)
                    .resizable()
                    .aspectRatio(nil, contentMode: .fill)
            }
            .clipped()
            .cornerRadius(cornerRadius)
    }
}

#Preview {
    ImageAspectView(imageName: "cat_1")
}
