//
//  QuizCategoryListModel.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/28.
//

import SwiftUI
import Combine

/// クイズの要素を管理するクラス
/// この中でQuiz型でクイズ情報を入れている
//@MainActor
final class QuizCategoryListModel: ObservableObject {
    @Published var categories: [QuizCategory] = []
    @Published var quizzes: [Quiz] = []
    
    func fetch() {
        // リアルム側にデータが1件でもあれば、取得する
        if categories.isEmpty {
            RealmQuizRepository().loadLocalQuizIfNeed()
            // リアルムからローカル用のデータを取得する
            self.categories = RealmQuizRepository().fetchLocalQuiz()
            print("リアルムからローカル用のデータを取得する")
        }
        // 検証用のクイズカテゴリを取得する
        // リアルムのフェッチ失敗したとき用
//        self.categories = fetchMockNews()
    }
    
    ///  Realmデータベースの中からidが一致するQuiz型の配列をプロパティに格納する
    /// - Parameter id: クイズカテゴリのID
    func fetchMyQuizByCategoryId(by id:Int) {
        // Previews閲覧しやすいようにQuiz型にする
        quizzes = RealmQuizRepository().getQuizByCategoryId(by: id)
        print(quizzes)
    }
    
    /// アプリ内で用意しているカテゴリクイズにアクセスし、idが一致するQuiz型の配列をコールバックする
    /// - Parameters:
    ///   - id: クイズのid
    ///   - completion: 完了したら、idが一致するQuiz型の配列をコールバックする
    func fetchMockQuizById(by id:Int) async {
        
        if categories.isEmpty {
            await fetch()
//            print("フェッチ完了")
        }
//        print("id検索を始める")
        
        if let sampleQuizzes = categories.first(where: { $0.id == id }){
            self.quizzes = sampleQuizzes.quizItems
        } else {
//            print("一致したものは見つからない")
        }
    }
    
    func getCategoryById(by Id: Int) -> QuizCategory {
        if let quizCategory = categories.first(where: { $0.id == Id }) {
            return quizCategory
        } else {
            return QuizCategory()
        }
    }
    
    func getCategoryById(by Id: Int) -> QuizCategory? {
        if let quizCategory = categories.first(where: { $0.id == Id }) {
            return quizCategory
        } else {
            return nil
        }
    }
    
    func fetchTestMockNews() -> [QuizCategory] {
        // デフォルトデータを返すフェッチ処理
        let quizCategories: [QuizCategory] = [
            QuizCategory(id: 1, title: "漢字1", starCount: 3, quizItems: animalQuiz, completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 2, title: "ことわざ", starCount: 5, quizItems: kotowazaQuiz, completed: false, correctCount: 0, createdAt: "2025-01-28")
            ]
        return quizCategories
    }
    
    /// クイズの内容を返す
    /// - Returns: QuizCategory型の配列で返す
    func fetchMockNews() -> [QuizCategory] {
        // デフォルトデータを返すフェッチ処理
        let quizCategories: [QuizCategory] = [
            QuizCategory(id: 1, title: "漢字1", starCount: 3, quizItems: wordQuiz, completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 2, title: "ことわざ", starCount: 5, quizItems: kotowazaQuiz, completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 3, title: "動物", starCount: 0, quizItems: animalQuiz, completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 4, title: "生活", starCount: 4, quizItems: lifeQuiz, completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 5, title: "有名人", starCount: 2, quizItems: famousPersonQuiz, completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 6, title: "漢字2", starCount: 3, quizItems: wordQuiz2, completed: false, correctCount: 0, createdAt: "2025-02-15"),
            QuizCategory(id: 7, title: "漢字3", starCount: 3, quizItems: wordQuiz3, completed: false, correctCount: 0, createdAt: "2025-02-15"),
            QuizCategory(id: 8, title: "漢字4", starCount: 3, quizItems: wordQuiz4, completed: false, correctCount: 0, createdAt: "2025-02-15"),
            QuizCategory(id: 9, title: "漢字の読み1", starCount: 5, quizItems: yomiQuiz1, completed: false, correctCount: 0, createdAt: "2025-02-17"),
            QuizCategory(id: 10, title: "漢字の読み2", starCount: 5, quizItems: yomiQuiz2, completed: false, correctCount: 0, createdAt: "2025-02-17"),
            QuizCategory(id: 11, title: "ことわざ2", starCount: 4, quizItems: kotowaQuiz2, completed: false, correctCount: 0, createdAt: "2025-02-18"),
            QuizCategory(id: 12, title: "漢字の読み3", starCount: 4, quizItems: yomiQuiz3, completed: false, correctCount: 0, createdAt: "2025-02-19"),
            QuizCategory(id: 13, title: "漢字の読み4", starCount: 4, quizItems: yomiQuiz4, completed: false, correctCount: 0, createdAt: "2025-02-19"),
            QuizCategory(id: 14, title: "漢字の読み5", starCount: 4, quizItems: yomiQuiz5, completed: false, correctCount: 0, createdAt: "2025-02-19"),
        ]
        
        // 新しいクイズを前に並べたいので、日付順にする。日付はString型
        var sortedCreatedAt: [QuizCategory] = quizCategories.sorted{ $0.createdAt < $1.createdAt }
        
        return sortedCreatedAt
    }
    
