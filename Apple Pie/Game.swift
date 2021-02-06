//
//  Game.swift
//  Apple Pie
//
//  Created by Дмитрий on 05.02.2021.
//

import AVFoundation //импорт для вставки вибрации в проект

struct Game { // модель игры
    var word: String // слово
    var incorrectMovesRemaining: Int // сколько осталось неправильных ходов
    fileprivate var guessedLetters = [Character]() // вводимая буква
    
    init(word: String, incorrectMovesRemaining: Int) { // кастомный конструктор, т.к. guessedLetters - приватное свойство
        self.word = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    var guessedWord: String { // вычисляемое свойство, подставляющее нижнее подчёркивание вместо угадываемых букв
        var wordToShow = String()
        for letter in word {
            if guessedLetters.contains(Character(letter.lowercased())) {
                wordToShow += String(letter) // если буква угадана
            } else if letter == "-" {
                wordToShow += "-" // если в слове есть дефис
            } else if letter == " " {
                wordToShow += " " // если в слове есть пробел
            } else {
                wordToShow += "_" // если буква не угадана
            }
        }
        return wordToShow
    }
    
    mutating func playerGuessed(letter: Character) { // если пользователь угадывает
        let lowercasedLetter = Character(letter.lowercased())
        guessedLetters.append(lowercasedLetter)
        if !word.lowercased().contains(lowercasedLetter) { // если такой буквы нет
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) // Вибрация, если пользователь нажимает букву, которой нет в слове
            incorrectMovesRemaining -= 1 // минус одна попытка
        }
    }
}
	
