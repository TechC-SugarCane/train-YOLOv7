# Google ColabでYOLOv7のモデルをトレーニングする

## 0: 事前準備

- ランタイムのタイプをGPUに設定しておく
- google driveをあらかじめマウントしておく
- `/content`ディレクトリにいることを確認する
- [Roboflow](https://roboflow.com/)にログインしておく

## 1: セットアップ

colabを起動したらYOLOv7をクローンしてyolov7ディレクトリに移動

```python
!git clone https://github.com/WongKinYiu/yolov7
%cd yolov7
```

`requirements.txt`を開いて `PyYAML`以外のライブラリをすべてコメントアウトまたは削除して、以下のコマンドを入力

```python
!pip install -r requirements.txt
```

## 2: 事前学習済みモデルを取得する

事前学習済みモデルを取得するためのディレクトリをあらかじめ作っておく

```python
!mkdir ckpt
```

以下ののリンクをクリックして事前学習済みモデルをダウンロードする

- [yolov7-tiny.pt](https://github.com/WongKinYiu/yolov7/releases/download/v0.1/yolov7-tiny.pt)


エクスプローラーを開くと`ダウンロード`フォルダーに保存されているので、
取得したファイルをgoogle driveにアップロードする

(デフォルトでは)`drive/MyDrive/`の中にアップロードされたモデルファイルを先ほど作成したディレクトリに移動させる

## 3: データセットのダウンロード

- Roboflowに移動し`Export Dataset`を選択する
- デフォルトで`YOLO v7 PyTorch`, `shwo download code`になっているので`continue`を押す
- でできたコードをすべてコピーしてcolabに張り付けて実行する
- `data.yaml`ファイルが中にあるので`data`ディレクトリに移動させておく

## 4: コードを一部編集する

`./yolov7/utils/loss.py`を開く

`1387`行目, `1540`行目にあるコードを以下のように変更する

`matching_matrix = torch.zeros_like(cost)` \rightarrow `matching_matrix = torch.zeros_like(cost, device="cpu")`

## 5: 学習させる

以下のコマンドを入力して学習を開始させる

```python
!python train.py --workers 2 --batch-size 8 \
    --data data/data.yaml \
    --cfg cfg/training/yolov7-tiny.yaml \
    --weights 'ckpt/yolov7-tiny.pt' \
    --name {任意の名前} \
    --hyp data/hyp.scratch.tiny.yaml \
    --epochs {任意の数} \
    --device 0
```