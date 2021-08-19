//
//  FirstTaskView.swift
//  SwiftUITestTask
//
//  Created by Daniel Pustotin on 18.08.2021.
//

import SwiftUI

struct swipableView: View {
	let string: String
	let slots: [Slot]

	var body: some View {
		FirstTaskCellView(string: string)
			.frame(height: 60)
			.padding()
			.onSwipe(trailing: slots)
	}
}

struct FirstTaskView: View {

	let slotRedList = Slot(image: {
			Image(systemName: "circle.lefthalf.fill")
		}, title: {
			Text("Red list")
				.foregroundColor(.white)
				.embedInAnyView()
		}, action: {
			print("Put in red list")
		}, style:
			.init(background: .red)
	)

	let slotYellowList = Slot(image: {
		Image(systemName: "circle.lefthalf.fill")
	}, title: {
		Text("Yellow list")
			.foregroundColor(.black)
			.embedInAnyView()
	}, action: {
		print("Put in yellow list")
	}, style:
		.init(background: .yellow)
	)

	let slotYammyList = Slot(image: {
		Image(systemName: "circle.lefthalf.fill")
	}, title: {
		Text("Yammy list")
			.foregroundColor(.white)
			.embedInAnyView()
	}, action: {
		print("Put in yammy list")
	}, style:
		.init(background: .blue)
	)

	let slotFooList = Slot(image: {
		Image(systemName: "circle.lefthalf.fill")
	}, title: {
		Text("Foo list")
			.foregroundColor(.white)
			.embedInAnyView()
	}, action: {
		print("Put in foo list")
	}, style:
		.init(background: .green)
	)

	var items: [AnyView] {
		let slotsForApple = [slotRedList, slotYellowList, slotFooList]
		let slotsForBanana = [slotYellowList, slotYammyList]
		return [
			swipableView(string: "Apple", slots: slotsForApple).embedInAnyView(),
			swipableView(string: "Banana", slots: slotsForBanana).embedInAnyView()
		]
	}

	var body: some View {
		NavigationView {
			List {
				ForEach(items.indices, id: \.self) { idx in
					self.items[idx]
				}.listRowInsets(EdgeInsets())
			}.navigationBarTitle("Try out different swipes")
		}
	}
}

struct FirstTaskView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTaskView()
    }
}
