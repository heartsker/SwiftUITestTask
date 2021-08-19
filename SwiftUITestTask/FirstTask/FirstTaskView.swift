//
//  FirstTaskView.swift
//  SwiftUITestTask
//
//  Created by Daniel Pustotin on 18.08.2021.
//

import SwiftUI

struct FirstTaskView: View {
	@State var currentUserInteractionCellID: String?

	let swipeCellUgh = SwipeCellActionItem(buttonView: {
		VStack(spacing: 2)  {
			Image(systemName: "trash").font(.system(size: 22)).foregroundColor(.white)
			Text("Ugh").fixedSize().font(.system(size: 12)).foregroundColor(.white)
		}.frame(maxHeight: 80).castToAnyView()

	}, backgroundColor: .blue) {
		print("Ugh")
	}

	let swipeCellWithFriends = SwipeCellActionItem(buttonView: {
		VStack(spacing: 2)  {
			Image(systemName: "person.2.fill").font(.system(size: 22)).foregroundColor(.white)
			Text("With Friends").fixedSize().font(.system(size: 12)).foregroundColor(.white)
		}.frame(maxHeight: 80).castToAnyView()

	}, backgroundColor: .purple, swipeOutAction: true) {
		print("With Friends")
	}

	let swipeCellCook = SwipeCellActionItem(buttonView: {
		VStack(spacing: 2)  {
			Image(systemName: "flame").font(.system(size: 22)).foregroundColor(.black)
			Text("Cook").fixedSize().font(.system(size: 12)).foregroundColor(.black)
		}.frame(maxHeight: 80).castToAnyView()

	}, backgroundColor: .pink) {
		print("Cook")
	}

	var body: some View {
		GeometryReader { proxy in
			ScrollView {
				LazyVStack(alignment: .center, spacing: 10) {
					RowView(availableWidth: proxy.size.width - 20, item: "Apple", slots: [swipeCellUgh, swipeCellWithFriends], currentUserInteractionCellID: $currentUserInteractionCellID)
					RowView(availableWidth: proxy.size.width - 20, item: "Beef", slots: [swipeCellCook, swipeCellUgh, swipeCellWithFriends], currentUserInteractionCellID: $currentUserInteractionCellID)

					RowView(availableWidth: proxy.size.width - 20, item: "Pasta", slots: [swipeCellCook, swipeCellWithFriends], currentUserInteractionCellID: $currentUserInteractionCellID)
				}.animation(.default)
			}
		}
	}
}

struct FirstTaskView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTaskView()
    }
}
