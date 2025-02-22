//
//  AddQuizLogic.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/01/29.
//

import Foundation
import RealmSwift


struct RealmQuizRepository {
    
    func printDebugDBElementFromTable()  {
        let realm = try! Realm()
        let categories = realm.objects(RealmQuizCategory.self)

//        for category in categories {
//            print("ID: \(category.id), タイトル: \(category.title), クイズ数: \(category.quizItems.count)")
//        }
        
//        let quizzes = realm.objects(RealmQuiz.self)

//        for quiz in quizzes {
//            print("ID: \(quiz.id), タイトル: \(quiz.title), 問題: \(quiz.detail), 解答番号: \(quiz.answerNumber)")
//            print("選択肢: \(quiz.quizOptions.joined(separator: ", "))")
//        }
        
        for category in categories {
            print("カテゴリ: \(category.id)\(category.title)")
            
            for quiz in category.quizItems {
                print("  - クイズ: \(quiz.id):\(quiz.title), 問題: \(quiz.detail)")
            }
        }
    }

/*
 List -> Arrayへの変換
 let testList = List<Tag>() //List型
 var testArray = Array<Any>() // Array型

 testArray.append(contentsOf: Array(testList)) // Array()でListを変換

 */
    
    /// RealmQuizCategory型のクイズカテゴリー情報をQuizCategory型の配列で返す
    /// - Returns: QuizCategory型の配列
    func getQuizCategoryArray() -> [QuizCategory] {
        let realm = try! Realm()
        let categories = realm.objects(RealmQuizCategory.self)
        return QuizConverter.toQuizCategoryList(categories: categories)
    }
    
    /// 指定したカテゴリidと一致するクイズ情報を取得する
    /// - Parameter id: カテゴリーidを指定する
    /// - Returns: 配列型のクイズ情報
    func getRealmQuizByCategoryId(by id :Int) -> [RealmQuiz]  {
        let realm = try! Realm()
        let categories = realm.objects(RealmQuizCategory.self)
        
        var quizArray:[RealmQuiz] = []
        
        for category in categories {
            if (category.id == id) {
                for quiz in category.quizItems {
                    quizArray.append(quiz)
                }
            }
        }
        return quizArray
    }
    
    /// 指定したカテゴリidと一致するクイズ情報を取得する
    /// - Parameter id: カテゴリーidを指定する
    /// - Returns: 配列型のクイズ情報
    func getQuizByCategoryId(by id :Int) -> [Quiz]  {
        let realm = try! Realm()
        let categories = realm.objects(RealmQuizCategory.self)
        
        var quizArray:[Quiz] = []
        
        for category in categories {
            if (category.id == id) {
                // `RealmQuiz` のリストを `Quiz` に変換する
                quizArray = QuizConverter.toQuizList(quizItems: category.quizItems)
            }
        }
        return quizArray
    }
    
    func isExistCategory(id: Int) -> Bool {
        let realm = try! Realm()
        let categories = realm.objects(RealmQuizCategory.self)
        
        for category in categories {
            if (category.id == id) {
                return true
            }
        }
        return false
    }
    
    /// 入力画面で作ったクイズ情報をデータベースに追加する
    /// - Parameters:
    ///   - quiz: 入力画面で作ったクイズ情報
    ///   - categoryId: 入力画面で設定したカテゴリid
    func addInputQuiz(quiz:RealmQuiz, categoryId: Int) {
        let realm = try! Realm()
        
        let maxId = realm.objects(RealmQuiz.self).max(ofProperty: "id") as Int?
        //クイズidが設定されていないので、最大値を渡す
        quiz.id = (maxId ?? 0) + 1
        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        if let category = realm.objects(RealmQuizCategory.self).filter("id == %@", categoryId).first {
            // 一致するカテゴリが見つかった場合、quizItemsに新しいクイズを追加
            try! realm.write {
                realm.add(quiz)
                category.completed = false
                category.quizItems.append(quiz)
            }
        } else {
            print("指定したカテゴリIDが見つかりませんでした")
        }
    }
    
    /// 既存のクイズの変更を行う
    /// - Parameters:
    ///   - quiz: 入力画面で変更されたクイズ
    ///   - categoryId: 変更するクイズカテゴリid
    func updateInputQuiz(quiz:RealmQuiz, categoryId: Int) {
        let realm = try! Realm()
        
        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        if let category = realm.objects(RealmQuizCategory.self).filter("id == %@", categoryId).first {
            // 一致するカテゴリが見つかった場合、quizItemsに新しいクイズを追加
            try! realm.write {
                print("update")
                realm.add(quiz, update:.modified)
                // TODO: 更新箇所なので、クラッシュ起こしやすいかも？
                print("")
                if let index = category.quizItems.firstIndex(where: { $0.id == quiz.id }) {
                    category.quizItems.remove(at: index)
                    category.quizItems.insert(quiz, at: index)
                }
            }
        } else {
            print("指定したカテゴリIDが見つかりませんでした")
        }
    }
    
