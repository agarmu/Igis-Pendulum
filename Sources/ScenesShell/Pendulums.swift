import Igis
import Scenes

class Pendulums : RenderableEntity, MouseDownHandler {
    let xCount: Int = 15
    let yCount : Int = 10
    var pendulums : [Pendulum] = []
    init() {
        super.init(name: "Pendulums")
    }
    override func setup(canvasSize: Size, canvas: Canvas) {
        let dx : Int = 10 //canvasSize.width / (xCount + 1)
        let dy : Int = 10 //canvasSize.height / (yCount + 1)
        let length = Double(min(dx, dy)) * 100
        for i in 1...xCount {
            let x = i * dx + canvasSize.width / 2 - xCount / 2 * dx
            for j in 1...yCount {
                let y = j * dy
                let p = Pendulum(at: Point(x: x, y: y), length: length)
                p.point(at: Point(x: canvasSize.width * 5 / 8, y: canvasSize.height))
                pendulums.append(p)
            }
        }
        dispatcher.registerMouseDownHandler(handler: self)
    }
    override func teardown() {
        dispatcher.unregisterMouseDownHandler(handler: self)
    }
    func onMouseDown(globalLocation: Point) {
        self.pendulums.forEach { $0.point(at: globalLocation) }
    }
    
    override func calculate(canvasSize: Size) {
        self.pendulums.forEach { $0.calculate(canvasSize: canvasSize) }
    }
    override func render(canvas: Canvas) {
        self.pendulums.forEach { $0.render(canvas: canvas) }
    }
}
