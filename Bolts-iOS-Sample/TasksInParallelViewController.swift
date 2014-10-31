//
//  TasksInParallelViewController.swift
//  Bolts-iOS-Sample
//
//  Created by Keishi Hosoba on 2014/10/30.
//  Copyright (c) 2014年 hosopy. All rights reserved.
//

import UIKit

class TasksInParallelViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func executeAction(sender: AnyObject) {
        // doRootHeavyJobAsync()で非同期でデータ取得後、各データに紐づくTaskを並列で実行する、みたいなケースを想定
        doRootHeavyJobAsync().continueWithBlock {
            (task: BFTask!) -> BFTask in
            
            let results = task.result as [Double]
            
            // resultsの数だけBFTaskを生成して並列で実行
            return BFTask(forCompletionOfAllTasks: results.map { (delay: Double) -> BFTask in return self.doHeavyJobAsyncWithDelay(delay) })
        }.continueWithBlock {
            (task: BFTask!) -> AnyObject! in
            // tasks全て完了した
            self.showCompletionAlert()
            return nil
        }
    }
    
    private func doRootHeavyJobAsync() -> BFTask {
        var successful = BFTaskCompletionSource()
        
        // 5秒待ちの処理
        // 実用的には、AFNetworkingのcompletionブロック等でsetResultするイメージ
        Util.delay(5, {
            successful.setResult([5, 10, 15])
        })
        
        return successful.task
    }
    
    private func doHeavyJobAsyncWithDelay(delay: Double) -> BFTask {
        var successful = BFTaskCompletionSource()
        
        // delay秒待ちの処理
        // 実用的には、AFNetworkingのcompletionブロック等でsetResultするイメージ
        Util.delay(delay, {
            println(String(format: "Finish!"))
            successful.setResult("success")
        })
        
        return successful.task
    }
    
    private func showCompletionAlert() {
        var alertController = UIAlertController(title: "Complete", message: "iOS8", preferredStyle: .Alert)
    
        let otherAction = UIAlertAction(title: "OK", style: .Default) {
            action in println("Complete")
        }
        alertController.addAction(otherAction)
    
        presentViewController(alertController, animated: true, completion: nil)
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
