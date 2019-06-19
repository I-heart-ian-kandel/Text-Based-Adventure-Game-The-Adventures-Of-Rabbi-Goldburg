//
//  Enemy.swift
//  The Adventures Of Rabbi Goldburg
//
//  Created by Sean Shmulevich on 6/16/19.
//  Copyright © 2019 Sean Shmulevich. All rights reserved.
//

import Foundation

class Enemy: Entity
{
    //class variables
    var type: String
    var typeArr = ["fire","water","faku"]
    let randomNum = Int.random(in: 0 ... 2)
    
    //initializer
    override init(health : Int, speed : Int, power : Int, level : Int)
    {
        type = typeArr[randomNum]
        super.init(health: health, speed: speed, power: power, level: level)
    }

    //return new type
    func getType() -> String {
        return type
    }
    
    //scramble type
    func newType()
    {
        let randomNum = Int.random(in: 0 ... 2)
        type = typeArr[randomNum]
    }
    
    //attack method for attacking a player
    func attack(player: Player) -> String
    {
        //makes sure it does not go below 0
        var attacked: Int
        if(player.getHealth()-power < 0)
        {
            attacked = 0
        }
        else
        {
            attacked = player.getHealth()-power
        }
        player.setHealth(hea: attacked)
        
        //returns what happened
        return "Enemy attacks with \(power) power you now have \(player.getHealth()) health left"
    }
}
