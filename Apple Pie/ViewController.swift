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
        "Канберра",
        "Вена",
        "Баку",
        "Тирана",
        "Алжир",
        "Луанда",
        "Андорра-ла-Велья",
        "Сент-Джонс",
        "Буэнос-Айрес",
        "Ереван",
        "Кабул",
        "Нассау",
        "Дакка",
        "Бриджтаун",
        "Манама",
        "Минск",
        "Бельмопан",
        "Брюссель",
        "Порто-Ново",
        "София",
        "Сукре",
        "Сараево",
        "Габороне",
        "Бразилиа",
        "Бандар-Сери-Багаван",
        "Уагадугу",
        "Бужумбура",
        "Тхимпху",
        "Порт-Вила",
        "Ватикан",
        "Лондон",
        "Будапешт",
        "Каракас",
        "Дили",
        "Ханой",
        "Либревиль",
        "Порт-о-Пренс",
        "Джорджтаун",
        "Банжул",
        "Аккра",
        "Гватемала",
        "Конакри",
        "Бисау",
        "Берлин",
        "Тегусигальпа",
        "Сент-Джорджес",
        "Афины",
        "Тбилиси",
        "Копенгаген",
        "Джибути",
        "Розо",
        "Санто-Доминго",
        "Каир",
        "Лусака",
        "Хараре",
        "Иерусалим",
        "Нью-Дели",
        "Джакарта",
        "Амман",
        "Багдад",
        "Тегеран",
        "Дублин",
        "Рейкьявик",
        "Мадрид",
        "Рим",
        "Сана",
        "Прая",
        "Астана",
        "Пномпень",
        "Яунде",
        "Оттава",
        "Доха",
        "Найроби",
        "Никосия",
        "Бишкек",
        "Южная Тарава",
        "Пекин",
        "Санта-Фе-де-Богота",
        "Морони",
        "Киншаса",
        "Браззавиль",
        "Сан-Хосе",
        "Ямусукро",
        "Гавана",
        "Эль-Кувейт",
        "Вьентьян",
        "Рига",
        "Масеру",
        "Монровия",
        "Бейрут",
        "Триполи",
        "Вильнюс",
        "Вадуц",
        "Люксембург",
        "Порт-Луи",
        "Нуакшот",
        "Антананариву",
        "Скопье",
        "Лилонгве",
        "Куала-Лумпур",
        "Бамако",
        "Мале",
        "Валлетта",
        "Рабат",
        "Маджуро",
        "Мехико",
        "Мапуту",
        "Кишинев",
        "Монако",
        "Улан-Батор",
        "Найпьидо",
        "Виндхук",
        "Катманду",
        "Ниамей",
        "Абуджа",
        "Амстердам",
        "Манагуа",
        "Веллингтон",
        "Осло",
        "Абу-Даби",
        "Маскат",
        "Исламабад",
        "Мелекеок",
        "Панама",
        "Порт-Морсби",
        "Асунсьон",
        "Лима",
        "Варшава",
        "Лиссабон",
        "Москва",
        "Кигали",
        "Бухарест",
        "Сан-Сальвадор",
        "Апиа",
        "Сан-Марино",
        "Сан-Томе",
        "Эр-Рияд",
        "Мбабане",
        "Пхеньян",
        "Виктория",
        "Дакар",
        "Кингстаун",
        "Бастер",
        "Кастри",
        "Белград",
        "Сингапур",
        "Дамаск",
        "Братислава",
        "Любляна",
        "Вашингтон",
        "Хониара",
        "Могадишо",
        "Хартум",
        "Парамарибо",
        "Фритаун",
        "Душанбе",
        "Бангкок",
        "Додома",
        "Ломе",
        "Нукуалофа",
        "Порт-оф-Спейн",
        "Фунафути",
        "Тунис",
        "Ашхабад",
        "Анкара",
        "Кампала",
        "Ташкент",
        "Киев",
        "Монтевидео",
        "Паликир",
        "Сува",
        "Манила",
        "Хельсинки",
        "Париж",
        "Загреб",
        "Банги",
        "Нджамена",
        "Подгорица",
        "Прага",
        "Сантьяго",
        "Берн",
        "Стокгольм",
        "Коломбо",
        "Кито",
        "Малабо",
        "Асмэра",
        "Таллин",
        "Аддис-Абеба",
        "Сеул",
        "Претория",
        "Кингстон",
        "Токио"
    ]
    let incorrectMovesAllowed = 7
    var totalLosses = 0
    var totalWins = 0
    
    //MARK: - Methods
    func newRound() {
        let newWord = capitalList.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
    }
    
    func updateUI() {
        let movesRemaining = currentGame.incorrectMovesRemaining
        let imageName = "tree\(movesRemaining < 0 ? 0 : movesRemaining < 8 ? movesRemaining : 7)"
        treeImageView.image = UIImage(named: imageName)
        scoreLabel.text = "Выигрыши: \(totalWins). Проигрыши: \(totalLosses)"
        correctWordLabel.text = currentGame.guessedWord
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
        updateUI()
    }
    
}

