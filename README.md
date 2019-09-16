# memtier-json 

[memtier_benchmark](https://github.com/RedisLabs/memtier_benchmark) 의 실행 옵션을 json 파일로 설정할 수 있게 한 스크립트입니다.

사용을 위해 파이썬2 또는 파이썬3가 필요합니다.

# 사용법

```
cd <memtier_benchmark-path>
mkdir conf
vi conf/memtier-sample.json
python memtier-json.py conf/memtier-sample.json 
```

1. memtier-json.py 를 memtier_benchmark 와 같은 디렉토리로 옮깁니다.
2. memtier_benchmark 디렉토리 안에 conf 디렉토리를 만듭니다.
3. 실행 옵션을 json 파일로 작성합니다
4. memtier-json.py에 json 파일을 인자로 주어 실행합니다.