    let yomiQuiz3: [Quiz] = [
        Quiz(id: 1, title: "読み方を当てよう", detail: "『草原』", answerNumber: 0, quizOptions: ["そうげん", "くさばら", "そうはら", "くさはら"], quizType: .readQuiz),
        Quiz(id: 2, title: "読み方を当てよう", detail: "『午前』", answerNumber: 0, quizOptions: ["ごぜん", "うままえ", "ごご", "まえひる"], quizType: .readQuiz),
        Quiz(id: 3, title: "読み方を当てよう", detail: "『出発』", answerNumber: 0, quizOptions: ["しゅっぱつ", "でばつ", "しゅっぽつ", "はつで"], quizType: .readQuiz),
        Quiz(id: 4, title: "読み方を当てよう", detail: "『茶色』", answerNumber: 2, quizOptions: ["ちゃしょく", "さゆいろ", "ちゃいろ", "おういろ"], quizType: .readQuiz),
        Quiz(id: 5, title: "読み方を当てよう", detail: "『台風』", answerNumber: 1, quizOptions: ["たいふ", "たいふう", "だいかぜ", "ふうたい"], quizType: .readQuiz),
        Quiz(id: 6, title: "読み方を当てよう", detail: "『図書館』", answerNumber: 0, quizOptions: ["としょかん", "ずがくかん", "とがくかん", "しょとずかん"], quizType: .readQuiz),
        Quiz(id: 7, title: "読み方を当てよう", detail: "『遠足』", answerNumber: 2, quizOptions: ["とおあし", "えんほ", "えんそく", "あしなが"], quizType: .readQuiz),
        Quiz(id: 8, title: "読み方を当てよう", detail: "『軽食』", answerNumber: 1, quizOptions: ["けいじき", "けいしょく", "かるしょく", "しょうしょく"], quizType: .readQuiz),
        Quiz(id: 9, title: "読み方を当てよう", detail: "『体育』", answerNumber: 2, quizOptions: ["たいく", "たいい", "たいいく", "たいぎょう"], quizType: .readQuiz),
        Quiz(id: 10, title: "読み方を当てよう", detail: "『黒板』", answerNumber: 0, quizOptions: ["こくばん", "くろいた", "こくいた", "くろばん"], quizType: .readQuiz)
    ]

