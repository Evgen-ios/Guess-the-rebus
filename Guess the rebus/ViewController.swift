//
//  ViewController.swift
//  Guess the rebus
//
//  Created by Evgeniy Goncharov on 07.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var rebusImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLable: UILabel!
//    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var scoreLable: UINavigationItem!
    
    
    // MARK: - Properties
    var curretImage: String!
    var curretGame: GameModel!
    let incorrectMovesAllowed = 7
    var listOfWords = [
        "Антилопа",
        "Бабочка",
        "Бегемот",
        "Боровик",
        "Весна",
        "Ветер",
        "Горилла",
        "Грач",
        "Гриб",
        "Груздь",
        "Диван",
        "Ежик",
        "Жук",
        "Зелень",
        "Змея",
        "Зонтик",
        "Капель",
        "Каша",
        "Кисель",
        "Комод",
        "Компот",
        "Корона",
        "Котлета",
        "Кресло",
        "Кровать",
        "Кузнечик",
        "Лагдыш",
        "Лев",
        "Лисица",
        "Лисичка",
        "Лужа",
        "Май",
        "Масленок",
        "Мотылек",
        "Муха",
        "Носорог",
        "Омлет",
        "Опенок",
        "Оса",
        "Осень",
        "Пирог",
        "Пчела",
        "Ручей",
        "Сапоги",
        "Светлячок",
        "Слон",
        "Стол",
        "Стрекоза",
        "Стул",
        "Суп",
        "Сыроежка",
        "Туча",
        "Шкаф",
        "Шмель"
    ]
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    
    // MARK: - Methods
    
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func curretCorrectWordLable() {
        var displayWord = [String]()
        for letter in curretGame.guessedWord {
            displayWord.append(String(letter))
        }
        correctWordLable.text = displayWord.joined(separator: " ")
        
    }
    
    func newRound() {
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updtaUI()
            return
        }
        curretImage = listOfWords.removeFirst()
        curretGame = GameModel(word: curretImage, incorrectMovesRemaining: incorrectMovesAllowed)
        updtaUI()
        enableButtons()
    }
    
    func updateState() {
        if curretGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
        } else if curretGame.guessedWord == curretGame.word {
            totalWins += 1
        } else {
            updtaUI()
        }
        updtaUI()
    }
    
    func updtaUI() {

       // let imageNumber = UIImage(named: curretImage)
        rebusImageView.image = UIImage(named: curretImage)
        curretCorrectWordLable()
        scoreLable.title = "Выигрыши: \(totalWins) , проигрыши: \(totalLosses)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    // MARK: - IB Action
    @IBAction func letterButtonsPresed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        curretGame.playerGuessed(letter: Character(letter))
        updateState()
    }
    
}

