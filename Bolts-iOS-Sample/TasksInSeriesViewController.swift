//
//  TasksInSeriesViewController.swift
//  Bolts-iOS-Sample
//
//  Created by Keishi Hosoba on 2014/10/30.
//  Copyright (c) 2014年 hosopy. All rights reserved.
//

import UIKit

class TasksInSeriesViewController: UIViewController {
    
    
    @IBOutlet private weak var resultLabel1: UILabel!
    @IBOutlet private weak var resultLabel2: UILabel!
    @IBOutlet private weak var resultLabel3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func executeAction(sender: AnyObject) {
        // doHeavyJobAsync1-3 で文字列を繋げるゲーム。無料です。
        
        self.resultLabel1.text = "処理中..."
        
        // サンプルコードとしてこうしているが、UIの操作はmainThreadExecutorで行うべき
        // doHeavyJobAsync1().continueWithExecutor(BFExecutor.mainThreadExecutor(), withBlock:{
        // doHeavyJobAsync1 から開始
        doHeavyJobAsync1().continueWithBlock {
            (task: BFTask!) -> BFTask in
            // doHeavyJobAsync1完了
            // 本来はエラー処理などを行うべきですが、理解し易さ重視で簡略化
            let result = task.result as NSString
            self.resultLabel1.text = result
            
            // 次は doHeavyJobAsync2
            self.resultLabel2.text = "処理中..."
            return self.doHeavyJobAsync2(result)
        }.continueWithBlock {
            (task: BFTask!) -> BFTask in
            // doHeavyJobAsync2完了
            // 本来はエラー処理などを行うべきですが、理解し易さ重視で簡略化
            let result = task.result as NSString
            self.resultLabel2.text = result
            
            // 次は doHeavyJobAsync3
            self.resultLabel3.text = "処理中..."
            return self.doHeavyJobAsync3(result)
        }.continueWithBlock {
            (task: BFTask!) -> AnyObject! in
            // doHeavyJobAsync3完了
            // 本来はエラー処理などを行うべきですが、理解し易さ重視で簡略化
            let result = task.result as NSString
            self.resultLabel3.text = result
            
            // 完了
            return nil
        }
    }
    
    private func doHeavyJobAsync1() -> BFTask {
        var successful = BFTaskCompletionSource()
        
        // 5秒待ちの処理
        // 実用的には、AFNetworkingのcompletionブロック等でsetResultするイメージ
        Util.delay(5, {
            successful.setResult("人生")
        })
        
        return successful.task
    }
    
    private func doHeavyJobAsync2(prevResult: String) -> BFTask {
        var successful = BFTaskCompletionSource()
        
        // 5秒待ちの処理
        // 実用的には、AFNetworkingのcompletionブロック等でsetResultするイメージ
        Util.delay(5, {
            successful.setResult(prevResult + "ｵﾜﾀ")
        })
        
        return successful.task
    }
    
    private func doHeavyJobAsync3(prevResult: String) -> BFTask {
        var successful = BFTaskCompletionSource()
        
        // 5秒待ちの処理
        // 実用的には、AFNetworkingのcompletionブロック等でsetResultするイメージ
        Util.delay(5, {
            successful.setResult(prevResult+"＼(^o^)／")
        })
        
        return successful.task
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
