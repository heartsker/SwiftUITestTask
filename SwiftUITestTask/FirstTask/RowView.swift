//
//  RowView.swift
//  SwiftUITestTask
//
//  Created by Daniel Pustotin on 20.08.2021.
//

import SwiftUI

struct RowView: View {
	var availableWidth: CGFloat
	var item: String
	let slots: [SwipeCellActionItem]
	@Binding var currentUserInteractionCellID: String?

	var body: some View {
		Text(item).frame(width: availableWidth, height:100)
			.background(RoundedRectangle(cornerRadius: 5).foregroundColor(.orange))
			.swipeCell(id: self.item, cellWidth: availableWidth, trailingSideGroup: slots, currentUserInteractionCellID: $currentUserInteractionCellID, settings: SwipeCellSettings())
			.onTapGesture {
				self.currentUserInteractionCellID = item
			}
	}
}
