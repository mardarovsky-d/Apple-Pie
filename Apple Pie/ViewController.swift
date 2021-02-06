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
    var capitalList = [ // список слов
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
    let incorrectMovesAllowed = 7 // изначальное число попыток
    var totalLosses = 0 { // изначальное число проигрышей
        didSet {
            showLoseAlert() // если меняется показываем всплывающее окно
            newRound() // запускаем новый раунд
        }
    }
    var totalWins = 0 { // изначальное число побед
        didSet {
            showWinAlert() // если меняется показываем всплывающее окно
            newRound() // запускаем новый раунд
        }
    }
    
    //MARK: - Methods
    func enableButtons(_ enable: Bool = true) { // включаем или выключаем доступность кнопок с буквами
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func newRound() { // Новый раунд
        guard !capitalList.isEmpty else {
            updateUI()
            enableButtons(false)
            return
        }
        let newWord = capitalList.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    
    func showLoseAlert() { // Функция показа алерта о проигрыше
        let loseAlert = UIAlertController(title: "😒 Неверно", message: "Вы не угадали. Это \(currentGame.word)", preferredStyle: .alert)
        loseAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(loseAlert, animated: true)
    }
    
    func showWinAlert() { // Функция показа алерта о выигрыше
        let winAlert = UIAlertController(title: "😀 Правильно!", message: "Вы угадали. Это \(currentGame.word)!", preferredStyle: .alert)
        winAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(winAlert, animated: true)
    }
    
    func updateCorrectWordLabel() { // Добавляем пробелы в отображаемое слово
        var updatedWord = [String]() // создаём пустую коллекцию
        for updatedLetter in currentGame.guessedWord { // добавляем буквы из искомого слова в коллекцию
            updatedWord.append(String(updatedLetter))
        }
        correctWordLabel.text = updatedWord.joined(separator: " ") // соединяем в слово, после каждого символа - пробел
    }
    
    func updateState() { // обновляем состояние
        if currentGame.incorrectMovesRemaining < 1 { // если попыток меньше 1
            totalLosses += 1 // увеличиваем число проигрышей
        } else if currentGame.guessedWord == currentGame.word { // если угадываемое слово найдено
            totalWins += 1 // увеличиваем число побед
        } else {
            updateUI() // или продолжаем играть
        }
        updateUI()
    }
    
    func updateUI() { // обновляем интерфейс
        let movesRemaining = currentGame.incorrectMovesRemaining // осталось неверных попыток
        let imageName = "tree\(movesRemaining < 0 ? 0 : movesRemaining < 8 ? movesRemaining : 7)" // меняем дерево в зависимости от количества попыток
        treeImageView.image = UIImage(named: imageName)
        scoreLabel.text = "Выигрыши: \(totalWins). Проигрыши: \(totalLosses)" // отображаем число проигрышей и выигрышей
        updateCorrectWordLabel() // обновляем слово на экране
    }
    
    override func viewDidLoad() { // при загрузке Вью
        super.viewDidLoad()
        newRound() // запускаем раунд
    }

    //MARK: - IB Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) { // определяем, какая буква нажата
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
    
}
