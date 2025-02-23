//
//  LocalQuizData.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/23.
//

import Foundation

struct LocalQuizData {
    /// ローカルDBに追加するデータを取得する
    /// - Returns:QuizCategory型の配列を返す
    func getLocalQuiz() -> [QuizCategory] {
        // デフォルトデータを返すフェッチ処理
        
        
        return LocalQuizData.quizCategories2
    }
    static let quizCategories2: [QuizCategory] = [
        QuizCategory(id: 15, title: "いろいろ", starCount: 3, quizItems: category15, completed: false, correctCount: 0, createdAt: "2025-02-23"),
        QuizCategory(id: 16, title: "漢字の意味と読み", starCount: 5, quizItems: category16, completed: false, correctCount: 0, createdAt: "2025-02-23"),
        QuizCategory(id: 17, title: "知識", starCount: 3, quizItems: category17, completed: false, correctCount: 0, createdAt: "2025-02-23"),
        QuizCategory(id: 18, title: "曲当て", starCount: 5, quizItems: category18, completed: false, correctCount: 0, createdAt: "2025-02-23")
    ]
    static let category17: [Quiz] = [
        Quiz(id: 121, title: "日本で一番高い山は？", detail: "標高3776m", answerNumber: 0, quizOptions: ["富士山", "北岳", "槍ヶ岳", "谷川岳"], quizType: .defaultQuiz),
        Quiz(id: 122, title: "シロクマの肌の色は？", detail: "見た目は白いけど…", answerNumber: 2, quizOptions: ["白", "グレー", "黒", "茶色"], quizType: .defaultQuiz),
        Quiz(id: 123, title: "世界で一番使われている言語は？", detail: "話者数が最も多い", answerNumber: 1, quizOptions: ["英語", "中国語", "スペイン語", "フランス語"], quizType: .defaultQuiz),
        Quiz(id: 124, title: "地球の表面の約70%を占めるのは？", detail: "私たちに欠かせないもの", answerNumber: 0, quizOptions: ["水", "大地", "空気", "砂漠"], quizType: .defaultQuiz),
        Quiz(id: 125, title: "ハチが蜜を集める理由は？", detail: "主な目的は…", answerNumber: 2, quizOptions: ["花を育てるため", "自分たちが食べるため", "幼虫を育てるため", "人間に売るため"], quizType: .defaultQuiz),
        Quiz(id: 126, title: "日本の国鳥は？", detail: "美しい鳴き声", answerNumber: 1, quizOptions: ["ワシ", "キジ", "ツル", "スズメ"], quizType: .defaultQuiz),
        Quiz(id: 127, title: "「カカオ」から作られるものは？", detail: "甘くて美味しい", answerNumber: 0, quizOptions: ["チョコレート", "キャラメル", "マシュマロ", "ガム"], quizType: .defaultQuiz),
        Quiz(id: 128, title: "パンダの主な食べ物は？", detail: "笹じゃないとダメ？", answerNumber: 0, quizOptions: ["竹", "果物", "草", "魚"], quizType: .defaultQuiz),
        Quiz(id: 129, title: "日本の一番北にある都道府県は？", detail: "寒い地域", answerNumber: 1, quizOptions: ["青森県", "北海道", "岩手県", "秋田県"], quizType: .defaultQuiz),
        Quiz(id: 130, title: "お寿司の「マグロ」の赤い部分の正体は？", detail: "なぜ赤い？", answerNumber: 3, quizOptions: ["血液", "鉄分", "色素", "ミオグロビン"], quizType: .defaultQuiz)
    ]

