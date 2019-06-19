//
//  ViewController.swift
//  The Adventures Of Rabbi Goldberg
//
//  Created by Sean Shmulevich on 6/13/19.
//  Copyright © 2019 Sean Shmulevich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var index = 1//variable to keep track of story and show new text on buttonPressed action
    var playerChoice : String = ""//Holds the player choice i.e. player 1 or player 2 in order to be used in strings
    var playerAtt : String = ""//Holds the player choice main attribute i.e. - Smart Rabbi, Strong Rabbi, Fast Rabbi
    var rabbi: Player = Player()//empty rabbi player object to be intialized later
    var enemy1: Enemy = Enemy(health: 0, speed: 0, power: 0, level: 0)//empty enemy object to be re intialized for every new enemy
    var enemyIndex = 0 //Keeps track of how many enemies have been fought so that the level of the enemies can go up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        story.text = intro
        
        //sets button1 to next and hides lower two
        button1.setTitle("Next", for: .normal)
        button2.isHidden = true
        button3.isHidden = true
    }

    @IBOutlet weak var gameImage: UIImageView!//might incorporate images later
    @IBOutlet weak var story: UITextView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    ///makes random enemy based on level
    //should also differentiate based on type
    func randomEnemy(level: Int){
        
        //randomizes type every time
        enemy1.newType()
        
        //creates variables to keep track of random enemy creation stats based off level
        var health = 0
        var speed = 0
        var power = 0
        
        enemy1.setLevel(lev: level)
        
        if(level <= 3)
        {
            //Checks type and initializes variables based off type
            if(enemy1.getType() == "fire")
            {
                //Starting values for types
                //fire is inherentaly slower but does more damage
                health = 25
                speed = 10
                power = 20
            }
            else if(enemy1.getType() == "water")
            {
                //Water is faster but weaker
                health = 30
                speed = 20
                power = 10
            }
            else if(enemy1.getType() == "faku")
            {
                //Faku is a balanced type
                health = 30
                speed = 15
                power = 15
            }
            
            //increments values for class varaibles based off level
            
            for _ in 1..<level
            {
                health += 20
                power += 10
                speed += 10
            }
            
            //sets values after they have been affected by their level
            enemy1.setLevel(lev: power)
            enemy1.setHealth(hea: health)
            enemy1.setSpeed(spd: speed)
            enemy1.setPower(pow: power)
        }
    }
    
    //Hides bottom two buttons and sets the text of button 1 to "Next"
    //(Commom action)
    func showNext()
    {
        button2.isHidden = true
        button3.isHidden = true
        button1.setTitle("Next", for: .normal)
    }
    
    //automatically shows all buttons and takes parameters to set text
    func setButtons(s1: String, s2: String, s3: String)
    {
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button1.setTitle(s1, for: .normal)
        button2.setTitle(s2, for: .normal)
        button3.setTitle(s3, for: .normal)
    }
    
    //Used in battle for checking if the battle is over
    func checkOver(p1: Player, enemy: Enemy, nextIndex: Int) -> Int
    {
        //if player health is less than 0 return the index for the buttonPressed action of player died
        if(p1.getHealth() <= 0)
        {
            return 16
        }
        //if enemy dies return the index for the button pressed action for the enemy dying
        else if(enemy.getHealth() <= 0)
        {
            return 17
        }
        //else neither are dead return to the next person who's turn it is to attack
        return nextIndex
    }
    
    //The only action in the whole game is a button press
    //all three buttons are linked to this action function with different tags
    
    @IBAction func choice(_ sender: UIButton) {
        
        //How index works
        //index changes every time a button is pressed for a new if statment to run and story.text to change
        //for example index starts at 1 and after (if (index == 1)) runs index is set to 2 which means next time
        //the next if statment will run
        
        if(index == 1)
        {
            //intro to picking character
            
            story.text = "it's time to pick your Rabbi Goldberg you have three choices."
            index = 2
        }
        else if (index == 2)
        {
            //fast rabbi option
            story.text = fastRabbi
            index = 3
        }
        else if (index == 3)
        {
            //strong rabbi option
            story.text = strongRabbi
            index = 4
        }
        else if (index == 4)
        {
            //smart rabbi option
            story.text = smartRabbi
            index = 5
        }
        else if (index == 5)
        {
            story.text = "Pick Your Character"
            
            //uses setting button function to show all buttons and set them so that the user can make their player choice
            setButtons(s1: "Player 1",s2: "Player 2",s3: "Player 3")

            index = 6
        }
        else if (index == 6 && sender.tag == 1)
        {
            //Sets variables for use in strings
            playerChoice = "Player \(sender.tag)"
            playerAtt = "Fast Rabbi"
            
            //Uses varables set previously to display player choice
            story.text = "You have chosen \(playerChoice) the \(playerAtt) have fun!"
            
            //This Rabbi is fast but weaker
            rabbi.setHealth(hea: 50)
            rabbi.setSpeed(spd: 25)
            rabbi.setPower(pow: 12)
            rabbi.setLevel(lev: 1)
            
            index = 7
            
            //Shows next so the user can continue on his story after having picked his rabbi and set his stats
            showNext()
        }
        else if (index == 6 && sender.tag == 2)
        {
            playerChoice = "Player \(sender.tag)"
            playerAtt = "Strong Rabbi"
            story.text = "You have chosen \(playerChoice) the \(playerAtt) have fun!"
            
            //This Rabbi is stronger but slower
            rabbi.setHealth(hea: 50)
            rabbi.setSpeed(spd: 10)
            rabbi.setPower(pow: 25)
            rabbi.setLevel(lev: 1)
            
            index = 7
            showNext()
        }
        else if (index == 6 && sender.tag == 3)
        {
            playerChoice = "Player \(sender.tag)"
            playerAtt = "Smart Rabbi"
            story.text = "You have chosen \(playerChoice) the \(playerAtt) have fun!"
            
            //Medium speed and power more health
            rabbi.setHealth(hea: 60)
            rabbi.setSpeed(spd: 15)
            rabbi.setPower(pow: 15)
            rabbi.setLevel(lev: 1)
            
            index = 7
            showNext()
        }
        else if(index == 7) {
            //Story Call From Pres
            story.text = """
            \(playerAtt), Rabbi Goldburg receives a phone call from the president of the united states and CEO of Facebook, Mark Zuckerberg, he is calling from a top secret bunker in an undisclosed location, the government needs Rabbi Goldburg's help. The servants of Zanis have attacked New York City the Pentagon and the White House
            """
            index = 8
        }
        else if (index == 8)
        {
            //Pick Location
            setButtons(s1: "Pentagon", s2: "White House", s3: "New York City")
            story.text = "Where will you go to find Zanis"
            index = 9
        }
        else if (index == 9 && sender.tag == 1)
        {
            //Go to Pentagon
            showNext()
            story.text = "You, Rabbi Goldberg must now travel to the Pentagon in search of Zanis, you are the savior. You embark on your journey and begin your journey to the Pentagon, you must protect the nation's secrets and as well as America."
            index = 10
        }
        else if (index == 10)
        {
            //Arrive at pentagon
            story.text = "You arrive at the Pentagon after days of perilous travel, Zanis and his servants have already taken over, you see the ruins of what once was on your country now everybody is in hiding or has been brainwashed by Zanis, It is time. You must protect the nation's secrets and nuclear weapons at the Pentagon."
            index = 11
        }
        else if (index == 11)
        {
            //Which Entrance into the pentagon
            
            //only top 2 buttons
            button3.isHidden = true
            button2.isHidden = false
            
            //Set Options
            button1.setTitle("The Metro Entrance Facility(nuclear weapons)", for: .normal)
            button2.setTitle("Corridor 5 Entrance(the nations secrets)", for: .normal)
            
            index = 12
        }
        else if (index == 12 && sender.tag == 1)
        {
            //Metro Entrance Find Enemy
            story.text = "You approach the Pentagon entrance located nearest to the Metro Station, is located near Corridor 10 on the first floor you see an arsenal of secret experimental weapons you fear if any of the weapons or information is compromised the whole world could be in danger. Just past an experimental fusion energy bomb, you see a servant of Zanis, he growls at you with anger in his eyes. He jumps and attacks you. The servant looks at you and says “It all ends now for you” The battle begins."
            button1.setTitle("Battle", for: .normal)
            button2.isHidden = true
            
            index = 13
        }
        else if (index == 12 && sender.tag == 2)
        {
            //Corridor 5 Entrance
        }
        else if (index == 13 && sender.tag == 1)
        {
            //Increments the amount of enemies fought
            enemyIndex += 1
            
            //Temporarily creates an enemy of level 1
            //should create level based on enemiesIndex
            randomEnemy(level: 1)
            
            //Set Buttons to Pick move
            showNext()
            
            story.text = "you have stumbled upon a \(enemy1.getType()) type servent with \(enemy1.getPower()) power, \(enemy1.getHealth()) health, and \(enemy1.getSpeed()) speed get ready to fight"
            
            //Faster Entity moves first
            if(rabbi.getSpeed() > enemy1.getSpeed())
            {
                index = 14
            }
            else{
                index = 15
            }
        }
            
        else if (index == 14 && sender.tag == 1)
        {
            //Rabbi Attack
            
            showNext()
            
            //Attacks Enemy and sets game text
            story.text = rabbi.attack(enemy: enemy1)
            
            //checks index to see if anybody died yet
            index = checkOver(p1: rabbi, enemy: enemy1, nextIndex: 15)
        }
        else if (index == 14 && sender.tag == 2)
        {
            //Rabbi Dodge
            showNext()
            story.text = rabbi.dodge()
            index = checkOver(p1: rabbi, enemy: enemy1, nextIndex: 15)
        }
        else if(index == 14 && sender.tag == 3)
        {
            //Rabbi Attack Dodge
            showNext()
            story.text = rabbi.attackDodge(enemy: enemy1)
            index = checkOver(p1: rabbi, enemy: enemy1, nextIndex: 15)
        }
            
        else if (index == 15)
        {
            //Enemy Attacks
            setButtons(s1: "Attack", s2: "Dodge", s3: "Attack + Chance to Dodge")
            story.text = enemy1.attack(player: rabbi)
            index = checkOver(p1: rabbi, enemy: enemy1, nextIndex: 14)
            
        }
        else if (index == 16)
        {
            //Rabbi Dies lives - 1
            showNext()
            rabbi.setLives(lives: rabbi.getLives()-1)
            story.text = "rabbi died and lost a life rabbi now has \(rabbi.getLives()) lives left"
        }
        else if (index == 17)
        {
            //add ex possible level up
            rabbi.addExp(amt: 10*(enemy1.getLevel()))
            var str = rabbi.checkLevelUp()
            showNext()
            story.text = "Enemy died\(str)"
        }
    
    }

    
}

