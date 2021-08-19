//
//  SecondTaskView.swift
//  SwiftUITestTask
//
//  Created by Daniel Pustotin on 18.08.2021.
//

import SwiftUI
import AVFoundation

var player: AVAudioPlayer!

struct SecondTaskView: View {

	@State var playing = false

	init() {
		let url = Bundle.main.url(forResource: "audio", withExtension: "mp3")
		player = try! AVAudioPlayer(contentsOf: url!)
	}


	var body: some View {
		Button(action: {}) {
			Text("Hello, world!")
				.foregroundColor(.black)
				.font(.largeTitle)
				.padding()
				.background(Color.blue)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
							.onChanged {_ in
								if !playing {
									playing = true
									player.play()
								}
							}
							.onEnded {_ in
								if playing {
									playing = false
									player.stop()
								}
							})
		}

	}
}

struct SecondTaskView_Previews: PreviewProvider {
	static var previews: some View {
		SecondTaskView()
	}
}
