import DynamicColor

/*: ### Reference color */
let ref = DynamicColor(hexString: "#c0392b")

/*: ### Derivated colors */
ref.lighter()
ref.darkened()
ref.saturated()
ref.desaturated()
ref.grayscaled()
ref.adjustedHue(amount: 45)
ref.complemented()
ref.inverted()
ref.mixed(withColor: #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1))
ref.mixed(withColor: #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1))
ref.mixed(withColor: #colorLiteral(red: 1, green: 1, blue: 0, alpha: 1))
ref.tinted()
ref.shaded()

/*: ### Color space components */
ref.toRGBAComponents()
ref.toHSLComponents()
ref.toXYZComponents()
ref.toLabComponents()

/*: ### Gradients */
[#colorLiteral(red: 0.2193539292, green: 0.4209204912, blue: 0.1073316187, alpha: 1), #colorLiteral(red: 0.9446166754, green: 0.6509571671, blue: 0.1558967829, alpha: 1)].gradient.colorPalette(amount: 5)
DynamicColor(red: 0.219, green: 0.421, blue: 0.107, alpha: 1)
DynamicColor(red: 0.703, green: 0.574, blue: 0.14, alpha: 1)
DynamicColor(red: 0.945, green: 0.651, blue: 0.156, alpha: 1)
[#colorLiteral(red: 0.2193539292, green: 0.4209204912, blue: 0.1073316187, alpha: 1), #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.1991284192, green: 0.6028449535, blue: 0.9592232704, alpha: 1)].gradient.pickColorAt(scale: 0.8)