    let yomiQuiz4: [Quiz] = [
        Quiz(id: 11, title: "読み方を当てよう", detail: "『温度』", answerNumber: 0, quizOptions: ["おんど", "あつさ", "ぬくもり", "どあつ"], quizType: .readQuiz),
        Quiz(id: 12, title: "読み方を当てよう", detail: "『最初』", answerNumber: 1, quizOptions: ["さいしゅう", "さいしょ", "しょさい", "はじめ"], quizType: .readQuiz),
        Quiz(id: 13, title: "読み方を当てよう", detail: "『練習』", answerNumber: 0, quizOptions: ["れんしゅう", "れんしょう", "ねんしゅう", "しゅうれん"], quizType: .readQuiz),
        Quiz(id: 14, title: "読み方を当てよう", detail: "『卒業』", answerNumber: 2, quizOptions: ["そつえい", "そつこう", "そつぎょう", "ごうそつ"], quizType: .readQuiz),
        Quiz(id: 15, title: "読み方を当てよう", detail: "『植物』", answerNumber: 2, quizOptions: ["しょくもつ", "しょくぶつ", "しょっぶつ", "はなもの"], quizType: .readQuiz),
        Quiz(id: 16, title: "読み方を当てよう", detail: "『計算』", answerNumber: 0, quizOptions: ["けいさん", "けいざん", "さんけい", "かいさん"], quizType: .readQuiz),
        Quiz(id: 17, title: "読み方を当てよう", detail: "『試合』", answerNumber: 2, quizOptions: ["しあ", "しけん", "しあい", "ためあい"], quizType: .readQuiz),
        Quiz(id: 18, title: "読み方を当てよう", detail: "『自然』", answerNumber: 1, quizOptions: ["しねん", "しぜん", "じねん", "ちぜん"], quizType: .readQuiz),
        Quiz(id: 19, title: "読み方を当てよう", detail: "『習慣』", answerNumber: 2, quizOptions: ["しゅうかん", "じゅうかん", "しゅうかい", "しゅうしょく"], quizType: .readQuiz),
        Quiz(id: 20, title: "読み方を当てよう", detail: "『研究』", answerNumber: 0, quizOptions: ["けんきゅう", "けんぎゅう", "けんきょ", "きゅうけん"], quizType: .readQuiz)
    ]

