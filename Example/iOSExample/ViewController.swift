//
//  ViewController.swift
//  DynamicColorExample
//
//  Created by Yannick LORIOT on 01/06/15.
//  Copyright (c) 2015 Yannick LORIOT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
  private let ColorCellIdentifier = "ColorCell"

  @IBOutlet weak var colorCollectionView: UICollectionView!

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
      ("Mix Blue", mainColor.mixWithColor(UIColor.blueColor())),
      ("Mix Green", mainColor.mixWithColor(UIColor.greenColor())),
      ("Mix Yellow", mainColor.mixWithColor(UIColor.yellowColor())),
      ("Tint", mainColor.tintColor()),
      ("Shade", mainColor.shadeColor())
    ]
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    colorCollectionView.reloadData()
  }

  // MARK: - UICollectionView DataSource Methods

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return colors.count
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ColorCellIdentifier, forIndexPath: indexPath) as! ColorCellView

    let (title, color) = colors[indexPath.row]

    cell.titleLabel?.text           = title
    cell.colorView?.backgroundColor = color

    return cell
  }
}

