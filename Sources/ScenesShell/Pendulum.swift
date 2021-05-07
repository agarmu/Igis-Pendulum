import Igis
import Scenes
import Foundation

class Pendulum:  RenderableEntity {
    static let g : Double = -0.03
    static let drag : Double = 0.98
    let bob = Ellipse(
      center: Point(x: 0, y: 0), radiusX: 10, radiusY: 10, fillMode: .fillAndStroke
    )

    var string : Lines = Lines(from: Point(), to: Point())
    var length : Double
    var angle: Double = Double.random(in:(Double.pi * -0.97)...(Double.pi * 0.97))
    var angularVelocity: Double = 0
    var angularAcceleration : Double { Pendulum.g * sin(angle) }
    
    let bobStrokeStyle = StrokeStyle(color: Color(.orange))
    let bobFillStyle = FillStyle(color: Color(.red))
    let bobLineWidth = LineWidth(width: 2)
    
    let stringStrokeStyle = StrokeStyle(color: Color(.green))
    let stringLineWidth = LineWidth(width: 1)

    var location : Point
    init(at location: Point, length: Double, name: String = "Pendulum") {
        // Using a meaningful name can be helpful for debugging
        self.location = location
        self.length = length
        super.init(name:name)
    }
    func point(at toLocation: Point) {
        let y = Double(toLocation.y) - Double(location.y)
        let x = Double(toLocation.x) - Double(location.x)
        angle = 3 * Double.pi/2 - atan(y / x)
        angularVelocity = 0
        if x >= 0 { angle += Double.pi }
    }
    override func calculate(canvasSize: Size) {
        let renderAngle = Double.pi / 2 - angle
        let deltaX = cos(renderAngle) * length / 10.0
        let deltaY = sin(renderAngle) * length / 10.0
        bob.center = Point(x: location.x + Int(deltaX), y: location.y + Int(deltaY))
        string = Lines(from: location, to: bob.center)
        angularVelocity += angularAcceleration
        angle += angularVelocity
        angularVelocity *= Pendulum.drag
    }
    override func render(canvas: Canvas) {
        canvas.render(stringStrokeStyle, stringLineWidth, string)
    //    canvas.render(bobStrokeStyle, bobFillStyle, bobLineWidth, bob)
    }
}
