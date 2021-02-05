//
//  Game.swift
//  Apple Pie
//
//  Created by Дмитрий on 05.02.2021.
//

import AVFoundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    fileprivate var guessedLetters = [Character]()
    
    init(word: String, incorrectMovesRemaining: Int) {
        self.word = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    var guessedWord: String {
        var wordToShow = String()
        for letter in word {
            if guessedLetters.contains(Character(letter.lowercased())) {
                wordToShow += String(letter)
            } else if letter == "-" {
                wordToShow += "-"
            } else if letter == " " {
                wordToShow += " "
            } else {
                wordToShow += "_"
            }
        }
        return wordToShow
    }
    
    mutating func playerGuessed(letter: Character) {
        let lowercasedLetter = Character(letter.lowercased())
        guessedLetters.append(lowercasedLetter)
        if !word.lowercased().contains(lowercasedLetter) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            incorrectMovesRemaining -= 1
        }
    }
}
	