    /// 既存のクイズの削除を行う
    /// - Parameters:
    ///   - quiz: 入力画面で変更されたクイズ
    ///   - categoryId: 変更するクイズカテゴリid
    func deleteQuiz(quiz:Quiz, categoryId: Int) {
        
        let realm = try! Realm()
        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        if let category = realm.objects(RealmQuizCategory.self).filter("id == %@", categoryId).first {
            // 引数categoryIdに一致するidのRealmQuizCategoryを取得
            if let matchQuiz = realm.objects(RealmQuiz.self).filter("id == %@", quiz.id).first {
                try! realm.write {
                    // `quizItems` 内で `matchQuiz` を検索し、見つかったら削除
                    if let index = category.quizItems.firstIndex(where: { $0.id == matchQuiz.id }) {
                        category.quizItems.remove(at: index)
                    }
                    // `matchQuiz` を Realm から削除
                    realm.delete(matchQuiz)
                }
            }
        } else {
            print("指定したカテゴリIDが見つかりませんでした")
        }
    }
    
    func showRealmSavePath()  {
        if let realmURL = Realm.Configuration.defaultConfiguration.fileURL {
            print("Realmの保存場所: \(realmURL)")
        }
    }
    
    // デバッグ用
    func showLocalQuiz() {
        print("showLocalQuiz")
        
        let realm = try! Realm()
        print("realmインスタンス取得")
        let allCategories = realm.objects(DefaultRealmQuizCategory.self)
        
        for category in allCategories {
            print("カテゴリ名: \(category.title)")
            for quiz in category.quizItems {
                print("クイズ\(quiz.id)\(quiz.title)")
            }
        }
    }
    
    // ViewModelで活用する
    func fetchLocalQuiz() -> [QuizCategory] {
        let realm = try! Realm()
        
        let allCategories = realm.objects(DefaultRealmQuizCategory.self)
        
//        print("allCategories: \(allCategories)")
        
        let allCategoryArray = QuizConverter.defaultRealmQuizCategoryToQuizCategoryList(categories: allCategories)
        
        var sortedCreatedAtArray: [QuizCategory] = allCategoryArray.sorted{ $0.createdAt > $1.createdAt }
        
        
        
//        for sortedCreatedAt in sortedCreatedAtArray {
//            for item in sortedCreatedAt.quizItems {
//                print("クイズタイトル: \(item.title)")
//            }
//        }
        
        return sortedCreatedAtArray
    }
    
    func defaultRealmQuizInit() {
        let quiz = DefaultRealmQuiz()
        print(quiz.id)
    }
    
    func loadLocalQuizIfNeed() {
        let realm = try! Realm()
        
        let existingCategories = realm.objects(DefaultRealmQuizCategory.self)
        print("DefaultRealmQuizCategory のデータ件数: \(existingCategories.count)")
        
        //判定処理を変える？
        if !existingCategories.isEmpty {
            print("データが入っている")
            return
        }
        
        let quizCategories: [QuizCategory] = QuizCategoryListModel().fetchMockNews()
//      let quizCategories: [QuizCategory] =   QuizCategoryListModel().fetchTestMockNews()
        let defaultCategories :[DefaultRealmQuizCategory] = QuizConverter.quizCategoryToDefaultRealmQuizCategory(categories:quizCategories)
        
        try! realm.write {
            for category in defaultCategories {
                // ① クイズカテゴリを先に保存（quizItemsは空のまま）
                realm.add(category, update: .modified)
                print("✅ カテゴリ追加: \(category.title)")
            }
        }
    }
    
    /// 自作クイズのデフォルトカテゴリを用意しておく
    func initializeDefaultCategoriesIfNeeded() {
        let realm = try! Realm()
        let existingCategories = realm.objects(RealmQuizCategory.self)
        if !existingCategories.isEmpty {
//            print("すでにデフォルトカテゴリは存在する")
            return
        }
        
        if existingCategories.isEmpty {
            let categoryNames = ["漢字", "ことわざ", "動物", "生活", "有名人", "家族", "社会"]
            
            try! realm.write {
                for categoryName in categoryNames {
                    let defaultCategory = RealmQuizCategory()
                    let max2Id = realm.objects(RealmQuizCategory.self).max(ofProperty: "id") as Int?
                    //        print("最大値を取得:\(String(describing: max2Id))")
                    defaultCategory.id = (max2Id ?? 0) + 1
                    defaultCategory.title = categoryName
                    defaultCategory.starCount = 0
                    defaultCategory.createdAt = Date()
                    realm.add(defaultCategory)
                    print("\(categoryName)を追加しました")
                }
            }
        }
    }
    
    
    