    static let category18: [Quiz] = [
        Quiz(id: 131, title: "この曲のタイトルは？", detail: "『生まれ変わってもまた 私に生まれたい』", answerNumber: 2, quizOptions: ["アイドル", "怪物", "私は最強", "青と夏"], quizType: .defaultQuiz),
        Quiz(id: 132, title: "この曲のタイトルは？", detail: "『強くなれる理由を知った 僕を連れて進め』", answerNumber: 1, quizOptions: ["紅蓮華", "炎", "残響散歌", "廻廻奇譚"], quizType: .defaultQuiz),
        Quiz(id: 133, title: "この曲のタイトルは？", detail: "『君の虜になってしまえばきっと』", answerNumber: 0, quizOptions: ["可愛くてごめん", "うっせぇわ", "シンデレラ", "新時代"], quizType: .defaultQuiz),
        Quiz(id: 134, title: "この曲のタイトルは？", detail: "『夜に駆けるよ あなたの元へ』", answerNumber: 1, quizOptions: ["ドライフラワー", "夜に駆ける", "Pretender", "シャルル"], quizType: .defaultQuiz),
        Quiz(id: 135, title: "この曲のタイトルは？", detail: "『世界が君の小さな肩に 乗っているんだ』", answerNumber: 3, quizOptions: ["水平線", "ハルノヒ", "115万キロのフィルム", "魔法の絨毯"], quizType: .defaultQuiz),
        Quiz(id: 136, title: "この曲のタイトルは？", detail: "『だけど忘れない ずっと』", answerNumber: 2, quizOptions: ["One Last Kiss", "君の名は希望", "いつか", "カタオモイ"], quizType: .defaultQuiz),
        Quiz(id: 137, title: "この曲のタイトルは？", detail: "『愛してるの言葉じゃ足りないくらいに』", answerNumber: 0, quizOptions: ["アイノカタチ", "恋", "Lemon", "シンデレラガール"], quizType: .defaultQuiz),
        Quiz(id: 138, title: "この曲のタイトルは？", detail: "『この世に僕より愛が似合う人は いないでしょ？』", answerNumber: 1, quizOptions: ["水平線", "ベテルギウス", "ドライフラワー", "キンモクセイ"], quizType: .defaultQuiz),
        Quiz(id: 139, title: "この曲のタイトルは？", detail: "『きっと僕ら千年後の世界でも』", answerNumber: 3, quizOptions: ["香水", "まちがいさがし", "アイラブユー", "怪獣の花唄"], quizType: .defaultQuiz),
        Quiz(id: 140, title: "この曲のタイトルは？", detail: "『僕の心の中の扉を叩いてくれ』", answerNumber: 0, quizOptions: ["CITRUS", "勿忘", "花束", "炎"], quizType: .defaultQuiz)
    ]

    // 2025-02-23-20:15追加
    static let quizCategories: [QuizCategory] = [
        QuizCategory(id: 15, title: "いろいろ", starCount: 3, quizItems: category15, completed: false, correctCount: 0, createdAt: "2025-02-23"),
        QuizCategory(id: 16, title: "漢字の意味と読み", starCount: 5, quizItems: category16, completed: false, correctCount: 0, createdAt: "2025-02-23")
    ]
    
