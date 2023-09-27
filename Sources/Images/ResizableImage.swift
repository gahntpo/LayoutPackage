//
//  SwiftUIView.swift
//  
//
//  Created by Karin Prater on 27.09.23.
//

import SwiftUI

public struct ResizableImage: View {
    let imageName: String
    
    public init(imageName: String) {
        self.imageName = imageName
    }
    
    public var body: some View {
        Image(imageName, bundle: .module)
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    ResizableImage(imageName: "cat_1")
}
