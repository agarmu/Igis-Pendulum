import Scenes
import Igis
/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */

class InteractionLayer: Layer {
    var pendulums : Pendulums = Pendulums()
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name: "Interaction")
        
        // We insert our RenderableEntities in the constructor
        insert(entity: pendulums, at: .front)
    }
}
