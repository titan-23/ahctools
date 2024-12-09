# ahctools

AHC並列実行のツールです。

## インストール方法

インストールには以下のコマンドを実行してください。

```shell
$ python3 -m pip install git+https://github.com/titan-23/ahctools
```

アンインストールするときは以下です。

```shell
$ python3 -m pip uninstall git+https://github.com/titan-23/ahctools
```

## 使い方

### 並列実行

以下のコマンドで実行できます。
```shell
$ python3 -m ahctools test [-c] [-v] [-r]
```

コマンドオプション:
- `-c` コンパイルします。
- `-v` ログを表示します。
- `-r` 標準出力と標準エラー出力をファイルに保存します。オプションを指定しない場合、結果を記録したcsvファイルのみを得られます。

### optunaを用いたパラメータ探索



## `ahc_settings.py`

`parallel_tester.py`, `optimizer.py` のための設定ファイル。
以下のものを書く。

### 共通

- コンパイルコマンド
    - `compile_command = 'g++ ./main.cpp -O2 -std=c++20'` など
- 実行コマンド
    - `execute_command = './a.out'` など
- 入力ファイル(リスト)
    - `input_file_names = [f'./in/{str(i).zfill(4)}.txt' for i in range(100)]` など
    - `optimizer` 用の時は、テストケースを減らすとよいかも
- 制限時間
    - `timeout=2000` など
    - 指定しないときは `None` とするとよい
- 表示するだけの関数 `get_score`

### `optimizer` 用
- `study_name`
    - `study_name = 'test'` など
    - `study_name` が既にある場合、そのデータベースが利用される。
- `direction`
    - `direction = 'maximize'` など
    - minimize / maximize
- `multi_run` の `cpu_count`
    - `n_jobs_multi_run = 10` など
    - 多くしたい
- optuna の試行回数
    - `n_trials = 50` など
- optuna の `cpu_count`
    - `n_jobs_optuna = 1` など
    - 増やし過ぎには注意
- 推定するもの
    - `objective(trial: optuna.trial.Trial) -> tuple:`
    - 返り値のタプルはコマンドライン引数として渡す順番にする

## `parallel_tester.py`

テストケースを並列実行します。

例：
```shell
python3 ./parallel_tester.py -c -v -njobs 10
```

### コマンドライン引数
- `-c`
    - コンパイルします。
- `-v`
    - ログを表示します。
- `-njobs num`
    - cpu数を指定します。

## `optimizer.py`

optuna を用いてパラーメタ探索をして、よしなに出力します。

例：
```shell
python3 ./oprimizer.py
```
