### Agenda

1. re:Invent全体総括
2. アップデート
    1. 注目のUpdates　（AIが中心）
    2. DevOpsに関わるUpdates
    3. それ以外のUpdates（筆者の好み）
3. セッション紹介

- re:Invent直前にも多くのUpdatesが発表されていたので、それも一部含めて話します
  - re:Invent自体はAIの話をメインにするために、他のアップデートは事前に出てた説あり

---

# 全体総括

- AI/MLが中心
  - 周辺エコシステムも強化
    - ML向けの計算資源の提供強化
    - MLOps環境強化（SageMaker, Bedrock）
    - RAG関連のUpdates
  - AWSはAI自体は後発だが、既存サービスにAIを組み込む形が一気に出てきた
  - AWS CEO(Adam Selispky) のKeynoteでは NVIDIAのCEO、AnthropicのCEOとの対談あり
    - Anthropic: ClaudeというLLMを開発
- 「簡単にアプリ/インフラ構築」系のUpdatesも多い　（CodeCatalyst, Application Composer, Q）
  - 一方で、Software Delivery系は少なかった
- 参考）　2022年の中心は データエンジニアリング系

↓のイメージではなく

| DBサービス群 | Networkサービス群 | Computingサービス群 | AIサービス群 |
| --- | --- | --- | --- |

↓のイメージ

| DBサービス群 | Networkサービス群 | Computingサービス群 | AIサービス群 |
| --- | --- | --- | --- |
| AI | AI | AI | AI |

---

# Updates

## 目玉のUpdates

1. **Amazon Q （新サービス）**
    1. GenAI アシスタント
    2. 顧客の情報をモデルトレーニングに一切使わない
    3. Amazon Qは「どこにでもいる」
        1. 開発者向け
            1. コンソール上でChatGPT的なQA
            2. コンソール上でエラーが出た時に”Troubleshoot with Amazon Q”ボタンを押すと、解決策の提案までしてくれる
            3. Amazon Q Code Transformation:  Java8→17の変換とか
            4. Amazon Q generative SQL in Amazon Redshift：　自然言語から意図を汲み取ってSQL作ってくれる
            5. Amazon Q Data integration in AWS Glue（予定のみ）：　自然言語でGlueを使いやすく
            6. EC2インスタンス選定支援
            7. AWS ChatbotがAmazon Q Conversationをサポート：　Slack,Teams上でAWS関連の質問をできる
            8. Amazon Q in the AWS Console Mobile Application： スマホのAWSコンソールアプリからAmazon Qに質問できる（Preview版。まだAndroidのみ）
        2. ビジネス向け
            1. Jira, Salesforce, ServiceNow, Zendesk等との連携も
            2. AWS内でも、QuickSight（BI）やAmazon Connect（コンタクトセンターサービス）などとの連携も
2. DBでベクトル検索の拡充：MemoryDB for Redis、DocumentDB、DynamoDB(OpenSearch経由)
    1. **→ AIがRAGで検索する際に使える**
3. **S3 Express One Zone：　高速アクセス・低可用性のS3**
    1. ユースケース例：　AI/MLトレーニング、金融モデリング、メディア処理、Athenaクエリ高速化
4. ML向け
    1. Bedrockの強化　　（Bedrock: 　AWS等が提供する基盤モデルを、APIを通じて利用できるフルマネージドサービス）
        1. Bedrockでモデルのファインチューニングが可能に (GA@US)
        2. Knowledge Base for Amazon BedrockがGA @US　：　フルマネージドのRAG
        3. BedrockのContinued pre-training がGA @US
        4. Agents for Amazon BedrockがGA @US  :　基盤モデルだけで完結しないタスクをフルマネージドで実行
        5. Guardrails for Amazon Bedrock (preview @US) :  クエリと応答から、不適切なコンテンツをフィルタ
    2. 強力なEC2インスタンスの追加　（モデル学習用など）
        1. Graviton 4とEC2 R8gインスタンス
            1. Graviton：　AWSが設計したARMベースプロセッサ
            2. R8gの”R”はRAMのR。メモリ最適系の意
        2. Trainium 2とEC2 Trn2インスタンス:   MLトレーニング処理能力が強力に
