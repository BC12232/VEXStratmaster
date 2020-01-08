//
//  ViewController.swift
//  StrategyApp110619
//
//  Created by Elle on 11/6/19.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    var pinkColor = UIColor(red: 244/255, green: 218/255, blue: 222/255, alpha: 1)
    var blueColor = UIColor(red: 217/255, green: 231/255, blue: 251/255, alpha: 1)
    @IBOutlet weak var check0: UIImageView!
    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var check2: UIImageView!
    @IBOutlet weak var check3: UIImageView!
    
    @IBOutlet weak var cube0_13: UIView!
    
    var cubeArray = Array<String>();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //strategyView.layer.borderColor = #aaaaaa
        //strategyView.layer.borderWidth = 1.0
        strategyView.font = UIFont (name: "Arial", size: 24)

        self.view.backgroundColor = pinkColor
        
        // double tap check mark
        let tap0 = UITapGestureRecognizer(target: self, action: #selector(doubleTapped0(sender:)))
        
        // create tap gesture recognizer
        let gestureRed = UITapGestureRecognizer(target: self, action: #selector(onTapGestureRed(gesture:)))
        let gestureBlue = UITapGestureRecognizer(target: self, action: #selector(onTapGestureBlue(gesture:)))
        
        tap0.numberOfTapsRequired = 2
        // add it to the image view;
        redCup.addGestureRecognizer(gestureRed)
        blueCup.addGestureRecognizer(gestureBlue)
        check0.addGestureRecognizer(tap0)
        
        // make sure imageView can be interacted with by user
        redCup.isUserInteractionEnabled = true
        blueCup.isUserInteractionEnabled = true
        check0.isUserInteractionEnabled = true
    }
    
   //TODO: make this double-tap triggered.
   @objc func doubleTapped0(sender: UIGestureRecognizer) {
       // if the tapped view is a UIImageView then set it to imageview
       if (sender.view as? UIImageView) != nil {
           print("doubleTapped0 pressed!")
       }
   }
    func change(t: String){
        if(t == "RED"){
            view.backgroundColor = pinkColor
            whichSide = "r"
            updateScore()
        }else{
            view.backgroundColor = blueColor
            whichSide = "b"
            updateScore()
        }
    }
    func wannaChange(t: String) {
        let alert = UIAlertController(title: "Change to " + t + "?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in self.change(t: t)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
    }
    @IBAction func amRedTeam(_ sender: UIButton) {
        wannaChange(t: "RED")
    }
    @IBAction func amBlueTeam(_ sender: Any) {
        wannaChange(t: "BLUE")
    }
    
    //IDEA: timer that shows the recent changes for about 10 sec,
    //allowing you to undo them. A "back" button as well?
    @IBOutlet weak var Scoreboard: UIView!
    
    @IBOutlet var placedCubesUs: UIView!
    @IBOutlet var placedCubesThem: UIView!
    @IBOutlet var orangeCircle1: UIView!
    @IBOutlet weak var strategyView: UITextView!

    
    @IBOutlet weak var redCup: UIImageView!
    @IBOutlet weak var blueCup: UIImageView!
    
    // All UILabels (TV = "textview")
    @IBOutlet weak var redScoreTV: UILabel!
    @IBOutlet weak var blueScoreTV: UILabel!
    @IBOutlet weak var orangeRedScoredTV: UILabel!
    @IBOutlet weak var greenRedScoredTV: UILabel!
    @IBOutlet weak var purpleRedScoredTV: UILabel!
    @IBOutlet weak var orangeBlueScoredTV: UILabel!
    @IBOutlet weak var greenBlueScoredTV: UILabel!
    @IBOutlet weak var purpleBlueScoredTV: UILabel!
    @IBOutlet weak var orangeHighTV: UILabel!
    @IBOutlet weak var greenHighTV: UILabel!
    @IBOutlet weak var purpleHighTV: UILabel!
    
    // Scores
    var redScoreVar = 0
    var blueScoreVar = 0
    
    // Red & Blue Cups
    var redFlag = "-"
    var blueFlag = "-"
    
    // In Cups
    var orangeHigh = 0
    var greenHigh = 0
    var purpleHigh = 0
    
    // Scored cubes on each side
    var orangeRedScored = 0
    var greenRedScored = 0
    var purpleRedScored = 0
    var orangeBlueScored = 0
    var greenBlueScored = 0
    var purpleBlueScored = 0
    
    var orangeRedHigh = 0
    var greenRedHigh = 0
    var purpleRedHigh = 0
    var orangeBlueHigh = 0
    var greenBlueHigh = 0
    var purpleBlueHigh = 0
    
    //Default: we're on red side.
    var whichSide = "r"
    
    // Click shells that call
    @objc func onTapGestureRed(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            toggleCups(isRed: true)
        }
    }
    @objc func onTapGestureBlue(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            toggleCups(isRed: false)
        }
    }
    
    /* Handles clicking of Red+Blue-only cups */
    func toggleCups(isRed: Bool){
        if(isRed){
            switch redFlag{
                case "-":self.redCup.image = UIImage(named: "OdRc.png"); redFlag = "o";
                    orangeRedHigh = orangeRedHigh + 1
                case "o":self.redCup.image = UIImage(named: "GdRc.png"); redFlag = "g"
                    orangeRedHigh = orangeRedHigh - 1
                    greenRedHigh = greenRedHigh + 1
                case "g":self.redCup.image = UIImage(named: "PdRc.png"); redFlag = "p"
                    greenRedHigh = greenRedHigh - 1
                    purpleRedHigh = purpleRedHigh + 1
                case "p":self.redCup.image = UIImage(named: "ncRc.png") ; redFlag = "-"
                    purpleRedHigh = purpleRedHigh - 1
                    
                default:self.redCup.image = UIImage(named: "ndRc.png") // should never happen
            }
            // Print all vals to check if math correctly
            let printStatement = "Red. O: " + String(orangeRedHigh) + " G: " + String(greenRedHigh) + " P: " + String(purpleRedHigh)
            print(printStatement);
            updateScore()
        }
        else{
            switch blueFlag{
                case "-":self.blueCup.image = UIImage(named: "OdBc.png"); blueFlag = "o";
                    orangeBlueHigh = orangeBlueHigh + 1
                case "o":self.blueCup.image = UIImage(named: "GdBc.png"); blueFlag = "g"
                    orangeBlueHigh = orangeBlueHigh - 1
                    greenBlueHigh = greenBlueHigh + 1
                case "g":self.blueCup.image = UIImage(named: "PdBc.png"); blueFlag = "p"
                    greenBlueHigh = greenBlueHigh - 1
                    purpleBlueHigh = purpleBlueHigh + 1
                case "p":self.blueCup.image = UIImage(named: "ncBc.png") ; blueFlag = "-"
                    purpleBlueHigh = purpleBlueHigh - 1
                    
                default:self.blueCup.image = UIImage(named: "ndBc.png") // should never happen
            }
            // Print all vals to check if math correctly
            let printStatement = "Blue. O: " + String(orangeBlueHigh) + " G: " + String(greenBlueHigh) + " P: " + String(purpleBlueHigh)
            print(printStatement);
            updateScore()
        }
        
    }
    
    /*
        Recalculates score based on game board state
        AND also updates scored in cube displays
        AND call maximizeHighScore()
     */
    func updateScore(){
        redScoreVar = greenRedScored * (greenHigh+greenRedHigh+greenBlueHigh+1) +  orangeRedScored * (orangeHigh+orangeRedHigh+orangeBlueHigh+1) + purpleRedScored * (purpleHigh + purpleRedHigh + purpleBlueHigh + 1)
        blueScoreVar = greenBlueScored * (greenHigh+greenRedHigh+greenBlueHigh+1) +  orangeBlueScored * (orangeHigh+orangeRedHigh+orangeBlueHigh+1) + purpleBlueScored * (purpleHigh + purpleRedHigh + purpleBlueHigh + 1)
        
        // Display this number up top
        redScoreTV.text = String(redScoreVar)
        blueScoreTV.text = String(blueScoreVar)
        
        //Display new cube vals
        orangeRedScoredTV.text = String(orangeRedScored)
        greenRedScoredTV.text = String(greenRedScored)
        purpleRedScoredTV.text = String(purpleRedScored)
        orangeBlueScoredTV.text = String(orangeBlueScored)
        greenBlueScoredTV.text = String(greenBlueScored)
        purpleBlueScoredTV.text = String(purpleBlueScored)
        orangeHighTV.text = String(orangeHigh)
        greenHighTV.text = String(greenHigh)
        purpleHighTV.text = String(purpleHigh)
        
        // Maximize high score
        maximizeHighScore()
    }
    
    /*Fetch correct high value*/
    func colorInMyTower() -> String{
        var str = ""
        if(whichSide == "r"){return redFlag}
        else{return blueFlag}
    }
    
    func cubesInMyTower() -> Int{
        if(colorInMyTower() == "-"){return 0}
        else{return 1}
    }
    func myScore() -> Int{
        if(whichSide == "r"){return redScoreVar}
        else{return blueScoreVar}
    }
    func theirScore() -> Int{
        if(whichSide == "r"){return blueScoreVar}
        else{return redScoreVar}
    }
    /*Maximize the correct team's score.*/
    func maximizeHighScore(){
        
        // Populate structure holding "my" goal-scored blocks
        var goalArray = Array<Int>(); // o,g,p
        var theirGoalArray = Array<Int>();
        if(whichSide == "r"){
            goalArray.append(contentsOf: [orangeRedScored, greenRedScored, purpleRedScored])
            theirGoalArray.append(contentsOf: [orangeBlueScored, greenBlueScored, purpleBlueScored])

        }else{
            goalArray.append(contentsOf: [orangeBlueScored, greenBlueScored, purpleBlueScored])
            theirGoalArray.append(contentsOf: [orangeRedScored, greenRedScored, purpleRedScored])

        }
        
        var towerArray = Array<Int>();
        towerArray.append(contentsOf: [orangeHigh, greenHigh, purpleHigh])
        
       
        var moves = [String: Int]()
        //moves should have - Place0 : 4, Place1: -1, Place2...
        var charArray = Array<String>()
        charArray.append(contentsOf: ["O", "G", "P", "-"])
        
        for i in 0...2{
            print("goalArray[" + String(i) + "] is " + String(goalArray[i]))
            print("theirGoalArray[" + String(i) + "] is " + String(theirGoalArray[i]))

            // Insert all moves into array.
            if(orangeHigh+greenHigh+purpleHigh+cubesInMyTower() < 6){
                var scoreDiff = myScore() + goalArray[i] - (theirScore()+theirGoalArray[i])
                moves["Place_" + charArray[i] + "          "] = scoreDiff
            }
            
            
            // Replacement + Removal
            if towerArray[i] > 0 || colorInMyTower() == charArray[i]{
                
                for j in 0...2{
                    // If this colored cube is in a tower, checkreplace
                    if j != i {
                        /*The equation for replacing a green cube with an orange is as follows:
                        (#ofOrangeCubesStacked * (#OfOrangePlaced+2)) + (#ofGreenCubesStacked * (#OfgreenPlaced)) +
                        (#ofPurpleCubesStacked * (#OfPurplePlaced+1))*/
                        var scoreDiff = myScore() + goalArray[j] - goalArray[i] - (theirScore() + theirGoalArray[j] - theirGoalArray[i])
                        moves["Repl_" + charArray[i] + " with_" + charArray[j]] = scoreDiff

                    }
                }
                var scoreDiff = myScore() - goalArray[i] - (theirScore() - theirGoalArray[i])
                moves["Rem_" + charArray[i] + "           "] = scoreDiff
            }
            
        }
        
        // Print everything in array
        for (code, num) in moves{
            print("code: \(code) num: \(num)")
        }
        // Sort
        let dictValDec = moves.sorted(by: { $0.value > $1.value })
        print(dictValDec)
        
        var str = ""
        for(code, num) in dictValDec{
            var scoreBoost = num-(myScore()-theirScore())
            if(scoreBoost > 0){
                str.append(code + "\t\t\t\t\t\t\t " + String(scoreBoost) + "\n")
            }
        }
        if str == ""{
            str = "<< - >>"
        }
        
        print(str);
        strategyView.text = str
        
        /*
        //TODO: set text to element 0, for testing
         if let s = moves["Place0"]{
                           strategyView.text = String(s)
                       }else{
                           strategyView.text = "---"
                       }
        */
        
    }
    
/* Increment + Decrement chevrons */
    @IBAction func inc_orangeRedScored(_ sender: UIButton) {
        orangeRedScored += 1;
        print("or_Red: " + String(orangeRedScored))
        updateScore();
    }
    @IBAction func inc_grRedScored(_ sender: UIButton) {
        greenRedScored += 1;
        print("gr_Red: " + String(greenRedScored))
        updateScore();
    }
    @IBAction func inc_purpleRedScored(_ sender: UIButton) {
        purpleRedScored += 1;
        print("purp_Red: " + String(purpleRedScored))
        updateScore();
    }
    //THIs may cause errors. Reconnect again.
    @IBAction func dec_orangeRedScored(_ sender: UIButton) {
        if orangeRedScored > 0 {
        orangeRedScored -= 1;
        print("or_Red: " + String(orangeRedScored))
        updateScore();
        }
    }
    @IBAction func dec_greenRedScored(_ sender: UIButton) {
        if greenRedScored > 0{
            greenRedScored -= 1;
            print("gr_Red: " + String(greenRedScored))
            updateScore();
        }
    }
    @IBAction func dec_purpleRedScored(_ sender: UIButton) {
        if purpleRedScored > 0 {
            purpleRedScored -= 1;
            print("purp_Red: " + String(purpleRedScored))
            updateScore();
        }
    }
    @IBAction func inc_orangeBlueScored(_ sender: UIButton) {
        orangeBlueScored += 1;
        print("or_Bl: " + String(orangeBlueScored))
        updateScore();
    }
    @IBAction func inc_greenBlueScored(_ sender: UIButton) {
        greenBlueScored += 1;
        print("gr_Bl: " + String(greenBlueScored))
        updateScore();
    }
    @IBAction func inc_purpleBlueScored(_ sender: UIButton) {
        purpleBlueScored += 1;
        print("purp_Bl: " + String(purpleBlueScored))
        updateScore();
    }
    @IBAction func dec_orangeBlueScored(_ sender: UIButton) {
        if orangeBlueScored > 0 {
            orangeBlueScored -= 1;
            print("or_Bl: " + String(orangeBlueScored))
            updateScore();
        }
    }
    @IBAction func dec_greenBlueScored(_ sender: UIButton) {
        if greenBlueScored > 0 {
            greenBlueScored -= 1;
            print("gr_Bl: " + String(greenBlueScored))
            updateScore();
        }
    }
    @IBAction func dec_purpleBlueScored(_ sender: UIButton) {
        if purpleBlueScored > 0 {
            purpleBlueScored -= 1;
            print("purp_Bl: " + String(purpleBlueScored))
            updateScore();
        }
    }
    
    // " for Cups
    
    @IBAction func inc_orangeHigh(_ sender: UIButton) {
        orangeHigh += 1;
        updateScore();
    }
    @IBAction func dec_orangeHigh(_ sender: UIButton) {
        if(orangeHigh > 0){
            orangeHigh -= 1;
            updateScore();
        }
    }
    @IBAction func inc_greenHigh(_ sender: UIButton) {
        greenHigh += 1;
        updateScore();
    }
    @IBAction func dec_greenHigh(_ sender: UIButton) {
        if(greenHigh > 0){
            greenHigh -= 1;
            updateScore();
        }
    }
    @IBAction func inc_purpleHigh(_ sender: UIButton) {
        purpleHigh += 1;
        updateScore();
    }
    @IBAction func dec_purpleHigh(_ sender: UIButton) {
        if(purpleHigh > 0){
            purpleHigh -= 1;
            updateScore();
        }
    }
    

}
