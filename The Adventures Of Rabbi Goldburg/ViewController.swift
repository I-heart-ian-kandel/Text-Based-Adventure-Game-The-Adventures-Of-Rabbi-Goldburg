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
    var pathIndex = 0 //Determines where to go after a battle since battaling happens a lot
    var placesPicked = ["","",""]
    var hasPowerBoost = false
    var williamsburg = false
    var timeSquare = false
    override func viewDidLoad() {
        super.viewDidLoad()
        story.text = intro
        
        //sets button1 to next and hides lower two
        button1.setTitle("Next", for: .normal)
        button2.isHidden = true
        button3.isHidden = true
        image.isHidden = true
    }

    @IBOutlet weak var gameImage: UIImageView!//might incorporate images later
    @IBOutlet weak var story: UITextView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    
    
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
        
        if(level <= 5)
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
            enemy1.setHealth(hea: health)
            enemy1.setSpeed(spd: speed)
            enemy1.setPower(pow: power)
        }
    }
    
    //resets player stats after a battle
    func resetStats(player: Player)
    {
        var health = 0
        var speed = 0
        var power = 0
        if(playerAtt == "Fast Rabbi")
        {
            health = 50
            speed = 25
            power = 15
           
        }
        else if(playerAtt == "Strong Rabbi")
        {
            health = 50
            speed = 10
            power = 25
        }
        else if(playerAtt == "Smart Rabbi")
        {
            health = 70
            speed = 15
            power = 15
        }
        
        for _ in 1..<player.getLevel()
        {
            health += 20
            power += 10
            speed += 12
        }
        rabbi.setHealth(hea: health)
        rabbi.setSpeed(spd: speed)
        rabbi.setPower(pow: power)
        
    }
    
    //Hides bottom two buttons and sets the text of button 1 to "Next"
    //(Commom action)
    func showNext()
    {
        button1.isHidden = false
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
            showNext()
            enemyIndex = 0
            rabbi.resetExp()
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
            image.isHidden = false
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
            story.text = "You have chosen \(playerChoice) the \(playerAtt) with 50 base health, 25 speed, and 15 power"
            
            //This Rabbi is fast but weaker
            rabbi.setHealth(hea: 50)
            rabbi.setSpeed(spd: 25)
            rabbi.setPower(pow: 15)
            rabbi.setLevel(lev: 1)
            
            index = 7
            
            //Shows next so the user can continue on his story after having picked his rabbi and set his stats
            showNext()
        }
        else if (index == 6 && sender.tag == 2)
        {
            playerChoice = "Player \(sender.tag)"
            playerAtt = "Strong Rabbi"
            story.text = "You have chosen \(playerChoice) the \(playerAtt) with 50 base health, 10 speed, and 25 power"
            
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
            story.text = "You have chosen \(playerChoice) the \(playerAtt) with 60 base health, 15 speed, and 15 power"
            
            //Medium speed and power more health
            rabbi.setHealth(hea: 60)
            rabbi.setSpeed(spd: 15)
            rabbi.setPower(pow: 15)
            rabbi.setLevel(lev: 1)
            
            index = 7
            showNext()
        }
        else if(index == 7) {
            image.isHidden = true
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
        else if (index == 9 && sender.tag == 1 || (index == 22 && sender.tag == 1))
        {
            //Go to Pentagon
            placesPicked[0] = "Pentagon"
            showNext()
            story.text = "You, Rabbi Goldberg must now travel to the Pentagon in search of Zanis, you are the savior. You embark on your journey and begin your journey to the Pentagon, you must protect the nation's secrets and as well as America."
            index = 10
        }
        else if (index == 9 && sender.tag == 2 || (index == 22 && sender.tag == 2))
        {
            ///White House
            showNext()
            placesPicked[1] = "White House"
            story.text = "You, Rabbi Goldberg must now travel to the Nations Capital in search of the all powerful Zanis, because of your faith and spiritual power you are America's greatest chance. You arrive at the White house, you must protect the President and save America"
            index = 23
        }
        else if(index == 23)
        {
            //Arrive at Capitol
            showNext()
            story.text = "You travel to the white house outside you see swarms of Zanis’s mindless servants all having lost touch with Happiness and their true selves. You sense a great danger and head inside you think Zanis might be nearby. You are channeling all of your magic from the ancient book of Kaballah."
            index = 24
        }
        else if (index == 24)
        {
            //pick path white house
            story.text = "As you head inside you are left with 2 paths will you"
            button2.isHidden = false
            button1.setTitle("Head into the Oval Office", for: .normal)
            button2.setTitle("Head underground", for: .normal)
            index = 25
        }
        else if (index == 25 && sender.tag == 1)
        {
            //Into the oval office trap
            story.text = "As you head into the oval office you hear a voice in your head possessing you it is Zanis you hear “It all ends now you have FAILED” the floor in the oval office starts to open up you see fire under the floor you are certain you will fall to your death underground what will you do"
            setButtons(s1: "Try to reach the door to escape", s2: "Jump into the Fire", s3: "Panic")
            index = 26
        }
        else if (index == 26 && sender.tag == 1)
        {
            //20% chance to get out in time, 80% to die in the fire
            let randomNum = Int.random(in: 1...5)
            if (randomNum <= 2)
            {
                story.text = "You escaped in time and made it out the door before you could fall into the fire now you think you should head underground to check for Zanis or any other potential threats"
                button3.isHidden = true
                button2.setTitle("Don't take a shortcut", for: .normal)
                button1.setTitle("Take a shortcut", for: .normal)
                index = 27
            }
            else{
                if(rabbi.getLives() <= 1)
                {
                    showNext()
                    rabbi.setLives(lives: rabbi.getLives() - 1)
                    story.text = "Oops you couldn’t make it in time and you fell into the fire you hear Zanis laughing and the world is doomed. you lose one life now you have \(rabbi.getLives() - 1) lives left, you will have to go underground now"
                    button2.setTitle("Don't take a shortcut", for: .normal)
                    button1.setTitle("Take a shortcut", for: .normal)
                    index = 27
                }
                else{
                    story.text = "Oops you couldn’t make it in time and you fell into the fire you hear Zanis laughing and the world is doomed. Press Reset to try again"
                    button1.setTitle("Reset", for: .normal)
                    index = 1
                }
            }
        }
        else if (index == 26 && sender.tag == 2)
        {
            //User Picks Jump into the fire
            // 50% chance to live, 50% chance to Die
            let randomNum = Int.random(in: 1...2)
            if(randomNum == 1)
            {
                story.text = "You jump straight into the fire you feel yourself protected by a higher power you are ready to take on what is next! you have to head underground now"
                button3.isHidden = true
                button2.setTitle("Don't take a shortcut", for: .normal)
                button1.setTitle("Take a shortcut", for: .normal)
                index = 27
            }
            else{
                if(rabbi.getLives() <= 1)
                {
                    showNext()
                    rabbi.setLives(lives: rabbi.getLives() - 1)
                    story.text = "Oops you couldn’t make it in time and you fell into the fire you hear Zanis laughing and the world is doomed. you lose one life now you have \(rabbi.getLives() - 1) lives left, you will have to go underground now"
                    button2.setTitle("Don't take a shortcut", for: .normal)
                    button1.setTitle("Take a shortcut", for: .normal)
                    index = 27
                }
                else{
                    story.text = "Oops you couldn’t make it in time and you fell into the fire you hear Zanis laughing and the world is doomed. Press Reset to try again"
                    button1.setTitle("Reset", for: .normal)
                    index = 1
                }
            }
            
        }
        else if (index == 26 && sender.tag == 3)
        {
            //Rabbi Panics
            if(rabbi.getLives() <= 1)
            {
                showNext()
                rabbi.setLives(lives: rabbi.getLives() - 1)
                story.text = "Oops you couldn’t make it in time and you fell into the fire you hear Zanis laughing and the world is doomed. you lose one life now you have \(rabbi.getLives() - 1) lives left, you will have to go underground now"
                button2.setTitle("Don't take a shortcut", for: .normal)
                button1.setTitle("Take a shortcut", for: .normal)
                index = 27
            }
            else{
                story.text = "Oops you couldn’t make it in time and you fell into the fire you hear Zanis laughing and the world is doomed. Press Reset to try again"
                button1.setTitle("Reset", for: .normal)
                index = 1
            }
        }
        else if(index == 27 && sender.tag == 1 || (index == 103))
        {
            //Dont take a shortcut
            //Fight the Vice Pres
            story.text = "You Choose not to take a shortcut, you head underground but on your way you see vice president Joe Biden you are relived to see him but he looks at you and laughs. He says \" There is noting you can do to stop us now the games are over, the battle begins \" "
            
            button1.setTitle("Battle", for: .normal)
            button2.isHidden = true
            index = 28
            pathIndex = 6
        }
        else if (index == 25 && sender.tag == 2 || index == 29 || (index == 27 && sender.tag == 2))
        {
            //Underground at the white house
            //or if you take a shortcut from escaping the oval office
            story.text = "You arrive underground along the halls of the secret bunker you see unconscious politicians and secret service men and women along the walls there is a light at the end of the hallway you go towards the light, as you move closer you feel a great evil is nearby"
            showNext()
            index = 30
        }
        else if (index == 30)
        {
          story.text = "You reach a room at the end of the underground bunker in it you see president mark Zuckerberg.  But wait, you think to yourself “maybe there never was a Zanis”. Maybe Zanis just represented all of society’s current problems. Maybe Zanis was just a metaphor for the negativity that seems to be exponentially growing in the world, and those servants were just little bits of toxic and unhealthy behaviors,"
          index = 31
        }
        else if(index == 31)
        {
            story.text = "The president looks at you and says, \" I Am Zanis and there is nothing you can do to deafeat me but it was fun to watch you try\" the president explains his diabolical plot about how Facebook and the smartphone revolution were his means to take over the world, using Facebook to rewire peoples brains and brainwash them."
            index = 32
        }
        else if (index == 32)
        {
            story.text = "You ask, \"But why to call me and ask me to be a protector and to save everybody\""
            index = 33
        }
        else if(index == 33)
        {
            story.text = "He responds by saying \" because I knew you were the only person who could save everybody and I thought it would be more fun this way and now it is your time to perish \""
            index = 34
        }
        else if(index == 34 || index == 104)
        {
            story.text = "This is your last change to save the people you need to give it your all and save the world"
            button1.setTitle("Battle", for: .normal)
            if(hasPowerBoost)
            {
                button2.isHidden = false
                button2.setTitle("Eat Strange Herb", for: .normal)
                index = 36
            }
            else{
                index = 35
            }
            pathIndex = 7
        }
        else if(index == 36)
        {
            story.text = "You eat the strange looking tea leaves from the old man in New York you feel positivity flow through you and the spirits of the ones who need saving your stats skyrocket and you start to glow"
            rabbi.setHealth(hea: rabbi.getHealth()+30)
            rabbi.setSpeed(spd: 100000)
            rabbi.setPower(pow: rabbi.getPower()+15)
            pathIndex = 7
            button2.isHidden = true
            index = 35
        }
        else if (index == 9 && sender.tag == 3 || (index == 22 && sender.tag == 3))
        {
            ///NYC
            showNext()
            button2.isHidden = false
            button1.setTitle("Go To Times Square", for: .normal)
            button2.setTitle("Go To Williamsburg", for: .normal)
            placesPicked[2] = "NYC"
            story.text = "You arrive in New York City, what once was a modern palace of art, culture, and society is left in ruins flooded with negativity and you rabbi Goldberg are the only light of hope. The streets are empty you feel a cool wind on the back of your neck and you hear a faint scream in the distance."
            index = 37
        }
        else if (index == 37 && sender.tag == 1 || (index == 150 && sender.tag == 1))
        {
            //Times Square
            timeSquare = true
            story.text = "You Head to times square to seek out Zanis. You arrive to see what once was has been left in shambles. Not a soul to be seen"
            button1.setTitle("Walk out into the distance", for: .normal)
            button2.setTitle("Yell for a servant to attack you", for: .normal)
            index = 38
        }
        else if (index == 37 && sender.tag == 2  || (index == 40 && sender.tag == 1))
        {
            //Williamsburg
            williamsburg = true
            story.text = "You arrive in Williamsburg ready to see the same destruction as everywhere else but here the buildings are intact and the streets are clear you even see some hints of refugee camps nearby but you also see brainwashed citizens everywhere."
            showNext()
            index = 41
        }
        else if(index == 41)
        {
            story.text = "Where will you go to find Zanis or fight other evils"
            setButtons(s1: "Go to the Park", s2: "Go get fancy Ramen", s3: "")
            button3.isHidden = true
            index = 42
        }
        else if (index == 42 && sender.tag == 1)
        {
            story.text = "As you approach the park you see a colony of servants of Zanis, they all growl at your presence. If you can defeat the clan leader you can capture the whole clan. You ask \"Who is your leader\""
            showNext()
            index = 43
        }
        else if (index == 43)
        {
            story.text = "The tallest scariest enemy approaches. He says \"I have fought and defeated all who have crossed my path what makes you think you can defeat me\""
            index = 44
        }
        else if(index == 44 || index == 106)
        {
            story.text = "You say nothing it is time for battle"
            button1.setTitle("Battle", for: .normal)
            index = 13
            pathIndex = 9
        }
        else if (index == 42 && sender.tag == 2)
        {
            //Ramen Resturaunt
            let randomNumber = Int.random(in: 1...5)
            if(randomNumber >= 3)
            {
                showNext()
                if(rabbi.getLives() <= 1)
                {
                    story.text = "The ramen restaurant is a trap and the ramen is poisoned you are now under mind control and will obey Zanis’s every command. Press Reset in order to try again."
                    button1.setTitle("Reset", for: .normal)
                    index = 1
                }
                else
                {
                    rabbi.setLives(lives: rabbi.getLives() - 1)
                    story.text = "The ramen restaurant is a trap and the ramen is poisoned you are now under mind control and will obey Zanis’s every command. you now how \(rabbi.getLives()) lives left press next to go to the park"
                    showNext()
                    index = 42
                }
                
            }
            else{
                story.text = "The Ramen is so good and you feel energized and ready for battle somebody tells you that people need help at the park, you head to the park after your meal."
                index = 42
                showNext()
                
            }
        }
        else if (index == 38 && sender.tag == 1 || index == 105)
        {
            //Walk Out into the distance
            story.text = "You walk out into the distance when you see a servant of Zanis he runs at you and you get ready for battle"
            showNext()
            button1.setTitle("Battle", for: .normal)
            pathIndex = 8
            index = 13
            
        }
        else if (index == 38 && sender.tag == 2)
        {
            //Yell for a servant to attack you
            story.text = "You yell \"Come and get me demons\" you open your eyes and see a servant running at you. He says \"next time make it a little less easy prepare to die\""
            showNext()
            button1.setTitle("Battle", for: .normal)
            pathIndex = 8
            index = 13
        }
        else if(index == 39 && sender.tag == 1)
        {
            //Take the herb from the homeless man
            story.text = "You take the herb from the homeless man and put it in your pocket. Where will you go next?"
            button3.isHidden = true
            button1.isHidden = true
            hasPowerBoost = true
            if(!williamsburg)
            {
                button1.isHidden = false
                button1.setTitle("Go to Williamsburg", for: .normal)
            }
            button2.setTitle("Airport", for: .normal)
            index = 40
        }
        else if(index == 39 && sender.tag == 2)
        {
            //Decline the herb
            story.text = "You do not take the herb from the homeless man. Where will you go next?"
            button1.isHidden = true
            if(!williamsburg)
            {
                button1.isHidden = false
                button1.setTitle("Go to Williamsburg", for: .normal)
            }
            button2.setTitle("Airport", for: .normal)
            index = 40
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
            button1.setTitle("The Metro Entrance", for: .normal)
            button2.setTitle("Corridor 5 Entrance", for: .normal)
            
            index = 12
        }
        else if (index == 12 && sender.tag == 1 || (index == 20 && sender.tag == 1) || index == 101)
        {
            //Metro Entrance Find Enemy
            story.text = "You approach the Pentagon entrance located nearest to the Metro Station, is located near Corridor 10 on the first floor you see an arsenal of secret experimental weapons you fear if any of the weapons or information is compromised the whole world could be in danger. Just past an experimental fusion energy bomb, you see a servant of Zanis, he growls at you with anger in his eyes. He jumps and attacks you. The servant looks at you and says “It all ends now for you” The battle begins."
            button1.setTitle("Battle", for: .normal)
            button2.isHidden = true
            
            if(index == 20)
            {
                pathIndex = 4
            }
            else{
                pathIndex = 1
            }
            index = 13
        }
        else if (index == 12 && sender.tag == 2 || (index == 19 && sender.tag == 1) || (index == 102))
        {
            story.text = "You approach the Pentagon and enter into Corridor 5, where the nation's deepest, darkest secrets are kept. Just past a file cabinet, you see an angry servant ready to fight. "
            button1.setTitle("Battle", for: .normal)
            button2.isHidden = true
            button3.isHidden = true
            
            if(index == 19)
            {
                pathIndex = 5
            }
            else{
                pathIndex = 2
            }
            index = 13
            
        }
        else if (index == 13 && sender.tag == 1 || (index == 28)||(index == 35))
        {
            //Increments the amount of enemies fought
            enemyIndex += 1
            print(enemyIndex)
            
            //Temporarily creates an enemy of level 1
            //should create level based on enemiesIndex
            //vice president battle
            if(index == 28)
            {
                randomEnemy(level: 3)
            }
            else if(index == 35)
            {
                randomEnemy(level: 4)
            }
            else if(enemyIndex <= 2)
            {
                randomEnemy(level: 1)
            }
            else if (enemyIndex <= 4)
            {
                randomEnemy(level: 2)
            }
            else if (enemyIndex <= 5)
            {
                randomEnemy(level: 3)
            }
            
            
            story.text = "you have stumbled upon a \(enemy1.getType()) type servent with \(enemy1.getPower()) power, \(enemy1.getHealth()) health, and \(enemy1.getSpeed()) speed get ready to fight"
            
            //Faster Entity moves first
            if(rabbi.getSpeed() > enemy1.getSpeed())
            {
                index = 14
                //Set Buttons to Pick move
                setButtons(s1: "Attack", s2: "Dodge", s3: "Attack + Chance to Dodge")
            }
            else{
                index = 15
                showNext()
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
            
            index = 99
        }
        else if (index == 17)
        {
            //Rabbi wins
            //Reset Stats
            resetStats(player: rabbi)
            
            //add ex possible level up
            rabbi.addExp(amt: 10*(enemy1.getLevel()))
            var str = rabbi.checkLevelUp()
            
            showNext()
            story.text = "Enemy died\(str)"
            index = 18
        }
        else if(index == 18 && pathIndex == 1)
        {
            story.text = " After you have defeated the servant, you feel more powerful, ready to save the world, and ready to find Zanis. You see a second servant. He screams “YOU DEFEATED MY FRIEND! TIME FOR YOU TO BE DEFEATED! You will never stop us.” The battle begins."
            button1.setTitle("Battle", for: .normal)
            
            index = 13
            pathIndex = 3
        }
        else if (index == 18 && pathIndex == 2)
        {
            story.text = "There is nothing here other than that dead servant. It looks like most of the files have been moved or destroyed. You look around and it is eerily quiet. You aren’t sure what to do, but you realize Zanis isn’t here. Where will you go next?"
            button2.isHidden = false
            button1.setTitle("Metro Entrance", for: .normal)
            button2.setTitle("Airport", for: .normal)
            index = 20
        }
        else if (index == 18 && pathIndex == 3)
        {
            story.text = "You look around and it is eerily quiet. You aren’t sure what to do, but you realize Zanis isn’t here. Where will you go next?"
            button2.isHidden = false
            button1.setTitle("Corridor 5 Entrance", for: .normal)
            button2.setTitle("Airport", for: .normal)
            index = 19
        }
        else if (index == 18 && pathIndex == 4)
        {
            story.text = "You look around and it is eerily quiet. You aren’t sure what to do, but you realize Zanis isn’t here you have already searched both entrances. Zanis isnt at the pentagon where will you go next"
            button2.isHidden = true
            button1.setTitle("Airport", for: .normal)
            index = 21
        }
        else if (index == 18 && pathIndex == 5)
        {
            story.text = "There is nothing here other than that dead servant. It looks like most of the files have been moved or destroyed. You look around and it is eerily quiet. You aren’t sure what to do, you have already searched both entrances. Zanis isnt at the pentagon where will you go next"
            button2.isHidden = true
            button1.setTitle("Airport", for: .normal)
            index = 21
        }
        else if (index == 18 && pathIndex == 6)
        {
            story.text = "You have defeated the vice president you wonder if he was brainwashed too but he didnt look brainwashed? you wonder what is happening and if you can even do anything to change it you head underground in search of more evil"
            showNext()
            index = 29
        }
        else if (index == 18 && pathIndex == 7)
        {
            story.text = "The President of the United States of America and CEO of Facebook, who conspiracy theorists believe is the head of the Reptilian Army has been defeated you feel the darkness being lifted you see everybody around you start to wake up, It will be a while before the damage is undone and families are reunited but there are brighter tomorrow's along the horizon. The End :) press reset to start over"
            showNext()
            button1.setTitle("Reset", for: .normal)
            index = 1
        }
        else if (index == 18 && pathIndex == 8)
        {
            story.text = "You defeat the servant and begin to walk down the street, there was a homeless man watching your battle, he was not possessed but he was pushed away by society he looks at you and thanks you for your protection. He offers you a strange herb. Do You take it?"
            setButtons(s1: "Yes", s2: "No", s3: "")
            button3.isHidden = true
            index = 39
        }
        else if (index == 18 && pathIndex == 9)
        {
            story.text = "You defeated the head of the clan and captured the rest of the servants Williamsburg is now safe thanks to you where will you go next."
            button2.isHidden = false
            button1.isHidden = true
            if(!timeSquare)
            {
                button1.isHidden = false
                button1.setTitle("Go to Times Square", for: .normal)
            }
            button2.setTitle("Airport", for: .normal)
            index = 150
        }
        else if (index == 99)
        {
            story.text = "Would You Like to try again or go back to the airport"
            setButtons(s1: "Try Again", s2: "Airport", s3: "")
            button3.isHidden = true
            index = 100
        }
        else if (index == 100 && sender.tag == 1)
        {
            if(pathIndex == 1)
            {
                index = 101
            }
            else if (pathIndex == 2)
            {
                index = 102
            }
            else if (pathIndex == 4)
            {
                index = 101
            }
            else if (pathIndex == 5)
            {
                index = 102
            }
            else if (pathIndex == 6)
            {
                index = 103
            }
            else if (pathIndex == 7)
            {
                index = 104
            }
            else if (pathIndex == 8)
            {
                index = 105
            }
            else if (pathIndex == 9)
            {
                index = 106
            }
        }
        else if(index == 19 && sender.tag == 2 || (index == 20 && sender.tag == 2) || (index == 21 && sender.tag == 1) || (index == 40 && sender.tag == 2) || (index == 100 && sender.tag == 2) || (index == 150 && sender.tag == 2))
        {
            story.text = "You Have arrived at the airport where will you go next"
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            
            if(placesPicked[0] != "Pentagon")
            {
                button1.isHidden = false
                button1.setTitle("Pentagon", for: .normal)
            }
            if(placesPicked[1] != "White House")
            {
                button2.isHidden = false
                button2.setTitle("White House", for: .normal)
            }
            if(placesPicked[2] != "NYC")
            {
                button3.isHidden = false
                button3.setTitle("New York City", for: .normal)
            }
            if(placesPicked[0] == "Pentagon" && placesPicked[1] == "White House" && placesPicked[2] == "NYC")
            {
                button2.isHidden = false
                button2.setTitle("Go to the White House", for: .normal)
            }
            index = 22
        }
    
    }

    
}