    let yomiQuiz5: [Quiz] = [
        Quiz(id: 21, title: "読み方を当てよう", detail: "『歴史』", answerNumber: 1, quizOptions: ["れきじ", "れきし", "れっき", "しれき"], quizType: .readQuiz),
        Quiz(id: 22, title: "読み方を当てよう", detail: "『政治』", answerNumber: 0, quizOptions: ["せいじ", "せいち", "じせい", "しせい"], quizType: .readQuiz),
        Quiz(id: 23, title: "読み方を当てよう", detail: "『国際』", answerNumber: 0, quizOptions: ["こくさい", "こくさいき", "こくさく", "さいこく"], quizType: .readQuiz),
        Quiz(id: 24, title: "読み方を当てよう", detail: "『産業』", answerNumber: 1, quizOptions: ["さんごう", "さんぎょう", "ぎょうさん", "ぎょうば"], quizType: .readQuiz),
        Quiz(id: 25, title: "読み方を当てよう", detail: "『文学』", answerNumber: 0, quizOptions: ["ぶんがく", "ぶんしゃ", "ぶんえい", "がくぶん"], quizType: .readQuiz),
        Quiz(id: 26, title: "読み方を当てよう", detail: "『重要』", answerNumber: 2, quizOptions: ["しゅうよう", "じゅうもう", "じゅうよう", "ようじゅう"], quizType: .readQuiz),
        Quiz(id: 27, title: "読み方を当てよう", detail: "『教育』", answerNumber: 1, quizOptions: ["きょうぎ", "きょういく", "きょうし", "きょうそく"], quizType: .readQuiz),
        Quiz(id: 28, title: "読み方を当てよう", detail: "『社会』", answerNumber: 0, quizOptions: ["しゃかい", "しゅかい", "しゃえ", "かいしゃ"], quizType: .readQuiz),
        Quiz(id: 29, title: "読み方を当てよう", detail: "『経済』", answerNumber: 2, quizOptions: ["けいざ", "けいし", "けいざい", "ざいけい"], quizType: .readQuiz),
        Quiz(id: 30, title: "読み方を当てよう", detail: "『環境』", answerNumber: 0, quizOptions: ["かんきょう", "かんけい", "かんこう", "きょうかん"], quizType: .readQuiz)
    ]

    
    let kotowaQuiz2: [Quiz] = [
        Quiz(id: 1,
             title: "ことわざの意味を当てよう",
             detail: "『豚に真珠』",
             answerNumber: 0,
             quizOptions: ["物の価値がわからないものに、高価なものを与えても仕方ない","豚は真珠が好き","真珠のようなピカピカしたものを与えても動物は育たない","豚に真珠をあげようとすると、何が起きるか"],
             quizType:.imageQuiz,
             imageName:"kotowaza_buta_shinju"),
        Quiz(id: 2,
             title: "ことわざの意味を当てよう",
             detail: "一石二鳥",
             answerNumber: 3,
             quizOptions: ["一つの石でもたくさんの生き物を傷つけてしまう","散歩すると、鳥や石を見かけるものだ","ふたつの生き物が、石のような無意味なものを取り合う","一つのきっかけで２つのものが得られること"],
             quizType:.imageQuiz,
             imageName:"isseki_nichou"),
            Quiz(id: 3,
                 title: "ことわざの意味を当てよう",
                 detail: "井の中の蛙",
                 answerNumber: 1,
                 quizOptions: [
                     "小さな世界にいると、広い世界のことが分からない",
                     "カエルは水辺にいるものだ",
                     "小さな井戸の中でも、大きな声で鳴けば遠くまで届く",
                     "雨の日はカエルがよく鳴く"
                 ],
                 quizType: .imageQuiz,
                 imageName: "kotowaza_inonaka_kawazu"),

            Quiz(id: 4,
                 title: "ことわざの意味を当てよう",
                 detail: "可愛い子には旅をさせよ",
                 answerNumber: 0,
                 quizOptions: [
                     "子どもにはさまざまな経験を積ませると良い",
                     "旅行に行くとかわいくなれる",
                     "可愛い子を旅に連れて行くと運気が上がる",
                     "旅先で新しい友達を作ると良い"
                 ],
                 quizType: .imageQuiz,
                 imageName: "kotowaza_kawaiiko_tabi_girl"),

            Quiz(id: 5,
                 title: "ことわざの意味を当てよう",
                 detail: "絵に描いた餅",
                 answerNumber: 2,
                 quizOptions: [
                     "餅の絵を描くのが上手な人",
                     "餅の絵を見ながら食べると美味しくなる",
                     "実際には役に立たない計画や理想",
                     "餅は絵に描いたように綺麗に作るべき"
                 ],
                 quizType: .imageQuiz,
                 imageName: "kotowaza_enikaitamochi_man"),

            Quiz(id: 6,
                 title: "ことわざの意味を当てよう",
                 detail: "鴨が葱を背負ってくる",
                 answerNumber: 1,
                 quizOptions: [
                     "鴨が美味しい料理になるとき",
                     "都合の良いことが重なってさらに良い状況になる",
                     "カモ料理にはネギが必要不可欠",
                     "運命的な出会いを果たす"
                 ],
                 quizType: .imageQuiz,
                 imageName: "bird_kamonegi"),

            Quiz(id: 7,
                 title: "ことわざの意味を当てよう",
                 detail: "猫に小判",
                 answerNumber: 0,
                 quizOptions: [
                     "価値が分からないものに貴重なものを与えても意味がない",
                     "猫が小判を持っていると幸運が訪れる",
                     "猫に金運が宿ると良いことが起こる",
                     "小判を持っていると猫が寄ってくる"
                 ],
                 quizType: .imageQuiz,
                 imageName: "kotowaza_neko_koban"),

            Quiz(id: 8,
                 title: "ことわざの意味を当てよう",
                 detail: "月とすっぽん",
                 answerNumber: 2,
                 quizOptions: [
                     "月とスッポンはどちらも丸いので同じように見える",
                     "月のように光り輝くスッポンがいる",
                     "比べものにならないほど違いがあること",
                     "スッポンの甲羅は月の満ち欠けと関係している"
                 ],
                 quizType: .imageQuiz,
                 imageName: "kotowaza_tsuki_suppon")
    ]
    
