import Cocoa
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameArea: CGRect
    
    let player = SKSpriteNode(imageNamed: "Player" )
    
    override init(size: CGSize) {
        
        //GameArea
        let maxAspectRatio: CGFloat = 16.0/9.0 
        let playableWidth = size.width/maxAspectRatio
        let playableHeight = size.height/maxAspectRatio
        
        gameArea = CGRect(x: 0, y: 0, width: playableWidth, height: playableHeight)
        
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
       
        //Backgound
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //Player
        player.setScale(1)
        player.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        player.zPosition = 3
        self.addChild(player)
    }
    
    //PlayerMovement
       override func keyDown(with event: NSEvent) {
        
        //A
        if event.keyCode == 0 {
            player.position.x -= 10
        }
        
        //D
        if event.keyCode == 2 {
            player.position.x += 10
        }
        
        //W
        if event.keyCode == 13 {
            player.position.y += 10
        }
        
        //S
        if event.keyCode == 1 {
            player.position.y -= 10
        }
    }
        
        
    }
