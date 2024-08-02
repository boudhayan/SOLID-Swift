//: [Previous](@previous)

import Foundation
// A class should have only one responsibility or a class should have only one reason to change
struct User: CustomStringConvertible {
    let username: String
    let displayName: String
    
    var description: String {
        "\(user.displayName) • \(user.username)"
    }
}

struct Tweet {
    let user: User
    let createdAt: Date
    let retweetCount: Int
    let favoriteCount: Int
    let body: String
}

struct UserViewModel: CustomStringConvertible {
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var description: String {
        return "\(user.displayName) • \(user.username)"
    }
}

struct TweetViewModel: CustomStringConvertible {
    private let tweet: Tweet
    private let userViewModel: UserViewModel
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.userViewModel = UserViewModel(user: tweet.user)
    }
    
    var description: String {
        return """
        \(user)
        \(body)
        \(tweetMetrices)
        """
    }
    
    var body: String {
        return tweet.body
    }
    
    var tweetMetrices: String {
        return "\(retweets) • \(favorites)"
    }
    
    var retweets: String {
        return "\(pluralize("RT", tweet.retweetCount))"
    }
    
    var favorites: String {
        return "\(pluralize("fav", tweet.favoriteCount))"
    }
    
    private func pluralize(_ term: String, _ count: Int) -> String {
        return "\(count) \(term)\(count == 1 ? "" : "s")"
    }
}

let user = User(username: "boudhayan", displayName: "inner light")
let tweet = Tweet(user: user, createdAt: Date(), retweetCount: 10, favoriteCount: 4, body: "good morning!!")
let tweetViewModel = TweetViewModel(tweet: tweet)

func display(tweet: TweetViewModel) {
    print(tweet)
}

display(tweet: tweetViewModel)

//: [Next](@next)
