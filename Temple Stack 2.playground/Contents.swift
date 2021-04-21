//: A UIKit based Playground for presenting user interface
  
import UIKit
import SpriteKit
import PlaygroundSupport
import AVFoundation

// Selecting which levels to play
class MenuVC: UIViewController {
    var bgmPlayer: AVAudioPlayer?
    var player: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.52, green: 0.53, blue: 0.56, alpha: 1.00)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let logoTitle = UIImageView.init(frame: CGRect.init(x: 146, y: 82, width: 196, height: 38))
        logoTitle.image = UIImage.init(named: "Temple Stack title.png")
        
        self.view.addSubview(logoTitle)
        
        
        let borobudurGameButton = UIButton.init(frame: .init(x: 137, y: 217, width: 226, height: 72))
        borobudurGameButton.setImage(UIImage.init(named: "Button borobudur.png"), for: .normal)
        borobudurGameButton.addTarget(self, action: #selector(nextBorobudurPage), for: .touchUpInside)
        
        self.view.addSubview(borobudurGameButton)
        
        
        let lempuyangGameButton = UIButton.init(frame: .init(x: 137, y: 325, width: 226, height: 72))
        lempuyangGameButton.setImage(UIImage.init(named: "Button Lempuyang.png"), for: .normal)
        lempuyangGameButton.addTarget(self, action: #selector(nextLempuyangPage), for: .touchUpInside)
        
        self.view.addSubview(lempuyangGameButton)
        
        let infoButton = UIButton.init(frame: .init(x: 429, y: 429, width: 41, height: 41))
        infoButton.setImage(UIImage.init(named: "Credit button.png"), for: .normal)
        infoButton.addTarget(self, action: #selector(nextCreditPage), for: .touchUpInside)
        
        self.view.addSubview(infoButton)
        playBackgroundMusic()
    }
    
    @objc func nextBorobudurPage() {
        let vc = BorobudurGameVC()
        DispatchQueue.main.async {
            self.playClickSound()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func nextLempuyangPage() {
        let vc = LempuyangGameVC()
        DispatchQueue.main.async {
            self.playClickSound()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func nextCreditPage() {
        let vc = CreditVC()
        DispatchQueue.main.async {
            self.playClickSound()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "Framelens Audiovisual - Java Music Jamming", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            bgmPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let bgmPlayer = bgmPlayer else { return }
            bgmPlayer.numberOfLoops = -1
            bgmPlayer.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func playClickSound() {
        guard let url = Bundle.main.url(forResource: "click menu", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

}


// Spritekit Scene Container
class BorobudurGameVC: UIViewController, SKViewDelegate {
    
    let sceneView = SKView(frame: CGRect(x:0, y:0, width: 500, height: 500))
    var player: AVAudioPlayer?
    
    let clickLabel = UILabel.init(frame: CGRect.init(x: 100, y: 220, width: 300, height: 60))
    
    let firstLoad = UIImageView.init(frame: CGRect(x:0, y:0, width: 500, height: 500))
    let secondLoad = UIImageView.init(frame: CGRect(x:0, y:0, width: 500, height: 500))
    let thirdLoad = UIImageView.init(frame: CGRect(x:0, y:0, width: 500, height: 500))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        firstLoad.image = UIImage.init(named: "load 1.png")
        secondLoad.image = UIImage.init(named: "load 2.png")
        thirdLoad.image = UIImage.init(named: "load 3.png")
        
        secondLoad.isHidden = true
        thirdLoad.isHidden = true
        self.firstLoad.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.secondLoad.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.thirdLoad.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        self.view.addSubview(thirdLoad)
        self.view.addSubview(secondLoad)
        self.view.addSubview(firstLoad)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            let gameView = BorobudurScene(size: CGSize(width: 500, height: 500))
            gameView.viewcontroller = self
            self.sceneView.presentScene(gameView)
            self.view.addSubview(self.sceneView)
            self.view.bringSubviewToFront(self.secondLoad)
            self.firstLoad.isHidden = true
            self.secondLoad.isHidden = false
            self.thirdLoad.isHidden = true
        }
    }
    
    func showthirdLoading(){
        DispatchQueue.main.async {
            self.firstLoad.isHidden = true
            self.secondLoad.isHidden = true
            self.thirdLoad.isHidden = false
            self.view.bringSubviewToFront(self.thirdLoad)
        }
    }
    
    func hideAllLoading() {
        DispatchQueue.main.async {
            self.firstLoad.isHidden = true
            self.secondLoad.isHidden = true
            self.thirdLoad.isHidden = true
            
            self.view.addSubview(self.clickLabel)
            self.clickLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
            self.clickLabel.textColor = .white
            self.clickLabel.text = "click to drop it"
            self.clickLabel.textAlignment = .center
            self.clickLabel.font = .systemFont(ofSize: 32, weight: .black)
        }
    }
    
    func showClickLabel() {
        DispatchQueue.main.async {
            self.view.addSubview(self.clickLabel)
            self.clickLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
            self.clickLabel.textColor = .white
            self.clickLabel.text = "click to drop it"
            self.clickLabel.textAlignment = .center
            self.clickLabel.font = .systemFont(ofSize: 32, weight: .black)
        }
    }
    
    func takeAPicture() -> UIImage? {
        let bounds = sceneView.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        self.sceneView.drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image
    }
    
    func playClickSound() {
        DispatchQueue.main.async {
            self.clickLabel.isHidden = true
            self.playSound(fileName: "click menu")
        }
    }
    
    func playDropSound() {
        DispatchQueue.main.async {
            self.playSound(fileName: "drop sound")
        }
    }
    
    private func playSound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func nextPage() {
        sceneView.isPaused = true
        let vc = BorobudurEndVC(image: takeAPicture())
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// Spritekit Game
class BorobudurScene: SKScene, SKPhysicsContactDelegate {
    lazy var background = SKSpriteNode(imageNamed: "background borobudur.jpg")
    
    var allowTap = false
    var objectCount = 2
    weak var viewcontroller: BorobudurGameVC?
    
    
    let bottomStupa = SKSpriteNode(imageNamed: "bottom stupa.png")
    let topStupa = SKSpriteNode(imageNamed: "Top stupa.png")
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        
        self.background.zPosition = -1
        self.background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.background.size = CGSize(width: self.size.width, height: self.size.height)
        self.addChild(self.background)
        
        
        DispatchQueue.main.async {
            let bottomStupaPhysicsBody = SKPhysicsBody(rectangleOf: self.bottomStupa.size)
            bottomStupaPhysicsBody.isDynamic = false
            bottomStupaPhysicsBody.allowsRotation = false
            bottomStupaPhysicsBody.restitution = 0
            bottomStupaPhysicsBody.contactTestBitMask = 0b1 << 0
            self.bottomStupa.physicsBody = bottomStupaPhysicsBody
            self.bottomStupa.position = CGPoint(x:-200, y: -200)
            self.bottomStupa.name = "bottomStupa"
            
            let topStupaPhysicsBody = SKPhysicsBody(rectangleOf: self.topStupa.size)
            topStupaPhysicsBody.isDynamic = false
            topStupaPhysicsBody.allowsRotation = false
            topStupaPhysicsBody.restitution = 0
            topStupaPhysicsBody.contactTestBitMask = 0b1 << 0
            self.topStupa.physicsBody = topStupaPhysicsBody
            self.topStupa.position = CGPoint(x:-500, y: -500)
            self.topStupa.name = "topStupa"
        }
        
        
        DispatchQueue.main.async {
            self.viewcontroller?.showthirdLoading()
            self.setupBase()
            self.updateObjectCount()
        }
    }
    
    func setupBase() {
        let base = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 500, height: 80))
        base.name = "base"
        
        let physicsBody = SKPhysicsBody(rectangleOf: base.size)
        physicsBody.isDynamic = false
        physicsBody.restitution = 0
        base.physicsBody = physicsBody
        addChild(base)
        base.position = CGPoint(x:250, y: 0)
    }
    
    func updateObjectCount() {
        if objectCount == 0 {
            allowTap = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.viewcontroller?.nextPage()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startSwing()
                self.allowTap = true
            }
        }
    }
    
    func startSwing() {
        if objectCount == 2 {
            self.addChild(bottomStupa)
            bottomStupa.position = CGPoint(x: 50 + (bottomStupa.frame.width / 2) , y: 450)
            
            let left = CGPoint(x: 50 + (bottomStupa.frame.width / 2) , y: 450)
            let right = CGPoint(x: 450 - (bottomStupa.frame.width / 2) , y: 450)
            
            let tick = SKAction.move(to: left, duration: 1)
            let tock = SKAction.move(to: right, duration: 1)
            
            let sequence = SKAction.sequence([tick, tock])
            sequence.timingMode = .linear
            bottomStupa.run(SKAction.repeatForever(sequence))
            self.viewcontroller?.showClickLabel()
        } else if objectCount == 1 {
            self.addChild(topStupa)
            topStupa.position = CGPoint(x: 50 + (topStupa.frame.width / 2) , y: 450)
            
            let left = CGPoint(x: 50 + (topStupa.frame.width / 2) , y: 450)
            let right = CGPoint(x: 450 - (topStupa.frame.width / 2) , y: 450)
            
            let tick = SKAction.move(to: left, duration: 1)
            let tock = SKAction.move(to: right, duration: 1)
            
            let sequence = SKAction.sequence([tick, tock])
            sequence.timingMode = .linear
            topStupa.run(SKAction.repeatForever(sequence))
        }
        self.viewcontroller?.hideAllLoading()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewcontroller?.playClickSound()
        
        if let _ = touches.first, allowTap {
            allowTap = false
            DispatchQueue.main.async {
                if self.objectCount == 2 {
                    self.bottomStupa.removeAllActions()
                    self.bottomStupa.physicsBody?.isDynamic = true
                    
                } else if self.objectCount == 1 {
                    self.topStupa.removeAllActions()
                    self.topStupa.physicsBody?.isDynamic = true
                } else {
                    self.allowTap = true
                }
                self.objectCount -= 1
                self.updateObjectCount()
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        viewcontroller?.playDropSound()
    }
}


// End of Borobudur Level and History
class BorobudurEndVC: UIViewController {
    
    let yourBorobudur: UIImage?
    var player: AVAudioPlayer?
    
    init(image: UIImage?) {
        self.yourBorobudur = image
        super.init(nibName: nil, bundle: nil)    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let scrollView = UIScrollView(frame: .init(x: 0, y: 0, width: 500, height: 500))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = .init(width: 500, height: 1350)
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        self.view.addSubview(scrollView)
    
        
        let internalView = UIView.init(frame: .init(x: 0, y: 0, width: 500, height: 1350))
        internalView.backgroundColor = .white
        
        scrollView.addSubview(internalView)
        
        // Borobudur Title
        let titleLabel = UILabel.init(frame: .init(x: 50, y: 30, width: 400, height: 40))
        titleLabel.text = "Borobudur Temple"
        titleLabel.font = .systemFont(ofSize: 32, weight: .black)
        titleLabel.numberOfLines = 2
        internalView.addSubview(titleLabel)
        
        // Borobudur Article
        let articleText = NSMutableAttributedString()
        articleText.append(NSAttributedString(
            string: "One of the World Heritage Site located in Central java, Indonesia. Borobudur is a buddhist temple built in the 7th century during the reign of the Sailendra Dynasty, the temple design follows Javanese Buddhist architecture, which blends the Indonesian indigenous cult of ancestor worship and the Buddhist concept of attaining Nirvana.\n\n( Click and drag to scroll down )",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light),
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        ]))
        
        let clickAndDragRange = (articleText.string as NSString).range(of: "( Click and drag to scroll down )")
        articleText.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 20, weight: .black),
            range: clickAndDragRange
        )
        
        let articleLabel = UILabel.init(frame: .init(x: 50, y: 70, width: 400, height: 250))
        articleLabel.attributedText = articleText
        articleLabel.numberOfLines = 0
        internalView.addSubview(articleLabel)
        
        // Borobudur Image
        let mainImage = UIImageView.init(frame: .init(x: 50, y: 345, width: 400, height: 240))
        mainImage.image = UIImage.init(named: "borobudur temple.png")
        internalView.addSubview(mainImage)
        
        // Borobudur Caption
        let mainImageCaption = UILabel.init(frame: .init(x: 50, y: 595, width: 400, height: 20))
        mainImageCaption.text = "Borobudur Temple"
        mainImageCaption.font = .systemFont(ofSize: 16, weight: .light)
        mainImageCaption.textAlignment = .center
        mainImageCaption.numberOfLines = 1
        internalView.addSubview(mainImageCaption)
        
        // More You Know
        let moreTitleLabel = UILabel.init(frame: .init(x: 50, y: 640, width: 400, height: 40))
        moreTitleLabel.text = "More you know"
        moreTitleLabel.font = .systemFont(ofSize: 32, weight: .black)
        moreTitleLabel.numberOfLines = 1
        internalView.addSubview(moreTitleLabel)
        
        // More Article
        let moreArticleLabel = UILabel.init(frame: .init(x: 50, y: 685, width: 400, height: 160))
        moreArticleLabel.text = "Buddhist temple built in Indonesia mostly short in height and wider shaped compared to hindu temple.\nBuddhist temple was built as a place to perform religion’s rituals and worship to God.\nMain entrance is in east side of the temple"
        moreArticleLabel.font = .systemFont(ofSize: 20, weight: .light)
        moreArticleLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        moreArticleLabel.numberOfLines = 0
        internalView.addSubview(moreArticleLabel)
        
        // Your Temple Image
        let yourTempleImage = UIImageView.init(frame: .init(x: 125, y: 900, width: 250, height: 250))
        yourTempleImage.image = yourBorobudur
        internalView.addSubview(yourTempleImage)
        
        // Your Temple Caption
        let yourTempleCaption = UILabel.init(frame: .init(x: 50, y: 1150, width: 400, height: 20))
        yourTempleCaption.text = "Your Result"
        yourTempleCaption.font = .systemFont(ofSize: 16, weight: .light)
        yourTempleCaption.textAlignment = .center
        yourTempleCaption.numberOfLines = 1
        internalView.addSubview(yourTempleCaption)
        
        
        // Back to Menu Button
        let backToMenuButton = UIButton.init(frame: .init(x: 170, y: 1200, width: 168, height: 48))
        backToMenuButton.setImage(UIImage.init(named: "Button main menu.png"), for: .normal)
        backToMenuButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
        internalView.addSubview(backToMenuButton)
    }
    
    private func playClickSound() {
        guard let url = Bundle.main.url(forResource: "click menu", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func backToMenu() {
        playClickSound()
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// Spritekit Scene Container
class LempuyangGameVC: UIViewController, SKViewDelegate {
    
    let sceneView = SKView(frame: CGRect(x:0, y:0, width: 500, height: 500))
    var player: AVAudioPlayer?
    
    let clickLabel = UILabel.init(frame: CGRect.init(x: 100, y: 220, width: 300, height: 60))
    
    let firstLoad = UIImageView.init(frame: CGRect(x:0, y:0, width: 500, height: 500))
    let secondLoad = UIImageView.init(frame: CGRect(x:0, y:0, width: 500, height: 500))
    let thirdLoad = UIImageView.init(frame: CGRect(x:0, y:0, width: 500, height: 500))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        firstLoad.image = UIImage.init(named: "load 1.png")
        secondLoad.image = UIImage.init(named: "load 2.png")
        thirdLoad.image = UIImage.init(named: "load 3.png")
        
        secondLoad.isHidden = true
        thirdLoad.isHidden = true
        self.firstLoad.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.secondLoad.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.thirdLoad.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        self.view.addSubview(thirdLoad)
        self.view.addSubview(secondLoad)
        self.view.addSubview(firstLoad)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            let gameView = LempuyangScene(size: CGSize(width: 500, height: 500))
            gameView.viewcontroller = self
            self.sceneView.backgroundColor = .purple
            self.sceneView.presentScene(gameView)
            self.view.addSubview(self.sceneView)
            self.view.bringSubviewToFront(self.secondLoad)
            self.firstLoad.isHidden = true
            self.secondLoad.isHidden = false
            self.thirdLoad.isHidden = true
        }
    }
    
    func showthirdLoading(){
        DispatchQueue.main.async {
            self.firstLoad.isHidden = true
            self.secondLoad.isHidden = true
            self.thirdLoad.isHidden = false
            self.view.bringSubviewToFront(self.thirdLoad)
        }
    }
    
    func hideAllLoading() {
        DispatchQueue.main.async {
            self.firstLoad.isHidden = true
            self.secondLoad.isHidden = true
            self.thirdLoad.isHidden = true
            
            self.view.addSubview(self.clickLabel)
            self.clickLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
            self.clickLabel.textColor = .white
            self.clickLabel.text = "click to drop it"
            self.clickLabel.textAlignment = .center
            self.clickLabel.font = .systemFont(ofSize: 32, weight: .black)
        }
    }
    
    func showClickLabel() {
        DispatchQueue.main.async {
            self.view.addSubview(self.clickLabel)
            self.clickLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
            self.clickLabel.textColor = .white
            self.clickLabel.text = "click to drop it"
            self.clickLabel.textAlignment = .center
            self.clickLabel.font = .systemFont(ofSize: 32, weight: .black)
        }
    }
    
    func takeAPicture() -> UIImage? {
        let bounds = sceneView.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        self.sceneView.drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image
    }
    
    func playClickSound() {
        DispatchQueue.main.async {
            self.clickLabel.isHidden = true
            self.playSound(fileName: "click menu")
        }
    }
    
    func playDropSound() {
        DispatchQueue.main.async {
            self.playSound(fileName: "drop sound")
        }
    }
    
    private func playSound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func nextPage() {
        sceneView.isPaused = true
        DispatchQueue.main.async {
            let vc = LempuyangEndVC(image: self.takeAPicture())
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// Spritekit Game
class LempuyangScene: SKScene, SKPhysicsContactDelegate {
    lazy var background = SKSpriteNode(imageNamed: "plataran lempuyang temple evening.png")
    lazy var leftFence = SKSpriteNode(imageNamed: "Short fence left.png")
    
    lazy var rightFence = SKSpriteNode(imageNamed: "Short fence right.png")
    
    let midLeft = SKSpriteNode(imageNamed: "Medium middle left.png")
    let midRight = SKSpriteNode(imageNamed: "Medium middle right.png")
    let tallLeft = SKSpriteNode(imageNamed: "Tall left.png")
    let tallRight = SKSpriteNode(imageNamed: "tall right.png")
    
    
    var rope: SKSpriteNode?
    var incomingBlock: SKSpriteNode?
    var allowTap = false
    var objectCount = 4
    weak var viewcontroller: LempuyangGameVC?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        
        self.background.zPosition = -10
        self.background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.background.size = CGSize(width: self.size.width, height: self.size.height)
        self.addChild(self.background)
        
        
        DispatchQueue.main.async {
            
            self.midLeft.zPosition = 5
            self.midLeft.position = CGPoint(x:-2000, y: -2000)
            let midLeftPhysicsBody = SKPhysicsBody(rectangleOf: self.midLeft.size)
            midLeftPhysicsBody.isDynamic = false
            midLeftPhysicsBody.allowsRotation = false
            midLeftPhysicsBody.usesPreciseCollisionDetection = false
            midLeftPhysicsBody.restitution = 0
            midLeftPhysicsBody.contactTestBitMask = 0b1 << 0
            midLeftPhysicsBody.categoryBitMask = 0b1 << 0
            midLeftPhysicsBody.collisionBitMask = 0b1 << 0
            self.midLeft.physicsBody = midLeftPhysicsBody
            self.midLeft.name = "midLeftPhysicsBody"
            
            
            self.midRight.zPosition = 4
            self.midRight.position = CGPoint(x:-1000, y: -1000)
            let midRightPhysicsBody = SKPhysicsBody(rectangleOf: self.midRight.size)
            midRightPhysicsBody.isDynamic = false
            midRightPhysicsBody.allowsRotation = false
            midRightPhysicsBody.restitution = 0
            midRightPhysicsBody.contactTestBitMask = 0b1 << 1
            midRightPhysicsBody.categoryBitMask = 0b1 << 1
            midRightPhysicsBody.collisionBitMask = 0b1 << 1
            self.midRight.physicsBody = midRightPhysicsBody
            self.midRight.name = "midRight"
            
            self.tallLeft.zPosition = 3
            self.tallLeft.position = CGPoint(x:1000, y: 1000)
            let tallLeftPhysicsBody = SKPhysicsBody(rectangleOf: self.tallLeft.size)
            tallLeftPhysicsBody.isDynamic = false
            tallLeftPhysicsBody.allowsRotation = false
            tallLeftPhysicsBody.restitution = 0
            tallLeftPhysicsBody.contactTestBitMask = 0b1 << 2
            tallLeftPhysicsBody.categoryBitMask = 0b1 << 2
            tallLeftPhysicsBody.collisionBitMask = 0b1 << 2
            self.tallLeft.physicsBody = tallLeftPhysicsBody
            self.tallLeft.name = "tallLeft"
            
            self.tallRight.zPosition = 2
            self.tallRight.position = CGPoint(x:2000, y: 2000)
            let tallRightPhysicsBody = SKPhysicsBody(rectangleOf: self.tallRight.size)
            tallRightPhysicsBody.isDynamic = false
            tallRightPhysicsBody.allowsRotation = false
            tallRightPhysicsBody.restitution = 0
            tallRightPhysicsBody.contactTestBitMask = 0b1 << 3
            tallRightPhysicsBody.categoryBitMask = 0b1 << 3
            tallRightPhysicsBody.collisionBitMask = 0b1 << 3
            self.tallRight.physicsBody = tallRightPhysicsBody
            self.tallRight.name = "tallRight"
        }
        
        DispatchQueue.main.async {
            self.viewcontroller?.showthirdLoading()
            self.setupBase()
            self.setupFence()
            self.updateObjectCount()
        }
    }
    
    func setupFence() {
        self.leftFence.zPosition = 10
        self.leftFence.position = CGPoint(x: self.leftFence.frame.width / 2, y: 9 + self.rightFence.frame.height / 2)
        self.addChild(self.leftFence)
        
        
        self.rightFence.zPosition = 10
        self.rightFence.position = CGPoint(x: 500 - (self.rightFence.frame.width / 2), y: 9 + self.rightFence.frame.height / 2)
        self.addChild(self.rightFence)
    }
    
    func setupBase() {
        let base = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 500, height: 20))
        base.name = "base"
        
        let physicsBody = SKPhysicsBody(rectangleOf: base.size)
        physicsBody.isDynamic = false
        physicsBody.restitution = 0
        physicsBody.contactTestBitMask = 0b1 << 0
        base.physicsBody = physicsBody
        addChild(base)
        base.position = CGPoint(x:250, y: 0)
    }
    
    func updateObjectCount() {
        if objectCount == 0 {
            allowTap = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.viewcontroller?.nextPage()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startSwing()
                self.allowTap = true
            }
        }
    }
    
    func startSwing() {
        if objectCount == 4 {
            self.addChild(midLeft)
            midLeft.position = CGPoint(x: 100 + (midLeft.frame.width / 2) , y: 450)
            
            let left = CGPoint(x: 100 + (midLeft.frame.width / 2) , y: 450)
            let right = CGPoint(x: 400 - (midLeft.frame.width / 2) , y: 450)
            
            let tick = SKAction.move(to: left, duration: 1.5)
            let tock = SKAction.move(to: right, duration: 1.5)
            
            let sequence = SKAction.sequence([tick, tock])
            sequence.timingMode = .linear
            midLeft.run(SKAction.repeatForever(sequence))
            self.viewcontroller?.showClickLabel()
        } else if objectCount == 3 {
            self.addChild(midRight)
            midRight.position = CGPoint(x: 100 + (midRight.frame.width / 2) , y: 450)
            
            let left = CGPoint(x: 100 + (midRight.frame.width / 2) , y: 450)
            let right = CGPoint(x: 400 - (midRight.frame.width / 2) , y: 450)
            
            let tick = SKAction.move(to: left, duration: 1.5)
            let tock = SKAction.move(to: right, duration: 1.5)
            
            let sequence = SKAction.sequence([tick, tock])
            sequence.timingMode = .linear
            midRight.run(SKAction.repeatForever(sequence))
        } else if objectCount == 2 {
            self.addChild(tallLeft)
            tallLeft.position = CGPoint(x: 100 + (tallLeft.frame.width / 2) , y: 450)
            
            let left = CGPoint(x: 100 + (tallLeft.frame.width / 2) , y: 450)
            let right = CGPoint(x: 400 - (tallLeft.frame.width / 2) , y: 450)
            
            let tick = SKAction.move(to: left, duration: 1.5)
            let tock = SKAction.move(to: right, duration: 1.5)
            
            let sequence = SKAction.sequence([tick, tock])
            sequence.timingMode = .linear
            tallLeft.run(SKAction.repeatForever(sequence))
        } else if objectCount == 1 {
            self.addChild(tallRight)
            tallRight.position = CGPoint(x: 100 + (tallRight.frame.width / 2) , y: 450)
            
            let left = CGPoint(x: 100 + (tallRight.frame.width / 2) , y: 450)
            let right = CGPoint(x: 400 - (tallRight.frame.width / 2) , y: 450)
            
            let tick = SKAction.move(to: left, duration: 1.5)
            let tock = SKAction.move(to: right, duration: 1.5)
            
            let sequence = SKAction.sequence([tick, tock])
            sequence.timingMode = .linear
            tallRight.run(SKAction.repeatForever(sequence))
        }
        self.viewcontroller?.hideAllLoading()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewcontroller?.playClickSound()
        
        if let _ = touches.first, allowTap {
            allowTap = false
            
            DispatchQueue.main.async {
                if self.objectCount == 4 {
                    self.midLeft.removeAllActions()
                    self.midLeft.physicsBody?.isDynamic = true
                    
                } else if self.objectCount == 3 {
                    self.midRight.removeAllActions()
                    self.midRight.physicsBody?.isDynamic = true
                    
                } else if self.objectCount == 2 {
                    self.tallLeft.removeAllActions()
                    self.tallLeft.physicsBody?.isDynamic = true
                    
                } else if self.objectCount == 1 {
                    self.tallRight.removeAllActions()
                    self.tallRight.physicsBody?.isDynamic = true
                    
                } else {
                    self.allowTap = false
                }
                
                self.objectCount -= 1
                self.updateObjectCount()
            }
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        viewcontroller?.playDropSound()
    }
}


// End of Platar Agung Lempuyang Level and History
class LempuyangEndVC: UIViewController {

    let yourLempuyang: UIImage?
    var player: AVAudioPlayer?
    
    init(image: UIImage?) {
        self.yourLempuyang = image
        super.init(nibName: nil, bundle: nil)    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let scrollView = UIScrollView(frame: .init(x: 0, y: 0, width: 500, height: 500))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = .init(width: 500, height: 2000)
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        self.view.addSubview(scrollView)
    
        
        let internalView = UIView.init(frame: .init(x: 0, y: 0, width: 500, height: 2000))
        internalView.backgroundColor = .white
        
        scrollView.addSubview(internalView)
        
        // Lempuyang Title
        let titleLabel = UILabel.init(frame: .init(x: 50, y: 30, width: 400, height: 80))
        titleLabel.text = "Pura Penataran Agung Lempuyang"
        titleLabel.font = .systemFont(ofSize: 32, weight: .black)
        titleLabel.numberOfLines = 2
        internalView.addSubview(titleLabel)
        
        // Lempuyang Article
        let articleText = NSMutableAttributedString()
        articleText.append(NSAttributedString(
            string: "is a Balinese Hindu temple or pura located in the slope of Mount Lempuyang in Karangasem, Bali.\nPura Penataran Agung Lempuyang is considered as part of a complex of pura surrounding Mount Lempuyang, one of the highly regarded temples of Bali.\nThe temples of Mount Lempuyang, represented by the highest pura at the peak of Mount Lempuyang, Pura Lempuyang Luhur, is one of the Sad Kahyangan Jagad, or the \"six sanctuaries of the world\", the six holiest places of worship on Bali.\n\n( Click and drag to scroll down )",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light),
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        ]))
        
        let clickAndDragRange = (articleText.string as NSString).range(of: "( Click and drag to scroll down )")
        articleText.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 20, weight: .black),
            range: clickAndDragRange
        )
        
        let articleLabel = UILabel.init(frame: .init(x: 50, y: 100, width: 400, height: 376))
        articleLabel.attributedText = articleText
        articleLabel.numberOfLines = 0
        internalView.addSubview(articleLabel)
        
        // Lempuyang Image
        let mainImage = UIImageView.init(frame: .init(x: 50, y: 500, width: 400, height: 242))
        mainImage.image = UIImage.init(named: "Lempuyang temple.png")
        internalView.addSubview(mainImage)
        
        // Lempuyang Caption
        let mainImageCaption = UILabel.init(frame: .init(x: 50, y: 745, width: 400, height: 20))
        mainImageCaption.text = "Pura Agung Lempuyang"
        mainImageCaption.font = .systemFont(ofSize: 16, weight: .light)
        mainImageCaption.textAlignment = .center
        mainImageCaption.numberOfLines = 1
        internalView.addSubview(mainImageCaption)
        
        // More You Know
        let moreTitleLabel = UILabel.init(frame: .init(x: 50, y: 790, width: 400, height: 40))
        moreTitleLabel.text = "More you know"
        moreTitleLabel.font = .systemFont(ofSize: 32, weight: .black)
        moreTitleLabel.numberOfLines = 1
        internalView.addSubview(moreTitleLabel)
        
        // More Article
        let moreArticleLabel = UILabel.init(frame: .init(x: 50, y: 838, width: 400, height: 258))
        moreArticleLabel.text = "the most popular tourist spot was the gate of this temple, known to the western world as \"The Gates of Heaven\" which you can see majestic panorama of Mount Agung.\nHindu temple built in Indonesia mostly taller and slimmer compared to Buddhist temple.\nHindu temple was built as a place to perform religion’s rituals and worshiping Gods, and some of hindu temple also being used as King’s funerary."
        moreArticleLabel.font = .systemFont(ofSize: 20, weight: .light)
        moreArticleLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        moreArticleLabel.numberOfLines = 0
        internalView.addSubview(moreArticleLabel)
        
        
        // Lempuyang Temple Image
        let templeImage = UIImageView.init(frame: .init(x: 125, y: 1145, width: 250, height: 300))
        templeImage.image = UIImage.init(named: "Heaven gate.png")
        internalView.addSubview(templeImage)
        
        // Lempuyang Temple Caption
        let templeCaption = UILabel.init(frame: .init(x: 50, y: 1451, width: 400, height: 20))
        templeCaption.text = "The Gates of Heaven"
        templeCaption.font = .systemFont(ofSize: 16, weight: .light)
        templeCaption.textAlignment = .center
        templeCaption.numberOfLines = 1
        internalView.addSubview(templeCaption)
        
        // Your Temple Image
        let yourTempleImage = UIImageView.init(frame: .init(x: 125, y: 1500, width: 250, height: 250))
        yourTempleImage.image = yourLempuyang
        internalView.addSubview(yourTempleImage)
        
        // Your Temple Caption
        let yourTempleCaption = UILabel.init(frame: .init(x: 50, y: 1750, width: 400, height: 20))
        yourTempleCaption.text = "Your Result"
        yourTempleCaption.font = .systemFont(ofSize: 16, weight: .light)
        yourTempleCaption.textAlignment = .center
        yourTempleCaption.numberOfLines = 1
        internalView.addSubview(yourTempleCaption)
        
        
        // Back to Menu Button
        let backToMenuButton = UIButton.init(frame: .init(x: 170, y: 1850, width: 168, height: 48))
        backToMenuButton.setImage(UIImage.init(named: "Button main menu.png"), for: .normal)
        backToMenuButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
        internalView.addSubview(backToMenuButton)
    }
    
    private func playClickSound() {
        guard let url = Bundle.main.url(forResource: "click menu", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    @objc func backToMenu() {
        playClickSound()
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// Credit
class CreditVC: UIViewController {
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let scrollView = UIScrollView(frame: .init(x: 0, y: 0, width: 500, height: 500))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = .init(width: 500, height: 1350)
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        self.view.addSubview(scrollView)
    
        
        let internalView = UIView.init(frame: .init(x: 0, y: 0, width: 500, height: 1350))
        internalView.backgroundColor = .white
        
        scrollView.addSubview(internalView)
        
        // How To Play Title
        let howToPlayTitle = UILabel.init(frame: .init(x: 45, y: 30, width: 410, height: 40))
        howToPlayTitle.text = "How to play"
        howToPlayTitle.font = .systemFont(ofSize: 32, weight: .black)
        howToPlayTitle.numberOfLines = 1
        internalView.addSubview(howToPlayTitle)
        
        // How To Play Body
        let howToPlayBodyText = NSMutableAttributedString()
        howToPlayBodyText.append(NSAttributedString(
            string: "The temple’s component gonna hover from left to right on its own.\nYour task is to click to drop it on when it was hovering in the right place. Once the level finished you will find some information about the temple\nDon’t worry about making a mistake there is no punishment waiting for that. Play and have fun.\n\n( Click and drag to scroll down )",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light),
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        ]))
        
        let touchRange = (howToPlayBodyText.string as NSString).range(of: "click")
        howToPlayBodyText.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 20, weight: .black),
            range: touchRange
        )
        
        let dontWorryRange = (howToPlayBodyText.string as NSString).range(of: "Don’t worry about making a mistake")
        howToPlayBodyText.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 20, weight: .black),
            range: dontWorryRange
        )
        
        let clickAndDragRange = (howToPlayBodyText.string as NSString).range(of: "( Click and drag to scroll down )")
        howToPlayBodyText.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 20, weight: .black),
            range: clickAndDragRange
        )
        
        let howToPlayBody = UILabel.init(frame: .init(x: 45, y: 50, width: 410, height: 300))
        howToPlayBody.attributedText = howToPlayBodyText
        howToPlayBody.numberOfLines = 0
        internalView.addSubview(howToPlayBody)
        
        // Inspiration Title
        let inspirationTitle = UILabel.init(frame: .init(x: 45, y: 370, width: 400, height: 40))
        inspirationTitle.text = "Inspiration"
        inspirationTitle.font = .systemFont(ofSize: 32, weight: .black)
        inspirationTitle.numberOfLines = 1
        internalView.addSubview(inspirationTitle)
        
        // Inspiration Body
        let inspirationBody = UILabel.init(frame: .init(x: 45, y: 410, width: 400, height: 170))
        inspirationBody.text = "This challenge inspired by Indonesian folktale of a prince Bandung Bondowoso who were tasked to build 1000 temple in one night by his crush Princess Rara Jonggrang, also combined with how a temple was built from stacking thousands of big boulders."
        inspirationBody.font = .systemFont(ofSize: 20, weight: .light)
        inspirationBody.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        inspirationBody.numberOfLines = 0
        internalView.addSubview(inspirationBody)
        
        // Credit Title
        let creditTitle = UILabel.init(frame: .init(x: 45, y: 610, width: 410, height: 40))
        creditTitle.text = "Credits"
        creditTitle.font = .systemFont(ofSize: 32, weight: .black)
        creditTitle.numberOfLines = 1
        internalView.addSubview(creditTitle)
        
        // Credit Body
        let creditBodyText = NSMutableAttributedString()
        creditBodyText.append(NSAttributedString(
            string: "Photos :\npexels.com\n\nSfx :\n•    reitanna - big thud -  freesound.org\n•    Chisato Kimura - Click sound - dova s\n\nBGM :\nFramelens Audio Visual\n\nSource Information : \n( In indonesian language )\n•    Indonesia History book class X, Code: 10.3.2\n•    Wikipedia\n\nDeveloper :\nCodes and Assets by\nBrian Supatra\nMonsory.com",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light),
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        ]))
        
        let photosRange = (creditBodyText.string as NSString).range(of: "Photos :")
        creditBodyText.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 20, weight: .bold),
            range: photosRange
        )
        
        let sfxRange = (creditBodyText.string as NSString).range(of: "Sfx :")
        creditBodyText.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 20, weight: .bold),
            range: sfxRange
        )
        
        let bgmRange = (creditBodyText.string as NSString).range(of: "BGM :")
        creditBodyText.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 20, weight: .bold),
            range: bgmRange
        )
        
        let sourceInformationRange = (creditBodyText.string as NSString).range(of: "Source Information :")
        creditBodyText.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 20, weight: .semibold),
            range: sourceInformationRange
        )
        
        let developerRange = (creditBodyText.string as NSString).range(of: "Developer :")
        creditBodyText.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 20, weight: .semibold),
            range: developerRange
        )
        
        let creditBody = UILabel.init(frame: .init(x: 45, y: 650, width: 410, height: 475))
        creditBody.attributedText = creditBodyText
        creditBody.numberOfLines = 0
        internalView.addSubview(creditBody)
        
        // Back to Menu Button
        let backToMenuButton = UIButton.init(frame: .init(x: 170, y: 1200, width: 168, height: 48))
        backToMenuButton.setImage(UIImage.init(named: "Button main menu.png"), for: .normal)
        backToMenuButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
        internalView.addSubview(backToMenuButton)
    }
    
    private func playClickSound() {
        guard let url = Bundle.main.url(forResource: "click menu", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    @objc func backToMenu() {
        playClickSound()
        self.navigationController?.popToRootViewController(animated: true)
    }
}

let vc = MenuVC()
let navigation = UINavigationController(rootViewController: vc)
navigation.setNavigationBarHidden(true, animated: false)
vc.preferredContentSize = CGSize(width: 500, height: 500)
navigation.preferredContentSize = CGSize(width: 500, height: 500)

let window = UIWindow.init(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
window.rootViewController = navigation
PlaygroundPage.current.liveView = navigation.view
PlaygroundPage.current.needsIndefiniteExecution = true
