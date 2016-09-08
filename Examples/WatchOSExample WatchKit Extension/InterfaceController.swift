//
//  InterfaceController.swift
//  WatchOSExample Extension
//
//  Created by Yannick LORIOT on 29/10/15.
//  Copyright © 2015 Yannick LORIOT. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
  @IBOutlet var tableView: WKInterfaceTable!

  private lazy var colors: [(String, UIColor)] = {
    let mainColor = DynamicColor(hexString: "#c0392b")

    return [
      ("Original", mainColor),
      ("Lighter", mainColor.lighter()),
      ("Darkened", mainColor.darkened()),
      ("Saturated", mainColor.saturated()),
      ("Desaturated", mainColor.desaturated()),
      ("Grayscaled", mainColor.grayscaled()),
      ("Adjusted", mainColor.adjustedHue(amount: 45)),
      ("Complemented", mainColor.complemented()),
      ("Inverted", mainColor.inverted()),
      ("Mix Blue", mainColor.mixed(withColor: .blue)),
      ("Mix Green", mainColor.mixed(withColor: .green)),
      ("Mix Yellow", mainColor.mixed(withColor: .yellow)),
      ("Tinted", mainColor.tinted()),
      ("Shaded", mainColor.shaded())
    ]
  }()

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)

    // Configure interface objects here.
    tableView.setNumberOfRows(colors.count, withRowType: "ColorRow")

    for (index, (identifier, color)) in colors.enumerated() {
      if let cell = tableView.rowController(at: index) as? RowController {
        cell.colorNameLabel.setText(identifier)
        cell.colorView.setBackgroundColor(color)
      }
    }
  }
}
