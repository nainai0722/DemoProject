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
        
        
        return LocalQuizData.quizCategories3
    }
    
    static let quizCategories3:[QuizCategory] = [
        QuizCategory(id: 19, title: "雑学", starCount: 3, quizItems: category19, completed: false, correctCount: 0, createdAt: "2025-02-23"),
        QuizCategory(id: 20, title: "雑学", starCount: 3, quizItems: category20, completed: false, correctCount: 0, createdAt: "2025-02-23"),
        QuizCategory(id: 21, title: "マイクラ", starCount: 3, quizItems: category21, completed: false, correctCount: 0, createdAt: "2025-02-23"),
        QuizCategory(id: 22, title: "マイクラ", starCount: 3, quizItems: category22, completed: false, correctCount: 0, createdAt: "2025-02-23"),
        
    ]
    
    static let category19: [Quiz] = [
        Quiz(id: 141, title: "世界一高い山は？", detail: "標高8,848m", answerNumber: 0, quizOptions: ["エベレスト", "キリマンジャロ", "モンブラン", "マッターホルン"], quizType: .defaultQuiz),
        Quiz(id: 142, title: "シマウマの模様は？", detail: "白黒どっちの動物？", answerNumber: 1, quizOptions: ["白に黒のしま", "黒に白のしま", "グレー", "茶色"], quizType: .defaultQuiz),
        Quiz(id: 143, title: "太陽の光が地球に届く時間", detail: "約○分", answerNumber: 2, quizOptions: ["5分", "10分", "8分", "12分"], quizType: .defaultQuiz),
        Quiz(id: 144, title: "世界で一番消費されている飲み物", detail: "コーヒーより多い", answerNumber: 3, quizOptions: ["コーヒー", "ジュース", "水", "お茶"], quizType: .defaultQuiz),
        Quiz(id: 145, title: "日本で一番面積が広い都道府県", detail: "北海道、沖縄、長野、岩手のどれ？", answerNumber: 0, quizOptions: ["北海道", "沖縄", "長野", "岩手"], quizType: .defaultQuiz),
        Quiz(id: 146, title: "1円玉の重さは？", detail: "○グラム", answerNumber: 1, quizOptions: ["2g", "1g", "3g", "5g"], quizType: .defaultQuiz),
        Quiz(id: 147, title: "日本で一番長い川", detail: "全長367km", answerNumber: 0, quizOptions: ["信濃川", "利根川", "淀川", "筑後川"], quizType: .defaultQuiz),
        Quiz(id: 148, title: "地球の7割を占めるもの", detail: "ほとんどが○○", answerNumber: 2, quizOptions: ["砂漠", "森林", "海", "氷"], quizType: .defaultQuiz),
        Quiz(id: 149, title: "1年のうち、一番昼が長い日", detail: "何の日？", answerNumber: 0, quizOptions: ["夏至", "冬至", "春分", "秋分"], quizType: .defaultQuiz),
        Quiz(id: 150, title: "雷は上から落ちる？", detail: "実は違う！", answerNumber: 1, quizOptions: ["上から下", "下から上", "横から", "どっちでもない"], quizType: .defaultQuiz)
    ]

    
    static let category20: [Quiz] = [
        Quiz(id: 151, title: "パンダの主食は？", detail: "何を食べる？", answerNumber: 0, quizOptions: ["竹", "肉", "果物", "草"], quizType: .defaultQuiz),
        Quiz(id: 152, title: "一番大きな哺乳類", detail: "海にいる", answerNumber: 1, quizOptions: ["ゾウ", "シロナガスクジラ", "カバ", "ゴリラ"], quizType: .defaultQuiz),
        Quiz(id: 153, title: "世界で一番話されている言語", detail: "中国で使われる", answerNumber: 2, quizOptions: ["英語", "スペイン語", "中国語", "フランス語"], quizType: .defaultQuiz),
        Quiz(id: 154, title: "日本の国鳥は？", detail: "赤い顔が特徴", answerNumber: 0, quizOptions: ["キジ", "スズメ", "タカ", "ツバメ"], quizType: .defaultQuiz),
        Quiz(id: 155, title: "オリンピックの開催間隔", detail: "○年に1回", answerNumber: 1, quizOptions: ["2年", "4年", "6年", "8年"], quizType: .defaultQuiz),
        Quiz(id: 156, title: "人間の骨の数", detail: "○個", answerNumber: 2, quizOptions: ["150", "250", "206", "180"], quizType: .defaultQuiz),
        Quiz(id: 157, title: "カメレオンが色を変える理由", detail: "なぜ変わる？", answerNumber: 3, quizOptions: ["迷彩", "気分", "温度調整", "コミュニケーション"], quizType: .defaultQuiz),
        Quiz(id: 158, title: "日本の最南端の島", detail: "有人島で最南端", answerNumber: 0, quizOptions: ["波照間島", "与那国島", "沖ノ鳥島", "石垣島"], quizType: .defaultQuiz),
        Quiz(id: 159, title: "マグロが泳ぎ続ける理由", detail: "止まると○○", answerNumber: 1, quizOptions: ["眠くなる", "呼吸できない", "捕食される", "筋肉が落ちる"], quizType: .defaultQuiz),
        Quiz(id: 160, title: "カタツムリの目はどこ？", detail: "どこにある？", answerNumber: 2, quizOptions: ["口の近く", "足", "触角の先", "甲羅の下"], quizType: .defaultQuiz)
    ]

    
    static let category21: [Quiz] = [
        Quiz(id: 161, title: "マイクラの基本ブロック", detail: "最初に手に入れるブロックは？", answerNumber: 0, quizOptions: ["木", "石", "ダイヤモンド", "鉄"], quizType: .defaultQuiz),
        Quiz(id: 162, title: "クリーパーの特徴", detail: "近づくと何をする？", answerNumber: 1, quizOptions: ["逃げる", "爆発する", "攻撃する", "毒を与える"], quizType: .defaultQuiz),
        Quiz(id: 163, title: "ダイヤモンドを掘るのに必要なツール", detail: "どのツルハシで掘れる？", answerNumber: 2, quizOptions: ["木のツルハシ", "石のツルハシ", "鉄のツルハシ", "金のツルハシ"], quizType: .defaultQuiz),
        Quiz(id: 164, title: "ネザーに行く方法", detail: "何を作る？", answerNumber: 3, quizOptions: ["ポータル", "梯子", "魔法陣", "ネザーポータル"], quizType: .defaultQuiz),
        Quiz(id: 165, title: "エンダードラゴンのいる場所", detail: "どこにいる？", answerNumber: 0, quizOptions: ["エンド", "ネザー", "地下洞窟", "スカイワールド"], quizType: .defaultQuiz),
        Quiz(id: 166, title: "村人の職業", detail: "司書の仕事は？", answerNumber: 1, quizOptions: ["作物を育てる", "本を売る", "武器を作る", "ポーションを作る"], quizType: .defaultQuiz),
        Quiz(id: 167, title: "レッドストーンの使い道", detail: "何ができる？", answerNumber: 2, quizOptions: ["装備を作る", "食料を作る", "回路を作る", "水を止める"], quizType: .defaultQuiz),
        Quiz(id: 168, title: "エリトラの使い方", detail: "どうやって飛ぶ？", answerNumber: 3, quizOptions: ["走る", "ジャンプする", "泳ぐ", "ロケット花火を使う"], quizType: .defaultQuiz),
        Quiz(id: 169, title: "ネザーにある危険な城", detail: "何という？", answerNumber: 0, quizOptions: ["ネザー要塞", "エンドシティ", "廃坑", "森の洋館"], quizType: .defaultQuiz),
        Quiz(id: 170, title: "ゾンビピグリンの特徴", detail: "攻撃しなければ？", answerNumber: 1, quizOptions: ["襲ってくる", "襲ってこない", "すぐ消える", "金を落とす"], quizType: .defaultQuiz)
    ]

    
    static let category22: [Quiz] = [
        Quiz(id: 171, title: "マイクラで一番硬いブロック", detail: "爆発にも強い！", answerNumber: 2, quizOptions: ["鉄ブロック", "黒曜石", "ネザライトブロック", "ダイヤモンドブロック"], quizType: .defaultQuiz),
        Quiz(id: 172, title: "最初の夜に作るべきもの", detail: "敵から身を守るために必要なもの", answerNumber: 0, quizOptions: ["家", "剣", "畑", "ベッド"], quizType: .defaultQuiz),
        Quiz(id: 173, title: "エンダーマンの弱点", detail: "何に触れるとダメージを受ける？", answerNumber: 1, quizOptions: ["火", "水", "石", "金"], quizType: .defaultQuiz),
        Quiz(id: 174, title: "ビーコンを作るために必要なボス", detail: "何を倒せばいい？", answerNumber: 3, quizOptions: ["エンダードラゴン", "ガスト", "エルダーガーディアン", "ウィザー"], quizType: .defaultQuiz),
        Quiz(id: 175, title: "シュルカーボックスの特徴", detail: "何ができる？", answerNumber: 2, quizOptions: ["攻撃力アップ", "空を飛べる", "アイテムを持ち運べる", "自動でアイテムを分類"], quizType: .defaultQuiz),
        Quiz(id: 176, title: "一番速く移動できる手段", detail: "どれが一番速い？", answerNumber: 3, quizOptions: ["ボート", "馬", "ネザー鉄道", "氷の上のボート"], quizType: .defaultQuiz),
        Quiz(id: 177, title: "エンドシティで手に入る貴重なアイテム", detail: "どこで手に入る？", answerNumber: 1, quizOptions: ["ネザー", "エンドシティ", "村", "ピリジャーの前哨基地"], quizType: .defaultQuiz),
        Quiz(id: 178, title: "雷が落ちると変身する敵", detail: "どの敵？", answerNumber: 0, quizOptions: ["クリーパー", "ゾンビ", "スケルトン", "ウィザー"], quizType: .defaultQuiz),
        Quiz(id: 179, title: "ネザライトを作るために必要な鉱石", detail: "何を使う？", answerNumber: 2, quizOptions: ["鉄", "ダイヤモンド", "古代の残骸", "レッドストーン"], quizType: .defaultQuiz),
        Quiz(id: 180, title: "最強の装備", detail: "どの素材が最強？", answerNumber: 3, quizOptions: ["鉄", "ダイヤモンド", "金", "ネザライト"], quizType: .defaultQuiz)
    ]

    
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
