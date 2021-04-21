import Igis
import Scenes
import Foundation

class Pendulum:  RenderableEntity, EntityMouseClickHandler {
    static let g : Double = -0.01
    let bob = Ellipse(
      center: Point(x: 0, y: 0), radiusX: 30, radiusY: 30, fillMode: .fillAndStroke
    )

    var string : Lines = Lines(from: Point(), to: Point())
    var length : Double = 0
    var angle: Double = Double.pi / 3
    var angularVelocity: Double = 0
    var angularAcceleration : Double { Pendulum.g * sin(angle) }
    
    let bobStrokeStyle = StrokeStyle(color: Color(.orange))
    let bobFillStyle = FillStyle(color: Color(.red))
    let bobLineWidth = LineWidth(width: 5)
    
    let stringStrokeStyle = StrokeStyle(color: Color(.green))
    let stringLineWidth = LineWidth(width: 5)

    var center : Point = Point()
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Pendulum")
    }
    override func setup(canvasSize: Size, canvas: Canvas) {
        center = canvasSize.center
        length = Double(min(canvasSize.width, canvasSize.height)) / 3
        dispatcher.registerEntityMouseClickHandler(handler:self)
    }
    override func teardown() {
        dispatcher.unregisterEntityMouseClickHandler(handler:self)
    }
    func onEntityMouseClick(globalLocation: Point) {
        let y = Double(globalLocation.y) - Double(center.y)
        let x = Double(globalLocation.x) - Double(center.x)
        angle = 3 * Double.pi/2 - atan(y / x)
        angularVelocity = 0
        if x >= 0 { angle += Double.pi }
    }
    override func boundingRect() -> Rect {
        return Rect(size: Size(width: Int.max, height: Int.max))
    }
    override func calculate(canvasSize: Size) {
        let renderAngle = Double.pi / 2 - angle
        let deltaX = cos(renderAngle) * length
        let deltaY = sin(renderAngle) * length
        bob.center = Point(x: center.x + Int(deltaX), y: center.y + Int(deltaY))
        string = Lines(from: center, to: bob.center)
        angularVelocity += angularAcceleration
        angle += angularVelocity
    }
    override func render(canvas: Canvas) {
        canvas.render(stringStrokeStyle, stringLineWidth, string)
        canvas.render(bobStrokeStyle, bobFillStyle, bobLineWidth, bob)
    }

}