    let yomiQuiz1 = [
        Quiz(id: 1,
             title: "読み方を当てよう",
             detail: "『草原』",
             answerNumber: 2,
             quizOptions: ["そうげん","くさばら","そうはら","くさはら"],
             quizType: .readQuiz
            ),

        Quiz(id: 2,
             title: "読み方を当てよう",
             detail: "『雲』",
             answerNumber: 0,
             quizOptions: ["くも","いわ","かぜ","そら"],quizType: .readQuiz),

        Quiz(id: 3,
             title: "読み方を当てよう",
             detail: "『計算』",
             answerNumber: 1,
             quizOptions: ["けいさつ","けいさん","けいしき","けいざい"],quizType: .readQuiz),

        Quiz(id: 4,
             title: "読み方を当てよう",
             detail: "『動物』",
             answerNumber: 3,
             quizOptions: ["どうぶつう","とうぶつ","どうもの","どうぶつ"],quizType: .readQuiz),

        Quiz(id: 5,
             title: "読み方を当てよう",
             detail: "『理由』",
             answerNumber: 2,
             quizOptions: ["りかい","りきゅう","りゆう","りょう"],quizType: .readQuiz),
        Quiz(id: 6,
             title: "読み方を当てよう",
             detail: "『出発』",
             answerNumber: 0,
             quizOptions: ["しゅっぱつ","しゅうはつ","しゅつばつ","しゅうぱつ"],quizType: .readQuiz),

        Quiz(id: 7,
             title: "読み方を当てよう",
             detail: "『集合』",
             answerNumber: 1,
             quizOptions: ["しゅうこう","しゅうごう","しゅうほう","しゅうじゅう"],quizType: .readQuiz),

        Quiz(id: 8,
             title: "読み方を当てよう",
             detail: "『開く』",
             answerNumber: 3,
             quizOptions: ["かたく","へらく","ひらく","あく"],quizType: .readQuiz),

        Quiz(id: 9,
             title: "読み方を当てよう",
             detail: "『旅行』",
             answerNumber: 2,
             quizOptions: ["りょこ","りこう","りょこう","ろこう"],quizType: .readQuiz),

        Quiz(id: 10,
             title: "読み方を当てよう",
             detail: "『大事』",
             answerNumber: 0,
             quizOptions: ["だいじ","たいじ","おおごと","おおじ"],quizType: .readQuiz),
    ]
    
    let yomiQuiz2 = [
        Quiz(id: 1,
             title: "読み方を当てよう",
             detail: "『工事』",
             answerNumber: 1,
             quizOptions: ["こうじょう","こうじ","こうし","こうごう"] ,quizType: .readQuiz),

        Quiz(id: 2,
             title: "読み方を当てよう",
             detail: "『夕日』",
             answerNumber: 2,
             quizOptions: ["ゆうにち","せきじつ","ゆうひ","あさひ"] ,quizType: .readQuiz),

        Quiz(id: 3,
             title: "読み方を当てよう",
             detail: "『遠足』",
             answerNumber: 0,
             quizOptions: ["えんそく","とおあし","えんぽ","えんきゃく"] ,quizType: .readQuiz),

        Quiz(id: 4,
             title: "読み方を当てよう",
             detail: "『寒気』",
             answerNumber: 3,
             quizOptions: ["さむき","かんけ","かんき","さむけ"] ,quizType: .readQuiz),

        Quiz(id: 5,
             title: "読み方を当てよう",
             detail: "『集合』",
             answerNumber: 1,
             quizOptions: ["しゅうこう","しゅうごう","しゅうほう","しゅうじゅう"] ,quizType: .readQuiz),

        Quiz(id: 6,
             title: "読み方を当てよう",
             detail: "『早朝』",
             answerNumber: 2,
             quizOptions: ["そうひる","はやま","そうちょう","さっちょう"] ,quizType: .readQuiz),

        Quiz(id: 7,
             title: "読み方を当てよう",
             detail: "『市場』",
             answerNumber: 0,
             quizOptions: ["いちば","しじょう","いちじょう","しば"] ,quizType: .readQuiz),

        Quiz(id: 8,
             title: "読み方を当てよう",
             detail: "『読書』",
             answerNumber: 3,
             quizOptions: ["どっしょ","とくさつ","とくじょ","どくしょ"] ,quizType: .readQuiz),

        Quiz(id: 9,
             title: "読み方を当てよう",
             detail: "『海岸』",
             answerNumber: 1,
             quizOptions: ["うみべ","かいがん","かいそく","うみがん"] ,quizType: .readQuiz),

        Quiz(id: 10,
             title: "読み方を当てよう",
             detail: "『昼食』",
                  answerNumber: 2,
                  quizOptions: ["ちゅうはん","ひるじき","ちゅうしょく","ひるしょく"] ,quizType: .readQuiz)
    ]
    