5. FinOps
    1. AWS Management Console myApplications登場：　「後から」グルーピングしてコスト分析できる　　例）アプリ別、サブシステム別、環境別
        1. 以前も、あらかじめリソースにタグ付けしておけばグループ毎のコスト分析は可能だったが、リソースが増えるにつれてタグ管理が大変に
        2. Werner (Amazon.comのCTO)がキーノート前半でコスト最適化の話をしていた。　FinOpsがアツい分野になる/なっている？

            ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/6bb05ca2-c619-43d2-9b51-2da2ea3cb026/65ce290e-3783-4f31-a20c-6af3b4ca37cb/Untitled.png)

## DevOps関連のUpdates

1. Development
    1. CodeWhispererの強化
        1. CodeWhisperer:  GitHub CopilotのAWS版
        2. IaCのサポート強化：　CloudFormation, CDK, Terraformの提案に対応
            1. CloudFormation：　AWSのIaCサービス。Yaml的な設定ファイルを書いてapplyすると、AWSインフラに適用される。
            2. CDK:   JavaやGoでIaCできるサービス。ビルドするとCloudFormationのYamlが作成される。　Cloud Development Kit
        3. セキュリティスキャンの言語サポート強化：　Java,Python,JavaScript,TypeScript,C#に対応
    2. Console-to-Code登場：　コンソールの操作内容からコード(CDK/CloudFormation/CLI)に変換可能。Excelマクロ記録的な機能。（Preview)
    3. Application Composer in VS Code：　Application ComposerをVS Code上でも使えるように
        1. Application Composer:  サーバレスアプリをグラフィカルに設計して、CloudFormationのYamlを生成できるサービス
        2. VSCodeでの使い方（1分で始められます）：　https://dev.classmethod.jp/articles/update-reinvent23-application-composer-in-vs-code/
    4. **CodeCatalystの強化**
        1. CodeCatalyst: 　開発環境のセットアップ、Issue/タスク/PR管理、CI/CDができるサービス。　Azure DevOpsに近いらしい。　日本ではまだGAされてない
            1. 概要（公式のBlackbeltのPDF）：　[https://pages.awscloud.com/rs/112-TZM-766/images/20221222_25th_ISV_DiveDeepSeminar_CodeCatalystの紹介.pdf](https://pages.awscloud.com/rs/112-TZM-766/images/20221222_25th_ISV_DiveDeepSeminar_CodeCatalyst%E3%81%AE%E7%B4%B9%E4%BB%8B.pdf)
        2. **カスタムブループリントをサポート**：　チームのベストプラクティスを定義して推進可能に
        3. Amazon QがCodeCatalystと連携して、Amazon QにIssueをアサインできるように
            1. [**Improve developer productivity with generative-AI powered Amazon Q in Amazon CodeCatalyst (preview) | Amazon Web Services**](https://aws.amazon.com/jp/blogs/aws/improve-developer-productivity-with-generative-ai-powered-amazon-q-in-amazon-codecatalyst-preview/)
        4. GenAI x CodeCatalystのセッションあり
            1. https://www.youtube.com/watch?v=SUqap3JZYmc
2. CI/CD
    1. **CloudFormationがGitとの同期をサポート**
        1. CIからCloudFormationのAPIを叩かずとも、Git側に変更があれば自動で同期される　＝ GitOps
        2. Gitリポジトリとしては、GitHub, GitHub Enterprise Server, GitLab, BitBucketをサポート　※CodeCommit(AWSのGitリポジトリサービス)が対象外
    2. CodeBuildでLambdaによるビルド・テストをサポート
        1. CodeBuild:  CI/CDパイプラインにおけるテスト・ビルド用サービス
        2. メリット：　起動が高速＋安い　（15分以内での完結はMust）
3. Networking
    1. ALB が ATWによる流量制御に対応
        1. ALB:   AWSのL7ロードバランサ.  Application Load Balancer.
        2. ATW:  自動ターゲット重み付け (Automatic Target Weights)
        3. 「アプリに障害があってもヘルスチェックは成功している」ようなケースで、そのターゲットへのトラフィックを自動で減らす
        4. Progressive Deliveryと薄っすら関連するかも？
        5. https://aws.amazon.com/jp/about-aws/whats-new/2023/11/application-load-balancer-availability-target-weights/
    2. CloudFront がエッジでのKeyValueStoreをサポート
        1. CloudFront:  CDNサービス
        2. ユースケースとして A/Bテスト、feature flags があるとのこと
        3. https://aws.amazon.com/jp/blogs/news/introducing-amazon-cloudfront-keyvaluestore-a-low-latency-datastore-for-cloudfront-functions/
4. Container、Serverless：　セキュリティ系が多い
    1. Inspector関連　（脆弱性スキャンサービス）
        1. **Inspector** **CI/CD Container Scanning**
            1. コンテナイメージスキャンのシフトレフト
            2. 拡張イメージスキャンもCI/CDパイプラインに組み込めるようになった
                1. Basicスキャン：　OSパッケージのみ。　これは以前からパイプラインに組み込めた
                2. 拡張スキャン：　アプリのパッケージもスキャンできる
            3. https://dev.classmethod.jp/articles/reinvent2023-inspector-image-scanning-cicd-support/
        2. **Lambdaの脆弱なコードに対する修正提案**
            1. Lambdaのコードスキャン自体はre:Invent2022で発表済
            2. GenAIを用いて、修正案を提示してくれる
            3. https://aws.amazon.com/jp/blogs/aws/three-new-capabilities-for-amazon-inspector-broaden-the-realm-of-vulnerability-scanning-for-workloads/

                ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/6bb05ca2-c619-43d2-9b51-2da2ea3cb026/14abf16f-5d77-443e-9dfd-46d17a913b21/Untitled.png)

    2. **GuardDuty ECS Runtime Monitoring（GA）**：　コンテナランタイムのセキュリティ対策
        1. GuardDuty: 脅威検出サービス
        2. https://dev.classmethod.jp/articles/guardduty-ecs-runtime-monitoring/

            ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/6bb05ca2-c619-43d2-9b51-2da2ea3cb026/1199c074-30b2-4467-8a74-ee4fad83c069/Untitled.png)

    3. EKS向けのPrometheusメトリクスコレクター：　エージェントレスでPrometheusメトリクスを収集できる
        1. https://aws.amazon.com/jp/about-aws/whats-new/2023/11/amazon-managed-service-prometheus-agentless-collector-metrics-eks/
