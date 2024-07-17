//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by Serge Eliseev on 6/24/24.
//

import SwiftUI

struct ContentView: View {
    
    // Определяем уровни сложности игры
    let level = ["Легкий", "Средний", "Тяжелый"]
    @State private var gameLevel = "Легкий"
    
    // Объявляем переменные состояния
    @State private var userInput = "" // Ввод пользователя
    @State private var oneNumber = Int.random(in: 0...10) // Первое число для умножения
    @State private var twoNumber = Int.random(in: 0...10) // Второе число для умножения
    @State private var resaultNumber = 0 // Результат умножения
    @State private var showingAlert = false // Флаг для отображения алерта
    @State private var alertMessage = "" // Сообщение алерта
    @State private var alertTitle = "Important message" // Заголовок алерта
    @State private var correctAnswer = 0 // Количество правильных ответов
    @State private var wrongAnswer = 0 // Количество неправильных ответов
    @State private var messageResault = "" // Сообщение результата
    @State private var gameStart = false // Флаг начала игры
    @State private var nextAsk = false // Флаг следующего вопроса
    @State private var numberAsk = 0 // Количество вопросов

    var body: some View {
        
        NavigationView {
            ZStack {
                // Создаем градиент фона
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.mint, Color.yellow, Color.pink]),
                    startPoint: .bottom,
                    endPoint: .topTrailing)
                
                // Основной интерфейс игры
                VStack {
                    Spacer()
                    HStack {
                        // Иконка и заголовок игры
                        Text("\u{1F9EE}")
                            .font(.largeTitle)
                            .padding(3)
                        Text("Таблица умножения")
                            .foregroundColor(.white)
                            .font(.title2)
                            .shadow(radius: 10)
                            .padding(3)
                    }
                    .background(Color.secondary.opacity(0.3))
                    .cornerRadius(10)
                    Spacer()
                    
                    // Выбор уровня сложности
                    Section {
                        Text("Выбор уровня сложности:")
                            .foregroundColor(.white)
                        Picker("Select your level", selection: $gameLevel) {
                            ForEach(level, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        
                    }
                    
                    // Кнопка начала игры
                    Button("Начать игру") {
                        gameStart = true
                    }
                    .padding(3)
                    .background(Color.white.opacity(0.3))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .font(.title2)
                    Spacer()
                    
                    // Информация по цифрам для умножения и ответ пользователя
                    HStack {
                        if gameStart {
                            let resaultNumber = oneNumber * twoNumber // Вычисляем результат умножения
                            let messageResault = resaultNumber == Int(userInput) ? "Верно" : "Ошибка" // Проверяем ответ пользователя
                            
                            if !nextAsk {
                                // Показываем задачу на умножение
                                Text("Сколько будет: \(oneNumber) * \(twoNumber) ?")
                                    .font(.title2)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(5)
                                
                                // Поле для ввода результата
                                TextField("Результат", text: $userInput)
                                    .font(.callout)
                                    .keyboardType(.numberPad)
                                    .padding(5)
                                    .background(Color.white.opacity(0.6))
                                    .cornerRadius(5)
                                    .frame(width: 100, height: 60)
                                    .padding(1)
                            }
                            
                            // Кнопка для проверки ответа
                            Button("OK") {
                                alertTitle = "Результат ответа:"
                                alertMessage = messageResault == "Верно" ? "Правильно!" : "Ошибка, попробуйте еще раз. \(resaultNumber)"
                                showingAlert = true
                                
                                if resaultNumber == Int(userInput) {
                                    correctAnswer += 1 // Увеличиваем счетчик правильных ответов
                                    numberAsk += 1 // Увеличиваем количество вопросов
                                } else {
                                    wrongAnswer += 1 // Увеличиваем счетчик неправильных ответов
                                    numberAsk += 1 // Увеличиваем количество вопросов
                                }
                                
                            }
                            .alert(alertTitle, isPresented: $showingAlert) {
                                Button("OK", role: .cancel) {
                                    oneNumber = Int.random(in: 0...10) // Генерируем новое число
                                    twoNumber = Int.random(in: 0...10) // Генерируем новое число
                                    
                                    // Проверяем количество вопросов в зависимости от уровня сложности
                                    let check = checkLevelQuestion(Level: gameLevel, numberQuestion: numberAsk)
                                    
                                    if check == true {
                                        gameStart = false // Завершаем игру
                                        numberAsk = 0 // Сбрасываем количество вопросов
                                        correctAnswer = 0 // Сбрасываем счетчик правильных ответов
                                        wrongAnswer = 0 // Сбрасываем счетчик неправильных ответов
                                    }
                                }
                            } message: {
                                if checkLevelQuestion(Level: gameLevel, numberQuestion: numberAsk) == false {
                                    Text(alertMessage)
                                } else {
                                    Text("Вы ответили на \(numberAsk - 1). Начните игру заново.")
                                }
                            }
                            .padding(3)
                            .background(Color.white.opacity(0.3))
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                            .font(.title3)
                            
                        } else {
                            // Текстовое поле при отсутствии активной игры
                            Text("Нажмите кнопку для начала игры")
                        }

                    }
                    .padding(3)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(10)
                    Spacer()
                    
                    // Блок результатов игры
                    VStack {
                        Text("Результаты игры:")
                            .padding(3)
                            .foregroundColor(.yellow)
                            .font(.title2)
                            .shadow(radius: 10)
                            .background(Color.black.opacity(0.2))
                            .cornerRadius(10)
                        
                        HStack {
                            Text("Номер задачи:  \(numberAsk)")
                                .styleText()
                        }
                        
                        HStack {
                            Text("Уровень сложности:  \(gameLevel)")
                                .styleText()
                        }
                        HStack {
                            Text("Правельных ответов: \(correctAnswer)")
                                .styleText()
                        }
                        HStack {
                            Text("Ошибки: \(wrongAnswer)")
                                .styleText()
                        }
                        
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                    // Кнопка завершения игры
                    Button("Конец игры") {
                        gameStart = false
                        numberAsk = 0
                        correctAnswer = 0
                        wrongAnswer = 0
                    }
                    .padding(3)
                    .background(Color.white.opacity(0.3))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .font(.title2)
                    Spacer()
                    
                }
            }
            .ignoresSafeArea()
        }
        
    }
    
}

// Превью экрана
#Preview {
    ContentView()
}

// Функция проверки уровня сложности и количества вопросов
func checkLevelQuestion(Level: String, numberQuestion: Int) -> Bool {
    switch (Level, numberQuestion) {
    case ("Легкий", 6):
        return true
    case ("Средний", 11):
        return true
    case ("Тяжелый", 21):
        return true
    default:
        print("Eror")
        return false
    }
}

// Структура стиля для текста в блоке "Результаты игры:"
struct StyleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white.opacity(0.2)) // цвет фона
            .cornerRadius(10) // радиус округления
            .padding(5) // отступ
            .frame(maxWidth: .infinity, alignment: .leading) // выравнивание на всю ширину и по левому краю
            .font(.title3)
    }
}

// Расширение для использования стиля текста
extension View {
    func styleText() -> some View {
        self.modifier(StyleText())
    }
}
