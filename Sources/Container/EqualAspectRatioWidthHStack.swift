//
//  EqualWidthHStack.swift
//  LayoutProject
//
//  Created by Karin Prater on 13.08.22.
//

import SwiftUI

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
struct EqualAspectRatioWidthHStack: Layout {
    
    let spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    
        let width = proposal.width ?? 0
        let height = calculateHeight(proposedWidth: width, numberOfSubviews: CGFloat(subviews.count))
        
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        
        let subviewSize = calculateHeight(proposedWidth: bounds.width, numberOfSubviews: CGFloat(subviews.count))
      let placementProposal = ProposedViewSize(width: subviewSize, height: subviewSize)
        
        var x = bounds.minX + subviewSize / 2
        
        for index in subviews.indices {
            subviews[index].place(at: CGPoint(x: x, y: bounds.midY),
                                  anchor: .center,
                                  proposal: placementProposal)
            x += subviewSize + spacing
        }
    }
    
    func calculateHeight(proposedWidth: CGFloat, numberOfSubviews: CGFloat) -> CGFloat {
        
        let totalSpacing = spacing * (numberOfSubviews - 1)
        
        return (proposedWidth - totalSpacing) / numberOfSubviews
    }
    
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
#Preview {
    EqualAspectRatioWidthHStack(spacing: 10) {
        Group {
            Color.red
            Color.orange
            Color.yellow
        }
    }
}