    let wordQuiz2 = [
        Quiz(id: 1,
             title: "漢字を当てよう",
             detail: "心が満たされて、しあわせな気持ちになることを「こうふく」と言うよ。当てはまる漢字はどれ？",
             answerNumber: 3,
             quizOptions: ["不幸","口福","幸楽","幸福"]),
        Quiz(id: 2,
             title: "漢字を当てよう",
             detail: "相手とどのように戦うか、先に決めておくことを「さくせん」と言うよ。当てはまる漢字はどれ？",
             answerNumber: 1,
             quizOptions: ["戦略","作戦","作品","戦争"]),
        Quiz(id: 3,
             title: "漢字を当てよう",
             detail: "どうやっても出来そうにないことを「むり」というよ。ヒントは「理（ことわり）が無い」こと",
             answerNumber: 2,
             quizOptions: ["無法","無知","無理","無視"]),
        Quiz(id: 4,
             title: "漢字を当てよう",
             detail: "山のてっぺんやものごとの一番上を「ちょうじょう」というよ。ヒントは「頂(いただき)のうえ」のこと",
             answerNumber: 3,
             quizOptions: ["頭頂","長城","超超","頂上"]),
        Quiz(id: 5,
             title: "漢字を当てよう",
             detail: "ねむることを「すいみん」というよ。どれかな？",
             answerNumber: 2,
             quizOptions: ["快眠","惰眠","睡眠","珉珉"]),
        Quiz(id: 6,
             title: "漢字を当てよう",
             detail: "何かを決めるために話し合うことを「ぎろん」と言うよ。当てはまる漢字はどれ？",
             answerNumber: 1,
             quizOptions: ["議論","疑問","理論","語論"]),

        Quiz(id: 7,
             title: "漢字を当てよう",
             detail: "とても大切で、なくてはならないことを「ひつよう」と言うよ。どれかな？",
             answerNumber: 2,
             quizOptions: ["秘密","必要","必勝","必要性"]),

        Quiz(id: 8,
             title: "漢字を当てよう",
             detail: "学校の授業が終わったあとに学ぶことを「よしゅう」と言うよ。ヒントは「前もって準備すること」",
             answerNumber: 0,
             quizOptions: ["予習","復習","習得","学習"]),

        Quiz(id: 9,
             title: "漢字を当てよう",
             detail: "大きな動物が歩くときの足あとや、その場所に残る印のことを「そくせき」と言うよ。当てはまる漢字は？",
             answerNumber: 3,
             quizOptions: ["足音","測定","速攻","足跡"]),

        Quiz(id: 10,
             title: "漢字を当てよう",
             detail: "すごくきれいで美しいことを「けいれい」と言うよ。ヒントは「景（けしき）が麗しい」",
             answerNumber: 1,
             quizOptions: ["敬礼","綺麗","軽冷","景令"])
        
    ]
    
    let wordQuiz3 = [
        Quiz(id: 1,
             title: "漢字を当てよう",
             detail: "なやんだり苦しむことを「くのう」というよ。当てはまる漢字はどれ？",
             answerNumber: 1,
             quizOptions: ["苦楽","苦悩","能力","技能"]),
        Quiz(id: 2,
             title: "漢字を当てよう",
             detail: "怒ったり悲しんだり、よろこんだり色んな気持ちを「きどあいらく」と言うよ。どれかな？",
             answerNumber: 3,
             quizOptions: ["笑喜哀楽","哀楽喜泣","楽喜笑哀","喜怒哀楽"]),
        Quiz(id: 3,
             title: "漢字を当てよう",
             detail: "相手のことをバカにしたようにあざわらうことを「れいしょう」と言うよ。どれかな？",
             answerNumber: 2,
             quizOptions: ["嘲笑","失笑","冷笑","笑点"]),
        Quiz(id: 4,
             title: "漢字を当てよう",
             detail: "外に出かけることを「しゅっぱつ」というよ。どれかな？",
             answerNumber: 0,
             quizOptions: ["出発","外出","暴発","発進"]),
        Quiz(id: 5,
             title: "漢字を当てよう",
             detail: "私達が暮らしている星を「ちきゅう」というよ。どれかな？",
             answerNumber: 1,
             quizOptions: ["太陽","地球","地星","球体"])
    ]
    