    func updateCategoryCorrectCount(by id:Int, quizzesIndex:Int,myQuizFlag:Bool) {
        let realm = try! Realm()
        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        if myQuizFlag {
            let category = realm.objects(RealmQuizCategory.self).filter("id == %@", id).first!
            try! realm.write {
                
                if  category.correctCount < category.quizItems.count {
                    category.correctCount += 1
                    category.completed = false
                } else {
                    category.correctCount = category.quizItems.count
                    category.completed = true
                }
            }
        } else {
            let category = realm.objects(DefaultRealmQuizCategory.self).filter("id == %@", id).first!
            try! realm.write {
                
                if  category.correctCount < category.quizItems.count {
                    category.correctCount += 1
                    category.completed = false
                } else {
                    category.correctCount = category.quizItems.count
                    category.completed = true
                }
            }
        }
        
//        if let category = realm.objects(RealmQuizCategory.self).filter("id == %@", id).first {
//            try! realm.write {
//                
//                if  category.correctCount < category.quizItems.count {
//                    category.correctCount += 1
//                    category.completed = false
//                } else {
//                    category.correctCount = category.quizItems.count
//                    category.completed = true
//                }
//            }
//        } else {
//            print("指定したカテゴリIDが見つかりませんでした")
//        }
    }
    
    func updateCategoryStarCount(by id:Int, starCount:Int){
        let realm = try! Realm()
        
        if let category = realm.objects(RealmQuizCategory.self).filter("id == %@", id).first {
            try! realm.write {
                print("星の数を変更する前:\(category.starCount)")
                category.starCount = starCount
                print("星の数を変更したあと:\(category.starCount)")
            }
        }
    }
    
    func updateCategoryComplete(by id:Int) {
        let realm = try! Realm()
        
        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        if let category = realm.objects(RealmQuizCategory.self).filter("id == %@", id).first {
            try! realm.write {
                if category.correctCount == category.quizItems.count {
                    category.completed = true
                } else {
                    category.completed = true
                }
                realm.add(category, update: .modified)
            }
        } else {
            print("指定したカテゴリIDが見つかりませんでした")
        }
    }
    
    // MARK: 以下はテーブル動作確認用のメソッド群
    
    func deleteAllData() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
            print("削除しました")
        }
    }
    
    func deleteDefaultQuizCategory() {
        let realm = try! Realm()
        try! realm.write {
            let defaultQuiz = realm.objects(DefaultRealmQuiz.self)
            realm.delete(defaultQuiz)
            let defaultQuizCategory = realm.objects(DefaultRealmQuizCategory.self)
            realm.delete(defaultQuizCategory)
            print("DefaultRealmQuizとDefaultQuizCategoryオブジェクト削除しました")
        }
    }
    
    func getTableList() {
        let realm = try! Realm()
        if let objectTypes = realm.configuration.objectTypes {
            for type in objectTypes {
                print("テーブル名: \(type)")
            }
        }
    }
    
    func addFirstMockData() {
        let realm = try! Realm()

        let quiz1 = RealmQuiz()
        let maxId = realm.objects(RealmQuiz.self).max(ofProperty: "id") as Int?
        quiz1.id = (maxId ?? 0) + 1
        quiz1.title = "漢字クイズ"
        quiz1.detail = "「こうぞう」の正しい漢字は？"
        quiz1.answerNumber = 3
        quiz1.quizOptions.append(objectsIn: ["耕造", "幸三", "公造", "構造"])
        print(quiz1)

        let category = RealmQuizCategory()
        let max2Id = realm.objects(RealmQuizCategory.self).max(ofProperty: "id") as Int?
        category.id = (max2Id ?? 0) + 1
        category.title = "漢字クイズ"
        category.starCount = 3
        category.quizItems.append(quiz1)
        category.completed = false
        category.correctCount = 0
        category.createdAt = Date()
        print(category)

        do{
            try realm.write {
                realm.add(quiz1)
                realm.add(category)
                print("追加しました")
            }
        }catch{
            print("Realm書き込みエラー: \(error.localizedDescription)")
        }
        
    }
        
    func addMockQuizByCategory(categoryId: Int) {
        print(categoryId)
        print("DB接続")
    
        let realm = try! Realm()

        let quiz1 = RealmQuiz()
        let maxId = realm.objects(RealmQuiz.self).max(ofProperty: "id") as Int?
        print("最大値を取得:\(String(describing: maxId))")
        quiz1.id = (maxId ?? 0) + 1
        quiz1.title = "漢字クイズ"
        quiz1.detail = "「こうぞう」の正しい漢字は？"
        quiz1.answerNumber = 3
        quiz1.quizOptions.append(objectsIn: ["耕造", "幸三", "公造", "構造"])

        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        if let category = realm.objects(RealmQuizCategory.self).filter("id == %@", categoryId).first {
            print("一致する")
            // 一致するカテゴリが見つかった場合、quizItemsに新しいクイズを追加
            try! realm.write {
                realm.add(quiz1)
                category.quizItems.append(quiz1)
            }
        } else {
            print("指定したカテゴリIDが見つかりませんでした")
        }
    }
    
    func fetchQuizDataByCategoryId(categoryId: Int) -> [RealmQuiz] {
        let realm = try! Realm()
        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        if let category = realm.objects(RealmQuizCategory.self).filter({ $0.id == categoryId }).first {
            // List<RealmQuiz>型をを[RealQuiz]型にする
            var  quizDataArray: [RealmQuiz] = []
            for quiz in category.quizItems {
                quizDataArray.append(quiz)
            }
            return quizDataArray
        } else {
            print("指定したカテゴリIDが見つかりませんでした")
            return []
        }
    }
    
}

