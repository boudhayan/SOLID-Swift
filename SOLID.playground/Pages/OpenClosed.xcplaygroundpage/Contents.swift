//: [Previous](@previous)

import Foundation
// class should be open for extension but closed for modification

class Question {
    
    private static var idCounter = 1
    
    var questionID: Int
    let prompt: String
    var answer: Any?
    
    init(prompt: String) {
        self.questionID = Self.idCounter
        self.prompt = prompt
        Self.idCounter += 1
    }
    
    var field: String {
        fatalError("subclass must override")
    }
    
    func display() {
        print("\(prompt)\n\t\(field)")
    }
    
    func answer(value: Any) {
        print("\t\t--> \(value)")
        answer = value
        if validateAnswer() {
            print("\t\t\t✅")
        } else {
            print("\t\t\t❌")
        }
    }
    
    func validateAnswer() -> Bool {
       fatalError()
    }
}

class TextQuestion: Question {
    override var field: String {
        return "[textfield]"
    }
    
    override func validateAnswer() -> Bool {
        return ((answer as? String) ?? "").count > 0
    }
}

class NumericQuestion: Question {
    override var field: String {
        return "[picker]"
    }
    
    override func validateAnswer() -> Bool {
        return (Int(((answer as? String) ?? "")) ?? 0) > 0
    }
}

class BooleanQuestion: Question {
    override var field: String {
        return "[switch]"
    }
    override func validateAnswer() -> Bool {
        guard let ans = answer as? Bool else { return false }
        return ans
    }
}

let quiz = [
    TextQuestion(prompt: "What is your country name?"),
    NumericQuestion(prompt: "How long is the CA beach?")
]

func anserQuestion(_ question: Question) {
    switch question.questionID {
    case 1:
        question.answer(value: "India")
    case 2:
        question.answer(value: "100")
    default:
        fatalError()
    }
}

func display(quiz: [Question]) {
    for question in quiz {
        question.display()
        
        anserQuestion(question)
    }
}

display(quiz: quiz)

//: [Next](@next)