    let wordQuiz4 = [
        Quiz(id: 1,
             title: "漢字を当てよう",
             detail: "生きてきた年数のことを「ねんれい」というよ。当てはまる漢字はどれ？",
             answerNumber: 2,
             quizOptions: ["樹齢","年代","年齢","年相応"])
    ]
    
    let wordQuiz = [
        Quiz(id: 1, title: "漢字を当てよう", detail: "別の生き物のように体を変化させることを「ぎたい」と言うよ。当てはまる漢字はどれ？", answerNumber: 1, quizOptions: ["疑体","擬態","技態","模対"]),
        Quiz(id: 1, title: "漢字を当てよう", detail: "おそろしい生き物のことを「ようかい」と言うよ。当てはまる漢字はどれ？", answerNumber: 3, quizOptions: ["洋獣","用海","怪会","妖怪"]),
        Quiz(id: 3, title: "漢字を当てよう", detail: "まちがった考えを「ごかい」と言うよ。当てはまる漢字はどれ？", answerNumber: 0, quizOptions: ["誤解", "護戒", "午界", "語会"]),
           
       Quiz(id: 4, title: "漢字を当てよう", detail: "何かをしようとすることを「いと」すると言うよ。当てはまる漢字はどれ？", answerNumber: 0, quizOptions: ["意図", "異都", "衣渡", "威途"]),
       
       Quiz(id: 5, title: "漢字を当てよう", detail: "すばやく正確に動くことを「しゅんびん」と言うよ。当てはまる漢字はどれ？", answerNumber: 1, quizOptions: ["駿敏", "俊敏", "瞬便", "春民"]),
       
       Quiz(id: 6, title: "漢字を当てよう", detail: "大小・多少などの差が少なく、そろっていることを「へいきん」と言うよ。当てはまる漢字はどれ？", answerNumber: 2, quizOptions: ["兵近", "併筋", "平均", "並金"]),
       
       Quiz(id: 7, title: "漢字を当てよう", detail: "ありもしないことを信じてしまうことを「もうそう」と言うよ。当てはまる漢字はどれ？", answerNumber: 2, quizOptions: ["猛想", "網総", "妄想", "忘掃"])
    ]
    
    let kotowazaQuiz: [Quiz] =  [
        Quiz(
            id: 1,
            title: "急がば回れ",
            detail: "次の中からことわざ『急がば回れ』の意味として正しいものを選んでください。",
            answerNumber: 1,
            quizOptions: [
                "急いでいるときこそ慎重に行動すべき",
                "迷ったときは他人に任せるべき",
                "とにかくスピードを優先するべき",
                "後回しにすると良い結果が得られる"
            ]
        ),
        Quiz(
            id: 2,
            title: "二兎を追う者は一兎をも得ず",
            detail: "次の中からことわざ『二兎を追う者は一兎をも得ず』の意味として正しいものを選んでください。",
            answerNumber: 0,
            quizOptions: [
                "欲張ると何も得られない",
                "努力を惜しまないことが大事",
                "常に二つの選択肢を用意すべき",
                "チャンスを逃さないよう注意するべき"
            ]
        ),
        Quiz(
            id: 3,
            title: "猿も木から落ちる",
            detail: "次の中からことわざ『猿も木から落ちる』の意味として正しいものを選んでください。",
            answerNumber: 2,
            quizOptions: [
                "油断すると大きな怪我をする",
                "動物にも失敗はある",
                "どんな名人でも失敗することがある",
                "木登りは猿に任せるべき"
            ]
        )
    ]
    
    let animalQuiz:[Quiz] = [
        Quiz(id: 1,
             title: "ダンゴムシについて知ろう",
             detail: "ダンゴムシのオスとメスの見分け方はどれ？",
             answerNumber: 2,
             quizOptions: ["大きさで見分ける","お尻の形で見分ける","体のもようで見分ける","食べるもので見分ける"]),
        Quiz(id: 2,
             title: "犬の鼻",
             detail: "犬の鼻がいつも湿っているのはなぜ？",
             answerNumber: 1,
             quizOptions: ["風邪をひかないため","においをよくかぐため","暑さに強くなるため","敵から身を守るため"]),
        Quiz(id: 3,
             title: "ネコのゴロゴロ音",
             detail: "ネコが「ゴロゴロ」と音を出すのはどんなとき？",
             answerNumber: 3,
             quizOptions: ["おなかがすいたとき","怒っているとき","寝ているとき","リラックスしているとき"]),
        Quiz(id: 4,
             title: "カメの甲羅",
             detail: "カメの甲羅について正しいのはどれ？",
             answerNumber: 0,
             quizOptions: ["背骨の一部になっている","脱皮して生え変わる","中は空洞になっている","とても軽い素材でできている"]),
        Quiz(id: 5,
             title: "イルカの睡眠",
             detail: "イルカはどのように寝る？",
             answerNumber: 2,
             quizOptions: ["目を閉じてぐっすり寝る","水底に沈んで寝る","脳の半分ずつ休ませながら寝る","一緒にいる群れと交代で寝る"])
    ]

