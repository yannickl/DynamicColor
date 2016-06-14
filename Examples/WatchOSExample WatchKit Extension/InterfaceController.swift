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
    let mainColor = UIColor(hexString: "#c0392b")

    return [
      ("Original", mainColor),
      ("Lighter", mainColor.lighterColor()),
      ("Darker", mainColor.darkerColor()),
      ("Saturated", mainColor.saturatedColor()),
      ("Desaturated", mainColor.desaturatedColor()),
      ("Grayscaled", mainColor.grayscaledColor()),
      ("Adjusted", mainColor.adjustedHueColor(45 / 360)),
      ("Complement", mainColor.complementColor()),
      ("Invert", mainColor.invertColor()),
      ("Mix Blue", mainColor.mixWithColor(UIColor.blue())),
      ("Mix Green", mainColor.mixWithColor(UIColor.green())),
      ("Mix Yellow", mainColor.mixWithColor(UIColor.yellow())),
      ("Tint", mainColor.tintColor()),
      ("Shade", mainColor.shadeColor())
    ]
  }()
  
  override func awake(withContext context: AnyObject?) {
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
