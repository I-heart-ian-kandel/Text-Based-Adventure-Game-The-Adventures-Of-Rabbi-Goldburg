//
//  Player.swift
//  The Adventures Of Rabbi Goldburg
//
//  Created by Sean Shmulevich on 6/16/19.
//  Copyright © 2019 Sean Shmulevich. All rights reserved.
//

import Foundation
import UIKit
class Player: Entity
{
    //class variables
    var playerLives: Int
    var playerExp = 0

    //Initializers
    init(health: Int, speed : Int, power : Int, level : Int, playerLives: Int)
    {
        self.playerLives = playerLives
        super.init(health: health, speed: speed, power: power, level: level)
    }
    convenience init()
    {
        self.init(health: 0, speed: 0, power: 0, level: 0, playerLives: 2)
    }

    //Checks to make sure any attack does not go into the negatives
    //a is a nerf variable for lower power attacks like when dodge misses
    func attackCheck(enemy: Enemy, a: Int) -> Int
    {
        if((enemy.getHealth()-(power - a)) < 0)
        {
            return 0
        }
        else
        {
            return (enemy.getHealth() - (power - a))
        }
    }
    
    //Attack function
    //sets enemy health to enemy Health - power
    //returns a string that says what happeded and current standings
    //story.text is set to equal this function when it is called in view controller
    func attack(enemy: Enemy) -> String
    {
        enemy.setHealth(hea: attackCheck(enemy: enemy, a: 0))
        return "you attack! you do \(power) damge to the servent the servent now has \(enemy.getHealth()) health"
    }
    
    func dodge() -> String
    {
        //dodge amt is based on level and if health is max then it wont work
        if(health <= 50 && (level == 1 || level == 2))
        {
           health += 5
            return "You dodged and gained 5 health you now have \(health)"
        }
        else if(health <= 70 && level >= 3)
        {
            health += 10
            return "You dodged and gained 10 health you now have \(health)"
        }
        
        return("Health full You Cannot dodge")
    }
    
    func attackDodge(enemy: Enemy) -> String
    {
        //40% chance to sucessfully dodge and attack
        let randomNum = Int.random(in: 1...10)
        if (randomNum <= 5)
        {
            enemy.setHealth(hea: attackCheck(enemy: enemy, a: 0))
            health += 5
            return "you attack! you do \(power) damge to the servent the servent now has \(enemy.getHealth()) health you also dodge and gain 5 health you now have \(health) health"
        }
        else{
            //attack is less powerful if you miss
            //a is set to five because attack is 5 less powerful
            enemy.setHealth(hea: attackCheck(enemy: enemy, a: 5))
            return "you attack! you do \(power - 5) damge to the servent the servent now has \(enemy.getHealth()) health you miss your dodge so you do 5 less damage"
        }
        
    }
    func getLives() -> Int
    {
        return playerLives
    }
    func setLives(lives: Int)
    {
        playerLives = lives
    }
    
    //adds Exp for when level is checked
    func addExp(amt: Int)
    {
        playerExp += amt
    }
    
    func checkLevelUp() -> String
    {
        //level up once after 3 enemies fought
        // level up again after 2 more a total of 5
        // level up again after 2 more a total of 7
        if(playerExp == 20 || playerExp == 60 || playerExp == 90)
        {
            levelUp()
            level += 1
            return " and congratulations for leveling up you are now level \(level) and your base health is \(health), speed is \(speed) and power is \(power) "
        }
        
        //returns an empty string if there was no level up
        return ""
    }
    
    //levels up player stats
    func levelUp()
    {
        health += 20
        speed += 12
        power += 10
    }
    func resetExp()
    {
        playerExp = 0
    }
}
