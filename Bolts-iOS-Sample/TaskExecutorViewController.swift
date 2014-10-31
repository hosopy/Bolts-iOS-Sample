//
//  TaskExecutorViewController.swift
//  Bolts-iOS-Sample
//
//  Created by Keishi Hosoba on 2014/10/31.
//  Copyright (c) 2014年 hosopy. All rights reserved.
//

import UIKit

class TaskExecutorViewController: UIViewController {

    @IBOutlet private weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func executeAction(sender: AnyObject) {
        self.resultLabel.text = "処理中..."
        
        self.doHeavyJobAsync().continueWithExecutor(BFExecutor.mainThreadExecutor(), withBlock:{
            // doHeavyJobAsync が返したBFTaskが完了したら呼ばれる
            (task: BFTask!) -> BFTask! in
            if task.cancelled {
                // キャンセル
            } else if task.error != nil {
                // エラー
                self.resultLabel.text = "エラー"
            } else {
                // 成功
                let result = task.result as NSString
                self.resultLabel.text = result
            }
            
            // このTaskで終了
            return nil
        })
    }

    private func doHeavyJobAsync() -> BFTask {
        var completionSource = BFTaskCompletionSource()
        
        // 5秒待ちの処理
        // 実用的には、AFNetworkingのcompletionブロック等でsetResultするイメージ
        Util.delay(5, {
            completionSource.setResult("人生ｵﾜﾀ＼(^o^)／")
            // エラーにしたければ setError
            //completionSource.setError(NSError(domain:"hosopy.com", code:-1, userInfo: nil))

        })
        
        return completionSource.task
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