5. Ops
    1. CloudWatch（オブザーバビリティ系サービス）
        1. **CloudWatch Application Signals登場**
            1. アプリのリクエスト量・可用性・レイテンシなどを自動計測→ダッシュボードで可視化（構築不要）
            2. SLOの定義も可能
        2. CloudWatch Logs関連　（CloudWatch Logs：　CloudWatchの中のログ関連機能）
            1. MLベースのログ分析機能
            2. 低頻度Accessクラス登場：　CloudWatchLogsへのログのPutが安い（ログのPutはコストかさみやすい）
        3. ログとメトリクスの分析において、自然言語によるクエリ生成に対応

## その他のUpdates

1. Serverless
    1. Lambdaのスケールアウトが12 倍高速に：　　1分毎に500追加　→　10秒毎に1,000追加
        1. https://aws.amazon.com/jp/blogs/news/aws-lambda-functions-now-scale-12-times-faster-when-handling-high-volume-requests/
2. Application Integration
    1. Step Functionsの強化（ワークフロー管理のフルマネージドサービス）
        1. 失敗したステートからの再実行をサポート
        2. 一つのステップをテストするためのAPIを提供：　部分的なテストが可能に
        3. HTTPSエンドポイントをサポート：　Lambdaを使わずに直接外部APIを叩けるように　→　SaaS等との連携が容易に
3. Networking
    1. ALBがmTLS認証をサポート
    2. Route53 ARCの自動ゾーンシフト機能：　AZに問題が出そうな時、トラフィックを別AZに自動でシフトする
        1. Route53: AWS上のDNSサービス