    static let category15: [Quiz] = [
        Quiz(id: 100, title: "読み方を当てよう", detail: "『風景』", answerNumber: 0, quizOptions: ["ふうけい", "かぜえ", "けしき", "ふうかい"], quizType: .readQuiz),
        Quiz(id: 101, title: "ことわざの意味は？", detail: "『犬も歩けば棒に当たる』", answerNumber: 2, quizOptions: ["犬はよく棒をかじる", "歩くと危険な目に遭う", "思わぬ幸運が訪れる", "犬は冒険好き"], quizType: .readQuiz),
        Quiz(id: 102, title: "次の言葉の意味は？", detail: "『温暖』", answerNumber: 1, quizOptions: ["寒い", "暖かい", "激しい", "涼しい"], quizType: .readQuiz),
        Quiz(id: 103, title: "読み方を当てよう", detail: "『経験』", answerNumber: 0, quizOptions: ["けいけん", "けんけい", "しけん", "けいめい"], quizType: .readQuiz),
        Quiz(id: 104, title: "正しい漢字を選ぼう", detail: "「かんきょう」の漢字は？", answerNumber: 3, quizOptions: ["感教", "管共", "間境", "環境"], quizType: .readQuiz),
        Quiz(id: 105, title: "意味を考えよう", detail: "『努力』", answerNumber: 0, quizOptions: ["一生懸命がんばること", "強い力で押し出すこと", "周囲に影響を与えること", "短時間で終わらせること"], quizType: .readQuiz),
        Quiz(id: 106, title: "次の言葉の意味は？", detail: "『責任』", answerNumber: 2, quizOptions: ["優しさ", "正しさ", "自分がやるべきこと", "楽しさ"], quizType: .readQuiz),
        Quiz(id: 107, title: "ことわざの意味は？", detail: "『猿も木から落ちる』", answerNumber: 1, quizOptions: ["猿は木の上が好き", "どんな名人でも失敗する", "猿は地面を嫌う", "努力すれば必ず成功する"], quizType: .readQuiz),
        Quiz(id: 108, title: "漢字の読みを選ぼう", detail: "『宇宙』", answerNumber: 2, quizOptions: ["うちゅ", "うちゅう", "そら", "うつ"], quizType: .readQuiz),
        Quiz(id: 109, title: "正しい意味を選ぼう", detail: "『協力』", answerNumber: 3, quizOptions: ["一人でやること", "強く押し込むこと", "競争すること", "力を合わせること"], quizType: .readQuiz),
        Quiz(id: 110, title: "ことわざの意味は？", detail: "『三日坊主』", answerNumber: 0, quizOptions: ["長続きしないこと", "三日後に成長すること", "坊主の修行", "三日後に結果が出ること"], quizType: .readQuiz)
    ]

    static let category16: [Quiz] = [
        Quiz(id: 111, title: "読み方を当てよう", detail: "『景色』", answerNumber: 0, quizOptions: ["けしき", "けいしき", "ふうけい", "こうけい"], quizType: .readQuiz),
        Quiz(id: 112, title: "正しい意味を選ぼう", detail: "『感謝の気持ちを伝える方法とは？』", answerNumber: 1, quizOptions: ["何も言わない", "ありがとうと言う", "大きな声で叫ぶ", "プレゼントを渡す"], quizType: .defaultQuiz),
        Quiz(id: 113, title: "読み方を当てよう", detail: "『未来』", answerNumber: 2, quizOptions: ["みこ", "みあい", "みらい", "みれい"], quizType: .readQuiz),
        Quiz(id: 114, title: "正しい意味を選ぼう", detail: "『努力を続けるとどうなる？』", answerNumber: 3, quizOptions: ["疲れる", "楽しくなる", "諦める", "成長できる"], quizType: .defaultQuiz),
        Quiz(id: 115, title: "読み方を当てよう", detail: "『成長』", answerNumber: 1, quizOptions: ["せいしん", "せいちょう", "じょうせい", "しょうせい"], quizType: .readQuiz),
        Quiz(id: 116, title: "正しい答えを選ぼう", detail: "『友達と仲良くするには？』", answerNumber: 0, quizOptions: ["相手の気持ちを考える", "意見を押し付ける", "いつも勝つようにする", "無視する"], quizType: .defaultQuiz),
        Quiz(id: 117, title: "読み方を当てよう", detail: "『努力』", answerNumber: 0, quizOptions: ["どりょく", "どろく", "りょくど", "どりょ"], quizType: .readQuiz),
        Quiz(id: 118, title: "正しい答えを選ぼう", detail: "『約束を守らなかったらどうなる？』", answerNumber: 2, quizOptions: ["信頼される", "何も変わらない", "信用をなくす", "友達が増える"], quizType: .defaultQuiz),
        Quiz(id: 119, title: "読み方を当てよう", detail: "『希望』", answerNumber: 1, quizOptions: ["きぼ", "きぼう", "ぼうき", "きほう"], quizType: .readQuiz),
        Quiz(id: 120, title: "正しい意味を選ぼう", detail: "『ルールを守る理由とは？』", answerNumber: 3, quizOptions: ["自由になるため", "自分のため", "先生のため", "みんなが気持ちよく過ごせる"], quizType: .defaultQuiz)
    ]

}
