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
ref.mixed(color: .blue())
ref.mixed(color: .green())
ref.mixed(color: .yellow())
ref.tinted()
ref.shaded()

/*: ### Color space components */
ref.toRGBAComponents()
ref.toHSLComponents()
ref.toXYZComponents()
ref.toLabComponents()

/*: ### Gradients */
//[#colorLiteral(red: 0.2193539292, green: 0.4209204912, blue: 0.1073316187, alpha: 1), #colorLiteral(red: 0.9446166754, green: 0.6509571671, blue: 0.1558967829, alpha: 1)].colors(amount: 3)
[#colorLiteral(red: 0.2193539292, green: 0.4209204912, blue: 0.1073316187, alpha: 1), #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.1991284192, green: 0.6028449535, blue: 0.9592232704, alpha: 1)].colorAt(scale: 0.8)
