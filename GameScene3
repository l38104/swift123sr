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
        
        addWall()
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
        //Espaço
        if event.keyCode == 49 {
        
            self.playerShip.physicsBody!.applyImpulse(CGVector(dx: direction.dx*300, dy: direction.dy*300))
            
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
       //let start = SKSpriteNode(imageNamed: "Start193x33")
        let finish = SKSpriteNode(imageNamed: "Finish193x33")
        
        let sides = arc4random_uniform(2 - 0) + 0
        
        if sides == 0 {
          //verical
            
            /*
            start.position = CGPoint(x: Int(arc4random_uniform(2191 - 146) + 146), y: 63
            start.zPosition = 1
            self.addChild(start)
 
            */
            
            finish.position = CGPoint(x: Int(arc4random_uniform(2191 - 146) + 146), y: 1380)
            finish.zPosition = 1
            self.addChild(finish)
            
        }

        if sides == 1 {
            //horizontal
           
            /*
            start.position = CGPoint(x: Int(arc4random_uniform(1297 - 143) + 143), y: 63)
            start.zPosition = 1
            self.addChild(start)
 
             */
            
            finish.position = CGPoint(x: Int(arc4random_uniform(1297 - 143) + 143), y: 1380)
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
        playerShip.position = CGPoint(x: self.size.width/2, y: self.size.height/8)
        playerShip.zPosition = 3
        self.addChild(playerShip)
        
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
    
}




