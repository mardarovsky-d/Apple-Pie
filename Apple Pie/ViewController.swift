//
//  ViewController.swift
//  Apple Pie
//
//  Created by Дмитрий on 31.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IB Outlets for UI components
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //MARK: - Properties
    var currentGame: Game!
    var capitalList = [
        "Абу-Даби",
        "Абуджа",
        "Аддис-Абеба",
        "Аккра",
        "Алжир",
        "Амман",
        "Амстердам",
        "Андорра-ла-Велья",
        "Анкара",
        "Антананариву",
        "Апиа",
        "Асмэра",
        "Астана",
        "Асунсьон",
        "Афины",
        "Ашхабад",
        "Багдад",
        "Баку",
        "Бамако",
        "Банги",
        "Бангкок",
        "Бандар-Сери-Багаван",
        "Банжул",
        "Бастер",
        "Бейрут",
        "Белград",
        "Бельмопан",
        "Берлин",
        "Берн",
        "Бисау",
        "Бишкек",
        "Браззавиль",
        "Бразилиа",
        "Братислава",
        "Бриджтаун",
        "Брюссель",
        "Будапешт",
        "Бужумбура",
        "Бухарест",
        "Буэнос-Айрес",
        "Вадуц",
        "Валлетта",
        "Варшава",
        "Ватикан",
        "Вашингтон",
        "Веллингтон",
        "Вена",
        "Виктория",
        "Вильнюс",
        "Виндхук",
        "Вьентьян",
        "Габороне",
        "Гавана",
        "Гватемала",
        "Дакар",
        "Дакка",
        "Дамаск",
        "Джакарта",
        "Джибути",
        "Джорджтаун",
        "Дили",
        "Додома",
        "Доха",
        "Дублин",
        "Душанбе",
        "Ереван",
        "Загреб",
        "Иерусалим",
        "Исламабад",
        "Кабул",
        "Каир",
        "Кампала",
        "Канберра",
        "Каракас",
        "Кастри",
        "Катманду",
        "Кигали",
        "Киев",
        "Кингстаун",
        "Кингстон",
        "Киншаса",
        "Кито",
        "Кишинев",
        "Коломбо",
        "Конакри",
        "Копенгаген",
        "Куала-Лумпур",
        "Либревиль",
        "Лилонгве",
        "Лима",
        "Лиссабон",
        "Ломе",
        "Лондон",
        "Луанда",
        "Лусака",
        "Любляна",
        "Люксембург",
        "Маджуро",
        "Мадрид",
        "Малабо",
        "Мале",
        "Манагуа",
        "Манама",
        "Манила",
        "Мапуту",
        "Масеру",
        "Маскат",
        "Мбабане",
        "Мелекеок",
        "Мехико",
        "Минск",
        "Могадишо",
        "Монако",
        "Монровия",
        "Монтевидео",
        "Морони",
        "Москва",
        "Найпьидо",
        "Найроби",
        "Нассау",
        "Нджамена",
        "Ниамей",
        "Никосия",
        "Нуакшот",
        "Нукуалофа",
        "Нью-Дели",
        "Осло",
        "Оттава",
        "Паликир",
        "Панама",
        "Парамарибо",
        "Париж",
        "Пекин",
        "Пномпень",
        "Подгорица",
        "Порт-Вила",
        "Порт-Луи",
        "Порт-Морсби",
        "Порто-Ново",
        "Порт-о-Пренс",
        "Порт-оф-Спейн",
        "Прага",
        "Прая",
        "Претория",
        "Пхеньян",
        "Рабат",
        "Рейкьявик",
        "Рига",
        "Рим",
        "Розо",
        "Сана",
        "Сан-Марино",
        "Сан-Сальвадор",
        "Санта-Фе-де-Богота",
        "Санто-Доминго",
        "Сан-Томе",
        "Сантьяго",
        "Сан-Хосе",
        "Сараево",
        "Сент-Джонс",
        "Сент-Джорджес",
        "Сеул",
        "Сингапур",
        "Скопье",
        "София",
        "Стокгольм",
        "Сува",
        "Сукре",
        "Таллин",
        "Ташкент",
        "Тбилиси",
        "Тегеран",
        "Тегусигальпа",
        "Тирана",
        "Токио",
        "Триполи",
        "Тунис",
        "Тхимпху",
        "Уагадугу",
        "Улан-Батор",
        "Фритаун",
        "Фунафути",
        "Ханой",
        "Хараре",
        "Хартум",
        "Хельсинки",
        "Хониара",
        "Эль-Кувейт",
        "Эр-Рияд",
        "Южная Тарава",
        "Ямусукро",
        "Яунде",
    ].shuffled()
    let incorrectMovesAllowed = 7
    var totalLosses = 0 {
        didSet {
            showLoseAlert()
            newRound()
        }
    }
    var totalWins = 0 {
        didSet {
            showWinAlert()
            newRound()
        }
    }
    
    //MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func newRound() {
        guard !capitalList.isEmpty else {
            //showNoWordsRemainAlert()
            updateUI()
            enableButtons(false)
            return
        }
        let newWord = capitalList.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    
    func showLoseAlert() {
        let loseAlert = UIAlertController(title: "Неверно", message: "Вы не угадали. Это \(currentGame.word)", preferredStyle: .alert)
        loseAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(loseAlert, animated: true)
    }
    
    func showWinAlert() {
        let winAlert = UIAlertController(title: "Правильно!", message: "Вы угадали. Это \(currentGame.word)!", preferredStyle: .alert)
        winAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(winAlert, animated: true)
    }
    
    func updateCorrectWordLabel() {
        var updatedWord = [String]()
        for updatedLetter in currentGame.guessedWord {
            updatedWord.append(String(updatedLetter))
        }
        correctWordLabel.text = updatedWord.joined(separator: " ")
    }
    
    func updateState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
        } else if currentGame.guessedWord == currentGame.word {
            totalWins += 1
        } else {
            updateUI()
        }
        
        updateUI()
    }
    
    func updateUI() {
        let movesRemaining = currentGame.incorrectMovesRemaining
        let imageName = "tree\(movesRemaining < 0 ? 0 : movesRemaining < 8 ? movesRemaining : 7)"
        treeImageView.image = UIImage(named: imageName)
        scoreLabel.text = "Выигрыши: \(totalWins). Проигрыши: \(totalLosses)"
        updateCorrectWordLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    //MARK: - IB Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
    
}