4. DB
    1. RDSがDb2(IBM製RDB)をサポート
        1. RDS:  RDBのマネージドサービス.   Relational Database Service
    2. Aurora Limitless Database：　シャーディング不要で数百万/秒のWrite、ペタバイト級のデータ量までスケール
        2. Aurora Serverlessの進化系
    3. ElastiCache Serverless:  設定不要で即座にスケール。複数AZに自動でレプリケーション
        1. ElastiCache:  マネージドのインメモリDB。　RedisとMemcacheがある
    4. Redshift Serverless with AI-driven scaling and optimization：　AIが自動でリソース量を最適化→コスト最適化。費用と性能のバランスは調整可能
        1. Redshift: Data Ware Houseのマネージドサービス
    5. Zero-ETL関連：　ETL処理の作り込み無しに、取り込んだデータをそのまま分析できる（性能は未知数）

        1. Redshiftに対するzero-ETL (preview)
        2. DynamoDBからOpenSearch ServiceとのzeroETL対応 (GA)
            1. → AIがRAGで検索する際に必要
        3. OpenSearch とS3のZero-ETL統合
        4. AthenaがCloudTrail LakeのZero-ETL分析に対応：　AWSのAPIコールログを簡単に分析可能に
            1. CloudTrail:  AWSのAPIコールログが蓄積されるサービス
        5. Amazon Connect analytics data lake: コールセンターの統合的なデータレイクを構成できる

        ※Zero-ETLのわかりやすい解説：https://tech.nri-net.com/entry/what_is_a_zero_etl_future
5. Others
    1. SDK： Kotlin, Rust版がGA
    2. Fault Injection Simulatorでイベントシナリオが2つ追加　（疑似障害を起こして、回復力を試すためのサービス。Chaos Engineering関連）
        1. AZの電源喪失
        2. リージョン間の接続切断

---

# セッション

- 面白そうなセッション
  - [**Do modern cloud applications lock you in?**](https://youtu.be/jykSBmnAM2I?si=ZrZ7GEiImbxSarl_)
    - クラウド/OSS界隈ではロックインが論点になりがちなので、参考になりそう
    - 「OSSベースのマネージドサービスは、スイッチングコストを抑える一つの手段となる」といった話も
    - Summary記事：https://dev.classmethod.jp/articles/aws-re-invent-2023-arc307/
  - [**Platform Engineering with Amazon EKS**](https://www.youtube.com/watch?v=eLxBnGoBltc)
    - Platformの提供パターンがいくつか出ている
  - [**Modernization of Nintendo eShop: Microservice and platform engineering**](https://www.youtube.com/watch?v=grdawJ3icdA&list=PLBzJ4gdGNusEj7HhTEFms1RhlPYG3EFES&index=21)
    - 任天堂のクラウドネイティブ話（マイクロサービス、Platform Engineering、ECS、API Management By Kong）
- 他面白そうなセッションのリスト（約20本）：　https://www.youtube.com/playlist?list=PLBzJ4gdGNusEj7HhTEFms1RhlPYG3EFES
  - Developer Productivity, Platform Engineering, DevOps, Containerなど
  - 時間無い方向け：　Classmethod社が各セッションのレポート記事を出してるので、それを読んだ方が速いかも
    - 一覧：　[https://dev.classmethod.jp/search?q=セッションレポート&tags=AWS re%3AInvent 2023&page=1](https://dev.classmethod.jp/search?q=%E3%82%BB%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3%E3%83%AC%E3%83%9D%E3%83%BC%E3%83%88&tags=AWS%20re%3AInvent%202023&page=1)

---

## Refs

- re:Invent 2023速報（1hまとめ）：　re:InventのUpdate内容をAWS Japanの方が網羅的に解説
  - YouTube: https://www.youtube.com/watch?v=Mq_I3H3BPQI
  - PDF：https://pages.awscloud.com/rs/112-TZM-766/images/AWS-Black-Belt_2023_reInvent2023digest_1201_v1.pdf
