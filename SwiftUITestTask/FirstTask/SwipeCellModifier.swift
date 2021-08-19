//
//  SwipeCellModifier.swift
//  SwiftUITestTask
//
//  Created by Daniel Pustotin on 19.08.2021.
//

import SwiftUI

public struct SwipeCellModifier: ViewModifier {
	var id: String
	var cellWidth: CGFloat = UIScreen.main.bounds.width
	var trailingSideGroup: [SwipeCellActionItem] = []
	@Binding var currentUserInteractionCellID: String?
	var settings: SwipeCellSettings = SwipeCellSettings()

	@State private var offsetX: CGFloat = 0

	@State private var openSideLock: SwipeGroupSide?

	public func body(content: Content) -> some View {

		ZStack {

			if self.trailingSideGroup.isEmpty == false && self.offsetX != 0 {
				self.swipeToRevealArea(swipeItemGroup: self.trailingSideGroup, side: .trailing)
			}

			content
				.offset(x: self.offsetX)
				.gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local).onChanged(self.dragOnChanged(value:)).onEnded(dragOnEnded(value:)))

		}.frame(width: cellWidth)
		.edgesIgnoringSafeArea(.horizontal)
		.clipped()
		.onChange(of: self.currentUserInteractionCellID) { (_) in
			if let currentDragCellID = self.currentUserInteractionCellID, currentDragCellID != self.id && self.openSideLock != nil {
				// if this cell has an open side area and is not the cell being dragged, close the cell
				self.setOffsetX(value: 0)
				// reset the drag cell id to nil
				self.currentUserInteractionCellID = nil
			}
		}

	}

	func swipeToRevealArea(swipeItemGroup: [SwipeCellActionItem], side:SwipeGroupSide)->some View {

		HStack {
			Spacer()

			ZStack {
				HStack(spacing:0) {
					ForEach(swipeItemGroup) { item in

						Button {
							self.setOffsetX(value: 0)
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
								item.actionCallback()
							}
						} label: {
							self.buttonContentView(item: item, group: swipeItemGroup, side: side)
						}

					}
				}
			}.opacity(self.swipeRevealAreaOpacity())
		}

	}

	func buttonContentView(item:SwipeCellActionItem, group: [SwipeCellActionItem], side: SwipeGroupSide)->some View {
		ZStack {
			item.backgroundColor

			HStack {
				item.buttonView()
			}

		}.frame(width: self.itemButtonWidth(item: item, itemGroup: group))
	}

	func menuWidth()->CGFloat {
		self.trailingSideGroup.map({$0.buttonWidth}).reduce(0, +)
	}

	//MARK: drag gesture

	func dragOnChanged(value: DragGesture.Value) {
		let horizontalTranslation = value.translation.width
		if self.nonDraggableCondition(horizontalTranslation: horizontalTranslation){
			return
		}

		if self.openSideLock != nil {
			// if one side is open, we need to add the menu width!
			let menuWidth = self.menuWidth()
			self.offsetX = menuWidth * openSideLock!.sideFactor + horizontalTranslation
			return
		}

		self.currentUserInteractionCellID = self.id
		self.offsetX =  horizontalTranslation

	}

	func nonDraggableCondition(horizontalTranslation: CGFloat)->Bool {
		return self.offsetX == 0 && (horizontalTranslation > 0 || self.trailingSideGroup.isEmpty && horizontalTranslation < 0)
	}

	func dragOnEnded(value: DragGesture.Value) {

		let swipeOutTriggerValue =  self.cellWidth * self.settings.swipeOutTriggerRatio

		if self.offsetX == 0 {
			self.openSideLock = nil
		}
		else if self.offsetX > 0 {
			// leading group emtpy
			self.setOffsetX(value: 0)
		}

		else if self.offsetX < 0 {
			if self.trailingSideGroup.isEmpty == false {
				if self.offsetX.magnitude < settings.openTriggerValue || (self.openSideLock == .trailing && self.offsetX > -self.menuWidth() * 0.8) {
					self.setOffsetX(value: 0)
				}
				else if let rightItem = self.trailingSideGroup.filter({$0.swipeOutAction == true}).first,  self.offsetX.magnitude > swipeOutTriggerValue {
					self.swipeOutAction(item: rightItem, sideFactor: -1)
				}
				else {
					self.lockSideMenu(side: .trailing)
				}
			} else {
				self.setOffsetX(value: 0)
			}
		}
	}

	func swipeOutAction(item: SwipeCellActionItem, sideFactor: CGFloat) {
		self.setOffsetX(value: 0)

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			item.actionCallback()
		}
	}

	func lockSideMenu(side: SwipeGroupSide) {
		self.setOffsetX(value:  side.sideFactor * self.menuWidth())
		self.openSideLock = side
	}

	func setOffsetX(value: CGFloat) {
		withAnimation(.spring()) {
			self.offsetX = value
		}
		if self.offsetX == 0 {
			self.openSideLock = nil
		}
	}

	func itemButtonWidth(item: SwipeCellActionItem, itemGroup: [SwipeCellActionItem])->CGFloat {
		let dynamicButtonWidth = self.dynamicButtonWidth(item: item, itemCount:itemGroup.count)
		let triggerValue  = self.cellWidth * settings.swipeOutTriggerRatio
		let swipeOutActionCondition = self.offsetX < -triggerValue

		if item.swipeOutAction && swipeOutActionCondition {
			return self.offsetX.magnitude + settings.addWidthMargin
		} else if swipeOutActionCondition && item.swipeOutAction == false && itemGroup.contains(where: {$0.swipeOutAction == true}) {
			return 0
		} else {
			return dynamicButtonWidth
		}

	}

	func dynamicButtonWidth(item: SwipeCellActionItem, itemCount: Int)->CGFloat {
		let menuWidth = self.menuWidth()
		return (self.offsetX.magnitude + settings.addWidthMargin ) * (item.buttonWidth  / menuWidth)
	}

	func warnSwipeOutCondition(side: SwipeGroupSide, hasSwipeOut: Bool)->Bool {
		if hasSwipeOut == false {
			return false
		}
		let triggerValue  = self.cellWidth * settings.swipeOutTriggerRatio
		return self.offsetX < -triggerValue
	}


	func swipeRevealAreaOpacity()->Double {
		self.offsetX < -5 ? 1 : 0
	}
}

public extension View {

	func swipeCell(id:String = UUID().uuidString, cellWidth: CGFloat = UIScreen.main.bounds.width, trailingSideGroup: [SwipeCellActionItem], currentUserInteractionCellID: Binding<String?>, settings: SwipeCellSettings = SwipeCellSettings())->some View {
		self.modifier(SwipeCellModifier(id: id, cellWidth: cellWidth, trailingSideGroup: trailingSideGroup, currentUserInteractionCellID: currentUserInteractionCellID, settings: settings))
	}
}

public extension View {
	func castToAnyView()->AnyView {
		return AnyView(self)
	}
}
