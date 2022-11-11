# ObjectDetection

オブジェクトディテクション用のモデルのトレーニングおよび検証を行うためのリポジトリ

Azure Custom Vision, Yolov7をそれぞれ使用しトレーニングを行う

### Branch

- main: メインのリポジトリモデルの比較を行い性能が良いほうをこのブランチの中に置く。

- Azure: Azure Custom Visionを使ったモデルのトレーニングおよびモデルの検証を行うためのブランチ

- Yolo: Yoloを使ったモデルのトレーニングおよびモデルの検証を行うためのブランチ

### YoLov7

上記のコードは[公式サイト](https://github.com/WongKinYiu/yolov7)のコードを一部変更してローカル環境で実装しています。

推論結果は[こちら](./runs/detect/exp-yolov7-e6-sugarcane-valid22)