    let lifeQuiz:[Quiz] = [
        Quiz(id: 1,
             title: "じゅうなん剤について知ろう",
             detail: "服やタオルを洗うときに、じゅうなん剤を使うよ。どんな効果がある？",
             answerNumber: 0,
             quizOptions: ["服やタオルをやわらかくする","服やタオルの汚れを落とす","服やタオルをかたくする","服やタオルの色を白くする"]),
        Quiz(id: 2,
             title: "お米のとぎ方",
             detail: "お米をとぐとき、最初の水はどうした方がいい？",
             answerNumber: 0,
             quizOptions: ["すぐに捨てる","できるだけ長く浸す","ぬるま湯で洗う","強くこすり洗いする"]),
        Quiz(id: 3,
             title: "歯磨きのタイミング",
             detail: "朝、歯を磨くのはいつが一番いい？",
             answerNumber: 2,
             quizOptions: ["朝ごはんの前","朝ごはんの後","朝ごはんの前と後の両方","昼ごはんの後"]),
        Quiz(id: 4,
             title: "電気代を節約する方法",
             detail: "電気代を節約するために効果的なのは？",
             answerNumber: 1,
             quizOptions: ["エアコンを一度つけたらこまめに消す","エアコンの温度を適切に設定する","使っていない部屋でも電気をつける","冷蔵庫の扉を開けっぱなしにする"]),
        Quiz(id: 5,
             title: "食べ物の保存方法",
             detail: "卵を冷蔵庫で保存するときの正しい向きは？",
             answerNumber: 3,
             quizOptions: ["どっちでもいい","横向きにする","黄身が上になるようにする","とがっている方を下にする"])
    ]
    
    let famousPersonQuiz:[Quiz] = [
        Quiz(id: 1,
             title: "ヒカキンのこと",
             detail: "ヒカキンの年収はいくらくらいと言われている？",
             answerNumber: 2,
             quizOptions: ["100万円","1億円","10億円","1兆円"]),
        Quiz(id: 2,
             title: "イーロン・マスクのこと",
             detail: "イーロン・マスクがCEOを務めたことがある企業は？",
             answerNumber: 1,
             quizOptions: ["Tesla","Microsoft","Apple","Amazon"]),
        Quiz(id: 3,
             title: "ビル・ゲイツのこと",
             detail: "ビル・ゲイツが共同創業した企業は？",
             answerNumber: 0,
             quizOptions: ["Microsoft","Google","Facebook","Tesla"]),
        Quiz(id: 4,
             title: "大谷翔平のこと",
             detail: "大谷翔平がMLBで最初に所属したチームは？",
             answerNumber: 0,
             quizOptions: ["ロサンゼルス・エンゼルス","ニューヨーク・ヤンキース","シカゴ・カブス","ボストン・レッドソックス"]),
        Quiz(id: 5,
             title: "村上春樹のこと",
             detail: "村上春樹の代表作の一つで、1987年に発表された小説は？",
             answerNumber: 1,
             quizOptions: ["風の歌を聴け","ノルウェイの森","1Q84","世界の終りとハードボイルド・ワンダーランド"])
    ]

    
//雛形
//    let animalQuiz:[Quiz] = [
//        Quiz(id: 1,
//             title: "ダンゴムシについて知ろう",
//             detail: "ダンゴムシのオスとメスの見分け方はどれ？",
//             answerNumber: 2,
//             quizOptions: ["大きさで見分ける","お尻の形で見分ける","体のもようで見分ける","食べるもので見分ける"])
//    ]
}
