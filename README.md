# memtier-json 

[memtier_benchmark](https://github.com/RedisLabs/memtier_benchmark) 의 실행 옵션을 json 파일로 설정할 수 있게 한 스크립트입니다.

사용을 위해 파이썬2 (2.6 이상) 또는 파이썬3가 필요합니다.

# 사용법 

1. memtier-json.py의 6번째 줄의 memtier_path를 memtier_benchmark의 실행파일의 주소로 수정합니다.
2. conf/memtier-sample.json 파일을 참고해 실행 설정을 저장한 json 파일을 만듭니다. 
3. 설정 파일을 인자로 주어 memtier-json.py를 실행합니다.

```
python ./memtier-json.py conf/memtier-sample.json
```
