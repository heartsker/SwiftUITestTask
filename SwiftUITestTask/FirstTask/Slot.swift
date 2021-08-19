//
//  Slot.swift
//  SwiftUITestTask
//
//  Created by Daniel Pustotin on 19.08.2021.
//

import SwiftUI

public struct Slot: Identifiable {

	public let id = UUID()
	public let image: () -> Image
	public let title: () -> AnyView
	public let action: () -> Void
	public let style: SlotStyle

	public init(
		image : @escaping () -> Image,
		title : @escaping () -> AnyView,
		action: @escaping () -> Void,
		style : SlotStyle
	) {
		self.image = image
		self.title = title
		self.action = action
		self.style = style
	}
}

public struct SlotStyle {
	/// Background color of slot.
	public let background: Color
	/// Image tint color
	public let imageColor: Color
	/// Individual slot width
	public let slotWidth: CGFloat

	public init(background: Color, imageColor: Color = .white, slotWidth: CGFloat = 100) {
		self.background = background
		self.imageColor = imageColor
		self.slotWidth = slotWidth
	}
}
