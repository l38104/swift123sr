atum

import Cocoa
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var direction = CGVector(dx: 0, dy: 1)
    
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
        
        //addWall()
        
        genarateMap()
        
        turretmissile()
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
        //Espao
        if event.keyCode == 49 {
        
            self.playerShip.physicsBody!.applyImpulse(CGVector(dx: direction.dx*300, dy: direction.dy*300))
        }
        
        //E (Start moving)
        if event.keyCode == 14 {
            
            self.playerShip.physicsBody!.velocity = CGVector(dx: direction.dx * 0, dy: direction.dy * 200)
        }
        
    }
    
    

    func walls() {
    
        var points = [[Float]]()
        
        //Baixo
        for i in stride(from: 30, to: 2307, by: 33){
            
            points.append([Float(i), Float(27)])
        }
        
        //Cima
        for i in stride(from: 30, to: 2307, by: 33){
            
            points.append([Float(i), Float(1413)])
        }
        
        //Esquerda
        for i in stride(from: 60, to: 1413, by: 33) {
            
            points.append([Float(30), Float(i)])
        }
        
        //Direita
        for i in stride(from: 60, to: 1413, by: 33) {
            
            points.append([Float(2274), Float(i)])
        }
    
       //-----------------------------------------------------------
       // funciona mal (indices)
  
        let finish = SKSpriteNode(imageNamed: "Finish193x33")
        
        let sides = arc4random_uniform(2 - 0) + 0
        
        if sides == 0 {
          //verical
            
            playerShip.position = CGPoint(x: Int(arc4random_uniform(2191 - 146) + 146), y: 120)
            self.addChild(playerShip)
 
            finish.position = CGPoint(x: Int(arc4random_uniform(2191 - 146) + 146), y: 1380)
            finish.zPosition = 1
            self.addChild(finish)
        }

        if sides == 1 {
            //horizontal
            
            playerShip.position = CGPoint(x: 130, y: Int(arc4random_uniform(1414 - 60) + 60))
            playerShip.zRotation = CGFloat(-Double.pi / 2.0)
            direction = CGVector(dx: 1, dy: 0)
            self.addChild(playerShip)
 
            finish.position = CGPoint(x: 2274 - 33, y: Int(arc4random_uniform(1414 - 60) + 60))
            finish.zRotation = CGFloat(Double.pi / 2.0)
            finish.zPosition = 1
            self.addChild(finish)
        }
    
        //---------------------------------------------------------
        
        for n in stride(from: 0, to: points.count, by: 1) {
        
            let box = SKSpriteNode(imageNamed: "Cube33x33")
            
            box.position = CGPoint(x: CGFloat(points[n][0]), y: CGFloat(points[n][1]))
        
            box.zPosition = 1
        
            self.addChild(box)
        }
    }

    func player() {
        
        let playerShipTexture = SKTexture(imageNamed: "Player")
        playerShip.setScale(0.8)
        //playerShip.position = CGPoint(x: self.size.width/2, y: self.size.height/8)
        playerShip.zPosition = 3
        //self.addChild(playerShip)
        
        playerShip.physicsBody = SKPhysicsBody(texture: playerShipTexture, size: playerShip.size)
        playerShip.physicsBody?.isDynamic = true
        playerShip.physicsBody!.affectedByGravity = false
        playerShip.physicsBody!.linearDamping = 0.0
        playerShip.physicsBody!.friction = 0.0
    }
    
    func background() {
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.setScale(0.1)
        background.size = self.size
        background.position = CGPoint(x: 2304/2, y: 1440/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.7  , target:self  ,selector: #selector(addWall)  , userInfo: nil ,repeats: true)

    }
    
    
    
    var gameTimer:Timer!
    var possibleWalls=["Cube33x33"] //nome da imagem
    
    let wallsCategory: UInt32 = 0x1<<1
    let photonTorpedoCategory: UInt32 = 0x1<<0
    
    
    
    
    //Generate walls
    @objc func addWall(){
        possibleWalls = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleWalls) as! [String]
        
        let wall = SKSpriteNode(imageNamed: possibleWalls[0])
        
        let randomWallPosition = GKRandomDistribution(lowestValue: 0, highestValue: 2304)
        
        let position = CGFloat(randomWallPosition.nextInt())
        
        wall.position = CGPoint(x: position, y: self.frame.size.height + wall.size.height)
        
        wall.zPosition = 2
        
        wall.physicsBody = SKPhysicsBody.init(rectangleOf: wall.size)
        wall.physicsBody?.isDynamic = false
        
        wall.physicsBody?.categoryBitMask = wallsCategory
        // wall.physicsBody?.contactTestBitMask = photonTorpedoCategory
        // wall.physicsBody?.collisionBitMask = 0
        
        self.addChild(wall)
        
        let animationDuration: TimeInterval = 4
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -wall.size.height),duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        wall.run(SKAction.sequence(actionArray))
    }
    
    /*
    func genarateMap() {
        
        let turret = SKSpriteNode(imageNamed: "Turret")
        let turretPlatf = SKSpriteNode(imageNamed: "Platform")
       // let turretMissile = SKSpriteNode(imageNamed: "turretMissile")
        let turretPosition = CGPoint(x: 2304/2, y: 1440/2)
        
       // let block = SKSpriteNode(imageNamed: "Cube33x33")
    
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
        }
        
        let wait = SKAction.wait(forDuration: 0.01)
        let sequence = SKAction.sequence([rotate, wait])
        run(SKAction.repeatForever(sequence))
        
    }
    
    
    func turretmissile() {
        
        let turretMissile = SKSpriteNode(imageNamed: "turretMissile")
        let turretPosition = CGPoint(x: 2304/2, y: 1440/2)
        
        let spawnTurretMissile = SKAction.run {
            
            let deltaX = Int(turretPosition.x - self.playerShip.position.x)
            let deltaY = Int(turretPosition.y - self.playerShip.position.y)
            let distance = CGFloat(sqrt(Double(deltaX^2 + deltaY^2)))
            
            if distance <= 300.0 {
                
                turretMissile.setScale(1.0)
                turretMissile.position = turretPosition
                turretMissile.zPosition = 3
                self.addChild(turretMissile)
                
                let deltaX = turretPosition.x - abs(self.playerShip.position.x)
                let deltaY = turretPosition.y - abs(self.playerShip.position.y)
                let angle = atan2(deltaY, deltaX) // calcular teta(angulo)
                turretMissile.zRotation = angle + CGFloat(Double.pi / 2) // rodar para angulo
                
                let move = SKAction.move(to: CGPoint(x: self.playerShip.position.x, y: self.playerShip.position.y), duration: 1.0)
                turretMissile.run(move) // mover missil para a posiao do player
                
            }
        }
        
        let delete = SKAction.run {
            
            turretMissile.removeFromParent()
        }
        
        let waitForMissile = SKAction.wait(forDuration: 2.0)
        
        let missile = SKAction.sequence([spawnTurretMissile, waitForMissile, delete])
        
        run(SKAction.repeatForever(missile))
    }
 
 */
 
    func genarateMap() {
        
        let turret = SKSpriteNode(imageNamed: "Turret")
        let turretPlatf = SKSpriteNode(imageNamed: "Platform")
        // let turretMissile = SKSpriteNode(imageNamed: "turretMissile")
        let turretPosition = CGPoint(x: 2304/2, y: 1440/2)
        
        // let block = SKSpriteNode(imageNamed: "Cube33x33")
        
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
        }
        
        let wait = SKAction.wait(forDuration: 0.01)
        let sequence = SKAction.sequence([rotate, wait])
        run(SKAction.repeatForever(sequence))
        
    }
    
    
    func turretmissile() {
        
        let turretMissile = SKSpriteNode(imageNamed: "turretMissile")
        let turretPosition = CGPoint(x: 2304/2, y: 1440/2)
        
        let spawnTurretMissile = SKAction.run {
            
            //print(self.playerShip.position.x, self.playerShip.position.y)
            
            let deltaX = abs(Int(turretPosition.x - self.playerShip.position.x))
            let deltaY = abs(Int(turretPosition.y - self.playerShip.position.y))
            let distance = Double(sqrt(Double(deltaX^2 + deltaY^2)))
           // print(distance)
            print(deltaX)
            print(deltaY)
            print(distance)
            
            if distance <= 24.00 {
                
                turretMissile.setScale(1.0)
                turretMissile.position = turretPosition
                turretMissile.zPosition = 3
                self.addChild(turretMissile)
                
                let deltaX = Int(turretPosition.x - self.playerShip.position.x)
                let deltaY = Int(turretPosition.y - self.playerShip.position.y)
                let angle = atan2(CGFloat(deltaY), CGFloat(deltaX)) // calcular teta(angulo)
                turretMissile.zRotation = angle + CGFloat(Double.pi / 2) // rodar para angulo
                
                let move = SKAction.move(to: CGPoint(x: self.playerShip.position.x, y: self.playerShip.position.y), duration: 0.6)
                turretMissile.run(move) // mover missil para a posiçao do player
                
            }
        }
        
        let delete = SKAction.run {
            
            turretMissile.removeFromParent()
        }
        
        let waitForMissile = SKAction.wait(forDuration: 1.0)
        
        let missile = SKAction.sequence([spawnTurretMissile, waitForMissile, delete])
        
        run(SKAction.repeatForever(missile))
    }
 
}

