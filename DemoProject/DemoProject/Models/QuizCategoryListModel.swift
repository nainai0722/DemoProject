//
//  QuizCategoryListModel.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/28.
//

import SwiftUI
import Combine

final class QuizCategoryListModel: ObservableObject {
    @Published var categories: [QuizCategory] = []
    
    func fetch() {
        // 検証用のクイズカテゴリを取得する
        fetchMockNews { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self.categories = news
                case .failure(let error):
                    print("エラーが発生しました: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func fetchMockNews(completion: @escaping (Result<[QuizCategory], Error>) -> Void) {

        // サンプルデータを返すフェッチ処理
        let quizCategories: [QuizCategory] = [
            QuizCategory(id: 1, title: "漢字", starCount: 3, quizItems: wordQuiz, completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 2, title: "ことわざ", starCount: 5, quizItems: kotowazaQuiz, completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 4, title: "生き物", starCount: 0, quizItems: animalQuiz, completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 5, title: "時間", starCount: 4, quizItems: [], completed: false, correctCount: 0, createdAt: "2025-01-28"),
            QuizCategory(id: 3, title: "生活", starCount: 2, quizItems: [], completed: false, correctCount: 0, createdAt: "2025-01-28")
        ]

        completion(.success(quizCategories))
    }
    
    
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
        Quiz(id: 1, title: "ダンゴムシについて知ろう", detail: "ダンゴムシのオスとメスの見分け方はどれ？", answerNumber: 2, quizOptions: ["大きさで見分ける","お尻の形で見分ける","体のもようで見分ける","食べるもので見分ける"])
    ]
}
