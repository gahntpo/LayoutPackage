//
//  EqualWidthVStack.swift
//  ExtractPackageProject
//
//  Created by Karin Prater on 27.09.23.
//

import SwiftUI

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public struct EqualWidthVStack: Layout {
    
    public init() {}
    
    public func sizeThatFits(proposal: ProposedViewSize,
                      subviews: Subviews,
                      cache: inout Void) -> CGSize {
        // Return a size.
        guard !subviews.isEmpty else { return .zero }
        
        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) { $0 + $1 }
        
        return CGSize(
            width: maxSize.width,
            height: maxSize.height * CGFloat(subviews.count) + totalSpacing)
    }
    
    public func placeSubviews(in bounds: CGRect,
                       proposal: ProposedViewSize,
                       subviews: Subviews,
                       cache: inout Void) {
        // Place child views
        guard !subviews.isEmpty else { return }
        
        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)
        
        let placementProposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
        var y = bounds.minY + maxSize.height / 2
        
        for index in subviews.indices {
            subviews[index].place(
                at: CGPoint(x: bounds.midX, y: y),
                anchor: .center,
                proposal: placementProposal)
             y += maxSize.height + spacing[index]
        }
    }
    
    private func maxSize(subviews: Subviews) -> CGSize {
        // unspecified: ideal size
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let maxSize: CGSize = subviewSizes.reduce(.zero) { currentMax, subviewSize in
            CGSize(
                width: max(currentMax.width, subviewSize.width),
                height: max(currentMax.height, subviewSize.height))
        }

        return maxSize
    }
    
    private func spacing(subviews: Subviews) -> [CGFloat] {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .vertical)
        }
    }
}


#Preview {
    EqualWidthVStack {
        Button { } label: {
            Text("first").frame(maxWidth: .infinity)
        }
        Button { } label: {
            Text("second button").frame(maxWidth: .infinity)
        }

        Button { } label: {
            Text("third").frame(maxWidth: .infinity)
        }
    }
    .buttonStyle(.borderedProminent)
}
