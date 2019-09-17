# memtier-json 

[memtier_benchmark](https://github.com/RedisLabs/memtier_benchmark) 의 실행 옵션을 json 파일로 설정할 수 있게 한 스크립트입니다.

인자를 매번 설정해주는 대신 자주 쓰는 설정을 저장해두고 편하게 쓸 수 있습니다.

사용을 위해 파이썬2 (2.6 이상) 또는 파이썬3가 필요합니다.

# 사용법

1. memtier-json.py의 6번째 줄의 memtier_path를 memtier_benchmark의 실행파일의 주소로 수정합니다.
2. conf/memtier-sample.json 파일을 참고해 실행 설정을 저장한 json 파일을 만듭니다. 
3. 설정 파일을 인자로 주어 memtier-json.py를 실행합니다.

```
python ./memtier-json.py conf/memtier-sample.json
```

# json 파일 설정법

json의 key는 memtier_benchmark의 command line argument입니다. argument 앞의 dash를 생략해서 입력합니다. short option(-S)과 long option(--server) 모두 사용 가능합니다.

## 예시 

```
"server":"127.0.0.1"
"P":12001
```

아직 value가 없는 옵션은 지원이 안 됩니다. 
