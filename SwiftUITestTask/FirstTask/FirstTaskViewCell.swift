//
//  FirstTaskCellView.swift
//  SwiftUITestTask
//
//  Created by Daniel Pustotin on 19.08.2021.
//

import SwiftUI

struct FirstTaskCellView: View {
	let string: String

    var body: some View {
		HStack(spacing: 16) {
			Image(systemName: "rotate.3d")
				.resizable()
				.scaledToFit()
				.foregroundColor(.secondary)
				.frame(height: 60)

			Text(string)
				.fontWeight(.semibold)

			Spacer()

		}.padding()
    }
}

struct FirstTaskCellView_Previews: PreviewProvider {
    static var previews: some View {
		FirstTaskCellView(string: String("Apple"))
    }
}
