//
//  TaskSwitchView.swift
//  SwiftUITestTask
//
//  Created by Daniel Pustotin on 18.08.2021.
//

import SwiftUI

struct TaskSwitchView: View {

	var body: some View {
		NavigationView {
			VStack {
				Spacer()

				NavigationLink(
					destination: FirstTaskView(),
					label: {
						Text("Task 1")
							.font(.largeTitle)
					})

				Spacer()

				NavigationLink(
					destination: SecondTaskView(),
					label: {
						Text("Task 2")
							.font(.largeTitle)
					})

				Spacer()
			}
		}
	}
}

struct TaskSwitchView_Previews: PreviewProvider {
	static var previews: some View {
		TaskSwitchView()
	}
}
