import Cocoa
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var levelNumber = 0
    var livesNumber = 3
    var scoreNumber = 0
    
    var direction = CGVector(dx: 0, dy: 1)
    var allowShield = true
    var shieldAvalable = false
    
    let gameArea = CGRect(x: 0, y: 0 , width: 2304 , height: 1440)
    
    let playerShip = SKSpriteNode(imageNamed: "Player")
    let chaseShip = SKSpriteNode(imageNamed: "ChaseShip")
    
    let livesLable = SKLabelNode(fontNamed: "Copperplate-Bold")
    let scoreLable = SKLabelNode(fontNamed: "Copperplate-Bold")
    let shieldLable = SKLabelNode(fontNamed: "Copperplate-Bold")
    
    
    struct PhysicsCategories {
        
        static let none: UInt32 = 0b0
        static let playerShip: UInt32 = 0b1
        static let turretMissiles: UInt32 = 0b10
        static let border: UInt32 = 0b100
        static let chaseShip: UInt32 = 0b1000
        static let playerShipMissile: UInt32 = 0b10000
        static let meteor: UInt32 = 0b100000
        static let wall: UInt32 = 0b1000000
   
    }
    
    
    override init(size: CGSize) {
        
        super.init(size: size)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        callBackground()
        
        player()
        
        walls()
        
        turret(turretPosition: CGPoint(x: 2304/2, y: 1440/2))
        
        callMeteor(duration: 4)
        
        //screenSize()
        
        addLables()
        
        //loseLife()
        
        //addScore()
        
        spawnChaseShip()
        
        shieldState(state: true)
        
        callObstacle(interval: 6)
        
        //chaseShipMissiles()

        
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var meteorNode = SKPhysicsBody()
        if contact.bodyA.categoryBitMask == UInt32(0b100000) { meteorNode = contact.bodyA }
        if contact.bodyB.categoryBitMask == UInt32(0b100000) { meteorNode = contact.bodyB }
        
        //playerShip - chaseShip
        if  contact.bodyA.categoryBitMask == UInt32(0b1) && contact.bodyB.categoryBitMask == UInt32(0b1000)
            ||
            contact.bodyA.categoryBitMask == UInt32(0b1000) && contact.bodyB.categoryBitMask == UInt32(0b1) {
            
            if playerShip.parent != nil {
                    
                explosion(location: playerShip.position)
                livesNumber = 0
                loseLife()
                
            }
        }
        
        //playerShip - meteor
        if contact.bodyA.categoryBitMask == UInt32(0b1) && contact.bodyB.categoryBitMask == UInt32(0b100000)
           ||
           contact.bodyA.categoryBitMask == UInt32(0b100000) && contact.bodyB.categoryBitMask == UInt32(0b1) {
            
            if meteorNode.node?.parent != nil {
                
                if shieldAvalable == true {
                    
                    shieldAvalable = false
                    shieldState(state: false)
                    meteorNode.node?.removeFromParent()
                }
                    
                else {
                    
                    meteorNode.node?.removeFromParent()
                    explosion(location: playerShip.position)
                    loseLife()
                }
            }
        }
        
        //playerShip - border
        if contact.bodyA.categoryBitMask == UInt32(0b1) && contact.bodyB.categoryBitMask == UInt32(0b100)
           ||
           contact.bodyA.categoryBitMask == UInt32(0b100) && contact.bodyB.categoryBitMask == UInt32(0b1) {
            
            explosion(location: playerShip.position)
            livesNumber = 0
            loseLife()
        }
        
        //playerShip - wall
        if contact.bodyA.categoryBitMask == UInt32(0b1) && contact.bodyB.categoryBitMask == UInt32(0b1000000)
            ||
            contact.bodyA.categoryBitMask == UInt32(0b1000000) && contact.bodyB.categoryBitMask == UInt32(0b1) {
            
            explosion(location: playerShip.position)
            livesNumber = 0
            loseLife()
        }
    }
    

    
    
    //PlayerMovement
       override func keyDown(with event: NSEvent) {
        
        //A
        if event.keyCode == 0 {

                if direction == CGVector(dx: 0, dy: 1) {
                    
                    direction = CGVector(dx: -1, dy: 0)
                    let angle = SKAction.rotate(byAngle: CGFloat(Double.pi / 2), duration: 0.1)
                    self.playerShip.run(angle)
                   
                    self.playerShip.physicsBody!.velocity = CGVector(dx: -200, dy: 0)
                }
                
               if direction == CGVector(dx: 1, dy: 0) {
                    
                    direction = CGVector(dx: -1, dy: 0)
                    let angle = SKAction.rotate(byAngle: CGFloat(-Double.pi), duration: 0.2)
                    self.playerShip.run(angle)
                
                    self.playerShip.physicsBody!.velocity = CGVector(dx: -200, dy: 0)
                }
                
                if direction == CGVector(dx: 0, dy: -1) {
                    
                    direction = CGVector(dx: -1, dy: 0)
                    let angle = SKAction.rotate(byAngle: CGFloat(-Double.pi / 2), duration: 0.1)
                    self.playerShip.run(angle)
                   
                    self.playerShip.physicsBody!.velocity = CGVector(dx: -200, dy: 0)
                }
        }
        
        //D
        if event.keyCode == 2 {
                
                if direction == CGVector(dx: 0, dy: 1) {
                    
                    direction = CGVector(dx: 1, dy: 0)
                    let angle = SKAction.rotate(byAngle: CGFloat(-Double.pi / 2), duration: 0.1)
                    self.playerShip.run(angle)
                    
                    self.playerShip.physicsBody!.velocity = CGVector(dx: 200, dy: 0)
                }
                
                if direction == CGVector(dx: 0, dy: -1) {
                    
                    direction = CGVector(dx: 1, dy: 0)
                    let angle = SKAction.rotate(byAngle: CGFloat(Double.pi / 2) , duration: 0.1)
                    self.playerShip.run(angle)
             
                    self.playerShip.physicsBody!.velocity = CGVector(dx: 200, dy: 0)
                }
                
                if direction == CGVector(dx: -1, dy: 0) {
                    
                    direction = CGVector(dx: 1, dy: 0)
                    let angle = SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.2)
                    self.playerShip.run(angle)
                    
                    self.playerShip.physicsBody!.velocity = CGVector(dx: 200, dy: 0)
                }
        }
        
        //W
        if event.keyCode == 13 {
                
                if direction == CGVector(dx: 1, dy: 0) {
                
                    direction = CGVector(dx: 0, dy: 1)
                    let angle = SKAction.rotate(byAngle: CGFloat(Double.pi / 2), duration: 0.1)
                    self.playerShip.run(angle)
                    
                    self.playerShip.physicsBody!.velocity = CGVector(dx: 0, dy: 200)
                    
                }
                
                if direction == CGVector(dx: 0, dy: -1) {
                    
                    direction = CGVector(dx: 0, dy: 1)
                    let angle = SKAction.rotate(byAngle: CGFloat(-Double.pi), duration: 0.2)
                    self.playerShip.run(angle)
                    
                    self.playerShip.physicsBody!.velocity = CGVector(dx: 0, dy: 200)
                }
                
                if direction == CGVector(dx: -1, dy: 0) {
                    
                    direction = CGVector(dx: 0, dy: 1)
                    let angle = SKAction.rotate(byAngle: CGFloat(-Double.pi / 2), duration: 0.1)
                    self.playerShip.run(angle)
                    
                    self.playerShip.physicsBody!.velocity = CGVector(dx: 0, dy: 200)
                }
            
                if direction == CGVector(dx: 0, dy: 1) {
                
                    self.playerShip.physicsBody!.velocity = CGVector(dx: 0, dy: 200)
                }
        }
        
        //S
        if event.keyCode == 1 {
                
                if direction == CGVector(dx: 0, dy: 1) {
                    
                    
                    direction = CGVector(dx: 0, dy: -1)
                    let angle = SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.2)
                    self.playerShip.run(angle)
                    
                    self.playerShip.physicsBody!.velocity = CGVector(dx: 0, dy: -200)
                }
                
                if direction == CGVector(dx: 1, dy: 0) {
                    
                    direction = CGVector(dx: 0, dy: -1)
                    let angle = SKAction.rotate(byAngle: CGFloat(-Double.pi / 2), duration: 0.1)
                    self.playerShip.run(angle)
                    
                    self.playerShip.physicsBody!.velocity = CGVector(dx: 0, dy: -200)
                }
                
                if direction == CGVector(dx: -1, dy: 0) {
                    
                    direction = CGVector(dx: 0, dy: -1)
                    let angle = SKAction.rotate(byAngle: CGFloat(Double.pi / 2), duration: 0.1)
                    self.playerShip.run(angle)
                    
                    self.playerShip.physicsBody!.velocity = CGVector(dx: 0, dy: -200)
                }
        }
        
        //Espaço
        if event.keyCode == 49 {
        
            self.playerShip.physicsBody!.applyImpulse(CGVector(dx: direction.dx*300, dy: direction.dy*300))
        }
        
        //E (activate shield)
        if event.keyCode == 14 {
            
            if allowShield == true { shieldAvalable = true }
        }
    }
    

    func walls() {
        
        var points = [[Float]]()
        
        //Esquerda
        for i in stride(from: -6, to: 1479, by: 33) {
            
            points.append([Float(30), Float(i)])
        }
        
        //Direita
        for i in stride(from: -6, to: 1479, by: 33) {
            
            points.append([Float(2274), Float(i)])
        }

        for n in stride(from: 0, to: points.count, by: 1) {
        
            let box = SKSpriteNode(imageNamed: "Cube33x33")
            box.position = CGPoint(x: CGFloat(points[n][0]), y: CGFloat(points[n][1]))
            box.zPosition = 1
           
            box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
            box.physicsBody?.isDynamic = false
            box.physicsBody!.collisionBitMask = PhysicsCategories.none
            box.physicsBody!.categoryBitMask = PhysicsCategories.border
            box.physicsBody!.contactTestBitMask = PhysicsCategories.playerShip
            
            self.addChild(box)
        }
    }
      func player() {
        
        let playerShipTexture = SKTexture(imageNamed: "Player")
        
        playerShip.setScale(0.8)
        playerShip.position = CGPoint(x: self.size.width/2, y: self.size.height/4)
        playerShip.zPosition = 3

        playerShip.physicsBody = SKPhysicsBody(texture: playerShipTexture, size: playerShip.size)
        playerShip.physicsBody?.isDynamic = true
        playerShip.physicsBody!.allowsRotation = false
        playerShip.physicsBody!.affectedByGravity = false
        playerShip.physicsBody!.linearDamping = 0.0
        playerShip.physicsBody!.friction = 0.0
        playerShip.physicsBody!.categoryBitMask = PhysicsCategories.playerShip
        playerShip.physicsBody!.collisionBitMask = PhysicsCategories.none
        playerShip.physicsBody!.contactTestBitMask = PhysicsCategories.chaseShip
        
        self.addChild(playerShip)
    }
    
    
    
    func background() {
        
        let background1 = SKSpriteNode(imageNamed: "Background")
        let background2 = SKSpriteNode(imageNamed: "Background")
        
            background1.setScale(1)
            background1.size = self.size
            background1.position = CGPoint(x: 2304/2, y: 1440/2)
            background1.zPosition = 0
            self.addChild(background1)
            
            background2.setScale(1)
            background2.size = self.size
            background2.position = CGPoint(x: 2304/2, y: 1440 + 1440/2)
            background2.zPosition = 0
            self.addChild(background2)
        
        let move1 = SKAction.moveTo(y: -1440/2, duration: 40)
        let delete1 = SKAction.removeFromParent()
        
        let move2 = SKAction.moveTo(y: 1440/2, duration: 40)
        let delete2 = SKAction.removeFromParent()
        
        let sequence1 = SKAction.sequence([move1, delete1])
        let sequence2 = SKAction.sequence([move2, delete2])
        
        background1.run(sequence1)
        background2.run(sequence2)
    }
    
    
    func callBackground() {
        
        let call = SKAction.run { self.background() }
        let wait = SKAction.wait(forDuration: 40)
        let sequence = SKAction.sequence([call, wait])
        
        run(SKAction.repeatForever(sequence))
    }
 
    
    func turret(turretPosition: CGPoint) {
        

