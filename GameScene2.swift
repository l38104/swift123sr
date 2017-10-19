import Cocoa
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameArea = CGRect(x: 0, y: 0 , width: 2304 , height: 1440)
    
    let playerShip = SKSpriteNode(imageNamed: "Player")

    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        //let randomX = random(min: 0, max: playableWidth)
        //let randomY = random(min: 0, max: playableHeight)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
   
        background()
        
        player()
        
        walls()
    }
    
    //PlayerMovement
       override func keyDown(with event: NSEvent) {
        
        //A
        if event.keyCode == 0 {
            let action = SKAction.moveTo(x: playerShip.position.x - 10.0, duration: 0.06)
            playerShip.run(action)
        
        }
        
        //D
        if event.keyCode == 2 {
            let action = SKAction.moveTo(x: playerShip.position.x + 10.0, duration: 0.06)
            playerShip.run(action)
        }
        
        //W
        if event.keyCode == 13 {
        
            let action = SKAction.moveTo(y: playerShip.position.y + 10.0, duration: 0.06)
            playerShip.run(action)
        }
        
        //S
        if event.keyCode == 1 {
            let action = SKAction.moveTo(y: playerShip.position.y - 10.0, duration: 0.06)
            playerShip.run(action)
        }
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) * 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    

    

    func walls() {
    
        var points = [[Float]]()
        
        for i in stride(from: 30, to: 2307, by: 33){
            
            points.append([Float(i), Float(27)])
        }
        
        for i in stride(from: 30, to: 2307, by: 33){
            
            points.append([Float(i), Float(1413)])
        }
        
        for i in stride(from: 27, to: 1446, by: 33) {
            
            points.append([Float(30), Float(i)])
        }
        
        for i in stride(from: 27, to: 1446, by: 33) {
            
            points.append([Float(2274), Float(i)])
        }
    
        for n in stride(from: 0, to: points.count, by: 1 ) {
        
            let box = SKSpriteNode(imageNamed: "Cube33x33")
            
            box.position = CGPoint(x: CGFloat(points[n][0]), y: CGFloat(points[n][1]))
        
            box.zPosition = 1
        
            self.addChild(box)
        }
    }

    func player() {
        
        let playerShipTexture = SKTexture(imageNamed: "Player")
        
        playerShip.setScale(1)
        playerShip.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        playerShip.zPosition = 3
        self.addChild(playerShip)
        
        playerShip.physicsBody = SKPhysicsBody(texture: playerShipTexture, size: playerShip.size)
        playerShip.physicsBody!.affectedByGravity = false
        playerShip.physicsBody?.applyForce(CGVector(dx: 0, dy: 2500))

    }
    
    func background() {
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.setScale(0.1)
        background.size = self.size
        background.position = CGPoint(x: 2304/2, y: 1440/2)
        background.zPosition = 0
        self.addChild(background)
    }
}
