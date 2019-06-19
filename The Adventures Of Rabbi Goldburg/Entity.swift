//
//  Player.swift
//  The Adventures Of Rabbi Goldburg
//
//  Created by Sean Shmulevich on 6/13/19.
//  Copyright © 2019 Sean Shmulevich. All rights reserved.
//

import Foundation
var intro = """
The instructions for this game are as follows the objective of the game is to level up by defeating servents of the
all powerful zanis you attack the srevents in a sudo random turn based format
moves include dodge, attack , and attack with a chance to dodge
once healh is below zero the player will respawn with one less life each player
only two lives per game. you will level up from defeting servents
"""
var pickCharacter = """
its time to pick a player you have three choices; however, all of the choises will be Rabbi Goldburg just him from a different dimensionspress
"""

var fastRabbi = """
Rabbi Goldberg number one grew up in the country, and practices reform Judaism he
was a track star at his Jewish private school he is fast but weaker than the other players this translates to more effective dogging but less effective attacks also he is more effective against fire and less effective against water
"""
var strongRabbi = """
Rabbi Goldberg number two grew up in the suburbs, and practices conservative Judaism when he isn't practicing Judaism, or praying he's playing lacrosse with the other Rabbi's he was on the varsity lacrosse team at Pennsbury High School he is strong but slower then the other players this translates to less effective dogging but more effective attacks also he is more effective against Faku and less effective against fire type servants
"""
var smartRabbi = """
Rabbi Goldburg number three grew up in the city, and practices orthodox Judaism his intelligence, and wisdom is unfathomable,he has dedicated his entire life to worshipping G-d he is not as strong or fast as the others but his wit overcomes all. Rabbi Goldburg number three was the all-state chess champion at his Catholic school where he overcame all obstacles of being the only Jew at his school his wit translates to medium effective dogging and medium effective attacks but, more health also he is more effective against water and less effective against Faku type servants
"""




class Entity {
    
    //Default variables for all entitys in the game
    var health : Int
    var speed : Int
    var power : Int
    var level : Int
    
    
    
    //default init
    init(health : Int, speed : Int, power : Int, level : Int)
    {
        self.health = health
        self.speed = speed
        self.power = power
        self.level = level
    }
    
    //getter and setter methods
    //very useful
    func getHealth() -> Int
    {
        return health
    }
    func getSpeed() -> Int
    {
        return speed
    }
    func getPower() -> Int
    {
        return power
    }
    func getLevel() -> Int
    {
        return level
    }
    
    func setHealth(hea: Int)
    {
        health = hea
    }
    func setSpeed(spd: Int)
    {
        speed = spd
    }
    func setPower(pow: Int)
    {
        power = pow
    }
    func setLevel(lev: Int)
    {
        level = lev
    }
    
}
