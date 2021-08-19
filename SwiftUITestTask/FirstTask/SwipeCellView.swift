//
//  SwipeCellView.swift
//  SwiftUITestTask
//
//  Created by Daniel Pustotin on 20.08.2021.
//

import SwiftUI

public enum SwipeGroupSide {

	var sideFactor: CGFloat {
		switch self {
		case .trailing:
			return -1
		}
	}

	case trailing
}


public struct SwipeCellActionItem: Identifiable {

	public var id: String
	public var buttonView: ()->AnyView
	public var buttonWidth: CGFloat
	public var backgroundColor: Color
	public var swipeOutAction: Bool
	public var actionCallback: ()->()

	public init(id: String = UUID().uuidString, buttonView: @escaping ()->AnyView, swipeOutButtonView: (()->AnyView)? = nil, buttonWidth: CGFloat = 75, backgroundColor: Color, swipeOutAction: Bool = false, swipeOutHapticFeedbackType: UINotificationFeedbackGenerator.FeedbackType? = nil, swipeOutIsDestructive: Bool = true, actionCallback: @escaping ()->() ){
		self.id = id
		self.buttonView = buttonView
		self.buttonWidth = buttonWidth
		self.backgroundColor = backgroundColor
		self.swipeOutAction = swipeOutAction
		self.actionCallback = actionCallback
	}
}

public struct SwipeCellSettings {
	public init(openTriggerValue: CGFloat = 60, swipeOutTriggerRatio: CGFloat =  0.7, addWidthMargin: CGFloat = 5 ){
		self.openTriggerValue = openTriggerValue
		self.swipeOutTriggerRatio = swipeOutTriggerRatio
		self.addWidthMargin = addWidthMargin
	}
	public var openTriggerValue: CGFloat
	public var swipeOutTriggerRatio: CGFloat = 0.7
	public var addWidthMargin: CGFloat = 5
}
