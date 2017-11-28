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
                let turret = SKSpriteNode(imageNamed: "Turret")
        let turretPlatf = SKSpriteNode(imageNamed: "Platform")
        
        turret.setScale(1.0)
        turret.position = turretPosition
        turret.zPosition = 3
        self.addChild(turret)
        
        turretPlatf.setScale(2.0)
        turretPlatf.position = turretPosition
        turretPlatf.zPosition = 2
        self.addChild(turretPlatf)
        
        let rotate = SKAction.run {
            
            let deltaX = turretPosition.x - self.playerShip.position.x
            let deltaY = turretPosition.y - self.playerShip.position.y
            let angle = atan2(deltaY, deltaX)
            turret.zRotation = angle + CGFloat(Double.pi / 2)
            
            //update shield position and chaseShip position (reuse of code)
           
            if self.shieldAvalable == true { self.playerShield() }
            self.chaseShip.position = CGPoint(x: self.playerShip.position.x, y: 0)
        }
        
        let wait = SKAction.wait(forDuration: 0.0167)
        let sequence = SKAction.sequence([rotate, wait])
        run(SKAction.repeatForever(sequence))
        
      //  turretmissile(turretPosition: turretPosition)
    }
    
    
    func turretmissile(turretPosition: CGPoint) {
        
        let turretMissile = SKSpriteNode(imageNamed: "turretMissile")
        let turretMissileTexture = SKTexture(imageNamed: "turretMissile")
        
        let spawnTurretMissile = SKAction.run {
            
            let deltaX = Int(turretPosition.x - self.playerShip.position.x)
            let deltaY = Int(turretPosition.y - self.playerShip.position.y)
            let distance = sqrt(Double(abs(deltaX)^2 + abs(deltaY)^2))
            
            if Int(distance) <= 20 {
                
                turretMissile.setScale(1.0)
                turretMissile.position = turretPosition
                turretMissile.zPosition = 3
                
                turretMissile.physicsBody = SKPhysicsBody(texture: turretMissileTexture, size: turretMissile.size)
                turretMissile.physicsBody!.affectedByGravity = false
                turretMissile.physicsBody!.categoryBitMask = PhysicsCategories.turretMissiles
                turretMissile.physicsBody!.collisionBitMask = PhysicsCategories.none
                turretMissile.physicsBody!.contactTestBitMask = PhysicsCategories.playerShip
                
                self.addChild(turretMissile)
                
                let angle = atan2(CGFloat(deltaY), CGFloat(deltaX))
                turretMissile.zRotation = angle + CGFloat(Double.pi / 2)
                
                let move = SKAction.move(to: CGPoint(x: self.playerShip.position.x, y: self.playerShip.position.y), duration: 0.4)
                turretMissile.run(move)
            }
        }
        
        let delete = SKAction.run { turretMissile.removeFromParent() }
        let waitForMissile = SKAction.wait(forDuration: 0.8)
        let missileSequence = SKAction.sequence([spawnTurretMissile, waitForMissile, delete])
        
        run(SKAction.repeatForever(missileSequence))
    }
    
    
    func meteorr() {
        
        let meteor = SKSpriteNode(imageNamed: "Meteor")
        let meteorTexture = SKTexture(imageNamed: "Meteor")
        let randomTop = CGPoint(x: self.random(min: 70, max: 2234), y: 1440)
        let randomBottom = CGPoint(x: self.random(min: 70, max: 2234), y: 0)
        
        let deltaX = randomTop.x - randomBottom.x
        let deltaY = randomTop.y - randomBottom.y
        let angle = atan2(deltaY, deltaX)
        
        meteor.setScale(4)
        meteor.position = randomTop
        meteor.zPosition = 3
        meteor.zRotation = angle - CGFloat(Double.pi / 2)
        
        meteor.physicsBody = SKPhysicsBody(texture: meteorTexture, size: meteor.size)
        meteor.physicsBody!.categoryBitMask = PhysicsCategories.meteor
        meteor.physicsBody!.collisionBitMask = PhysicsCategories.none
        meteor.physicsBody!.contactTestBitMask = PhysicsCategories.playerShip
        
        self.addChild(meteor)
        
        let moveTo = SKAction.move(to: randomBottom, duration: 2)
        let delete = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveTo, delete])
      
        meteor.run(sequence)
    }
    
    
    func callMeteor(duration: Int) {
        
        let call = SKAction.run { self.meteorr() }
        let duration = SKAction.wait(forDuration: TimeInterval(duration))
        let sequence = SKAction.sequence([call, duration])
        
        run(SKAction.repeatForever(sequence))
    }
    

    func screenSize() -> (Int, Int){
            
        let scrn: NSScreen = NSScreen.main!
        let rect: NSRect = scrn.frame
        let height = rect.size.height
        let width = rect.size.width
            
        print(Int(width), Int(height))
        return (Int(width), Int(height))
    }
    
    
    func random(min: Int, max: Int) -> Int {
        
        return Int(arc4random_uniform(UInt32(max - min))) + min
        
        //return random(min: min, max: max)
    }
    
    
    func playerShield() {
        
        let shield = SKSpriteNode(imageNamed: "Shield")
            
        shield.setScale(3)
        shield.position = playerShip.position
        shield.zPosition = 3
        self.addChild(shield)
    
        let wait = SKAction.wait(forDuration: 0.013)
        let delete = SKAction.removeFromParent()
        let sequence = SKAction.sequence([wait, delete])
        
        shield.run(sequence)
    }
    
    
    func addLables() {
    
        scoreLable.text = "Score: 0"
        scoreLable.fontSize = 50
        scoreLable.fontColor = SKColor.white
        scoreLable.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLable.position = CGPoint(x: 90, y: 1380)
        scoreLable.zPosition = 100
        self.addChild(scoreLable)
    
        livesLable.text = "Lives: 3"
        livesLable.fontSize = 50
        livesLable.fontColor = SKColor.white
        livesLable.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        livesLable.position = CGPoint(x: 90, y: 1340)
        livesLable.zPosition = 100
        self.addChild(livesLable)
        
        shieldLable.text = "Shield: OFFLINE"
        shieldLable.fontSize = 50
        shieldLable.fontColor = SKColor.white
        shieldLable.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        shieldLable.position = CGPoint(x: 90, y: 1300)
        shieldLable.zPosition = 100
        self.addChild(shieldLable)
        
    }
 
    
    func loseLife() {
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        
        if livesNumber == 0 {
            
            playerShip.removeFromParent()
            
            livesLable.text = " Lives: \(livesNumber)"
            
            livesLable.run(scaleSequence)
        }
        
        else {
        
            livesNumber -= 1
            livesLable.text = " Lives: \(livesNumber)"
        
            livesLable.run(scaleSequence)
            
            if livesNumber == 0 { playerShip.removeFromParent() }
        }
    }
    
    
    func addScore() {
        
        scoreNumber += 1
        scoreLable.text = "Score: \(scoreNumber)"
    }
    
    
    func shieldState(state: Bool) {
        
        if state == true { shieldLable.text = "Shield: \("online")" }
        
        else { shieldLable.text = "Shield: \("offline")"  }
    }
    
    
    func explosion(location: CGPoint) {
        
        let explosion = SKSpriteNode(imageNamed: "Explosion")
        let explosionsound = SKAction.playSoundFileNamed("Explosion.wav", waitForCompletion: false)
        
        explosion.position = location
        explosion.zPosition = 3
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(by: 4, duration: 0.2)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        let explosionSequence = SKAction.sequence([explosionsound, scaleIn, fadeOut, delete])
        
        explosion.run(explosionSequence)
    }
    
    
    func spawnChaseShip() {
        
        let chaseShipTexture = SKTexture(imageNamed: "Player")
        
        chaseShip.setScale(1.5)
        self.chaseShip.position = CGPoint(x: self.playerShip.position.x, y: 0)
        chaseShip.zPosition = 3
        chaseShip.physicsBody = SKPhysicsBody(texture: chaseShipTexture, size: chaseShip.size)
        chaseShip.physicsBody!.affectedByGravity = false
        chaseShip.physicsBody!.isDynamic = true
        chaseShip.physicsBody!.categoryBitMask = PhysicsCategories.chaseShip
        chaseShip.physicsBody!.collisionBitMask = PhysicsCategories.none
        chaseShip.physicsBody!.contactTestBitMask = PhysicsCategories.playerShip
        self.addChild(chaseShip)
    }
 
    
    func addObstacle(interval: Int) {
        
        var points = [[Float]]()
        
        let pointA = random(min: 0, max: 68 - 14)
        
        //Esquerda
        for i in stride(from: 63, to: pointA * 33, by: 33){
            
            points.append([Float(i), Float(1473)])
        }
        
        //Direita
        for i in stride(from: 63 + pointA * 33 + 462, to: 2274, by: 33){
            
            points.append([Float(i), Float(1473)])
        }
        
        for n in stride(from: 0, to: points.count, by: 1) {
            
            let box = SKSpriteNode(imageNamed: "Cube33x33")
            box.position = CGPoint(x: CGFloat(points[n][0]), y: CGFloat(points[n][1]))
            box.zPosition = 1
            
            box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
            box.physicsBody?.isDynamic = false
            box.physicsBody!.categoryBitMask = PhysicsCategories.wall
            box.physicsBody!.collisionBitMask = PhysicsCategories.none
            box.physicsBody!.contactTestBitMask = PhysicsCategories.playerShip
        
            self.addChild(box)
            
            let move = SKAction.moveTo(y: -33, duration: TimeInterval(interval - 1))
            let delete = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, delete])
            box.run(sequence)
        }
    }
    
    
    func callObstacle(interval: Int) {
        
        let call = SKAction.run { self.addObstacle(interval: interval) }
        let wait = SKAction.wait(forDuration: TimeInterval(interval))
        let sequence = SKAction.sequence([call, wait])
        
        run(SKAction.repeatForever(sequence))
    }
    
}



