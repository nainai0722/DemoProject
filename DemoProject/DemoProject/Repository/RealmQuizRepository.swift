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
        let realm = try! Realm()
        let allCategories = realm.objects(DefaultRealmQuizCategory.self)
        print("カテゴリ数: \(allCategories.count)")
        var quizCount = 0
        for category in allCategories {
//            print("カテゴリ情報: \(category.title)\(category.id)")
            quizCount += category.quizItems.count
//            print("クイズ数 : \(category.quizItems.count)")
            for quiz in category.quizItems {
//                print("クイズ: \(quiz.id)\(quiz.title)\(quiz.detail)")
            }
        }
        print("クイズの数: \(quizCount)")
    }
    
    
    /// DBからローカルクイズデータを取得し、ViewModelで扱える型に変換し、日付降順でソートし、値を返す
    /// - Returns: <#description#>
    func fetchLocalQuiz() -> [QuizCategory] {
        let realm = try! Realm()
        
        let allCategories = realm.objects(DefaultRealmQuizCategory.self)
        
        let allCategoryArray = QuizConverter.defaultRealmQuizCategoryToQuizCategoryList(categories: allCategories)
        
        var sortedCreatedAtArray: [QuizCategory] = allCategoryArray.sorted{ $0.createdAt > $1.createdAt }
        
        return sortedCreatedAtArray
    }
    
    
    /// 動作チェック用に追加したが、すでに要らないかもしれない
    func defaultRealmQuizInit() {
        let quiz = DefaultRealmQuiz()
        print(quiz.id)
    }
    
    
    /// ローカルDBにデータを追加する
    func addLocalQuizIfNeed() {
        // DB接続
        let realm = try! Realm()
        // テーブル情報取得
        let existingCategories = realm.objects(DefaultRealmQuizCategory.self)
        
        // LocalQuizData構造体に置いているクイズデータを取得する
        let addCategories = LocalQuizData().getLocalQuiz()
        // クイズデータをDBに流し込める型に変換する
        let defaultCategories :[DefaultRealmQuizCategory] = QuizConverter.quizCategoryToDefaultRealmQuizCategory(categories:addCategories)
        // 内容が相違ないか目視で確かめる
//        for category in defaultCategories {
//            print("タイトル : \(category.title)\(category.id)")
//            for quizItemArray in category.quizItemArray {
//                print("クイズタイトル : \(quizItemArray.title)クイズid: \(quizItemArray.id)")
//            }
//        }
        
        // データ追加の条件を確認する
        // 追加する内容と既存の内容を比較し、idが一致するもしくは追加する内容のほうがidが小さいときは追加しない　更新を防ぐ
        if let existLastId = existingCategories.last?.id ,let addLastId = addCategories.last?.id {
            if existLastId >= addLastId {
                print("追加は必要なし")
                return
            }
        }
        
        print("追加する")
        // 配列ごと追加する 上書きを受け入れない場合は、 update: .modifiedを削除する
        try! realm.write {
            realm.add(defaultCategories, update: .modified)
        }
    }
    
    /// ローカルクイズが1件も存在しないときに、クイズデータを取得し、DBに保存する
    func loadLocalQuizIfNeed() {
        let realm = try! Realm()
        
        let existingCategories = realm.objects(DefaultRealmQuizCategory.self)
        print("DefaultRealmQuizCategory のデータ件数: \(existingCategories.count)")
        
        //判定処理を変える？
        if !existingCategories.isEmpty {
//            print("データが入っている")
            return
        }
        
        let quizCategories: [QuizCategory] = QuizCategoryListModel().fetchMockNews()
//        let quizCategories: [QuizCategory] =   QuizCategoryListModel().fetchTestMockNews()
        let defaultCategories :[DefaultRealmQuizCategory] = QuizConverter.quizCategoryToDefaultRealmQuizCategory(categories:quizCategories)
        
        print("事前確認")
        for category in defaultCategories {
            print("カテゴリ: \(category.title)\(category.id)")
            for quizItem in category.quizItems {
                print("クイズ: \(quizItem.title)\(quizItem.id)")
            }
        }
        
        do {
            try realm.write {
                realm.add(defaultCategories)
            }
        } catch {
            print("エラー\(error.localizedDescription)")
        }
    }
    
    /// 自作クイズのデフォルトカテゴリを用意しておく
    func initializeDefaultCategoriesIfNeeded() {
        let realm = try! Realm()
        let existingCategories = realm.objects(RealmQuizCategory.self)
        // すでにデフォルトカテゴリは存在する場合は処理を終了する
        if !existingCategories.isEmpty {
            return
        }
        
        if existingCategories.isEmpty {
            let categoryNames = ["漢字", "ことわざ", "動物", "生活", "有名人", "家族", "社会"]
            
            try! realm.write {
                for categoryName in categoryNames {
                    let defaultCategory = RealmQuizCategory()
                    let max2Id = realm.objects(RealmQuizCategory.self).max(ofProperty: "id") as Int?
                    defaultCategory.id = (max2Id ?? 0) + 1
                    defaultCategory.title = categoryName
                    defaultCategory.starCount = 0
                    defaultCategory.createdAt = Date()
                    realm.add(defaultCategory)
//                    print("\(categoryName)を追加しました")
                }
            }
        }
    }
    
    
    
    func updateCategoryCorrectCount(by id:Int, quizzesIndex:Int,myQuizFlag:Bool) {
        let realm = try! Realm()
        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        var category:(any QuizCategoryProtocol)? = nil
        if myQuizFlag {
            print("自作クイズ")
            category =  realm.objects(RealmQuizCategory.self).filter("id == %@",id).first
        } else {
            print("ローカルクイズ")
            print("指定id\(id)")
            print("クイズインデックス\(quizzesIndex)")
            category = realm.objects(DefaultRealmQuizCategory.self).filter("id == %@",id).first
        }
        if var category = category {
            try! realm.write {
                if  category.correctCount < category.quizItemArray.count{
                    // 正解数に対して、インデックスと同じとき、正解数を追加
                    if category.correctCount == quizzesIndex {
                        print("正解数追加")
                        category.correctCount += 1
                        category.completed = false
                    }
                    
                } else {
                    category.correctCount = category.quizItemArray.count
                    category.completed = true
                }
                realm.add(category as! Object, update: .modified)
            }
        }
    }
    
    func updateCategoryStarCount(by id:Int, starCount:Int, myQuizFlag:Bool){
        let realm = try! Realm()
        
        var category :(any QuizCategoryProtocol)? = nil
        if myQuizFlag {
            category = realm.objects(RealmQuizCategory.self).filter("id == %@", id).first
        } else {
            category = realm.objects(DefaultRealmQuizCategory.self).filter("id == %@",id).first
        }
        
        if var category = category {
            try! realm.write {
                print("星の数を変更する前:\(category.starCount)")
                category.starCount = starCount
                print("星の数を変更したあと:\(category.starCount)")
                realm.add(category as! Object, update: .modified)
            }
        }
    }
    
    func updateCategoryComplete(by id:Int,myQuizFlag:Bool) {
        let realm = try! Realm()
        
        var category :(any QuizCategoryProtocol)? = nil
        
        if myQuizFlag {
            category = realm.objects(RealmQuizCategory.self).filter("id == %@", id).first
        } else {
            category = realm.objects(DefaultRealmQuizCategory.self).filter("id == %@", id).first
        }
        // 引数categoryIdに一致するidのRealmQuizCategoryを取得
        if var category = category {
            try! realm.write {
                if category.correctCount == category.quizItemArray.count {
                    category.completed = true
                } else {
                    category.completed = true
                }
                realm.add(category as! Object, update: .modified)
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

