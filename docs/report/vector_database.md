# vector database

## vector 向量数据
向量数据是由多个数值组成的序列, 可以表示一个数据量的大小和方向. 通过Embedding技术, 图像、声音、文本都可以被表达为一个高维的向量, 比如一张图片可以转换为一个由像素值构成的向量. 其特点有:
- 高维: 向量数据通常有很多元素, 维度很高.
- 稀疏: 向量数据中很多元素的值可能为零或接近零. 
- 异构: 向量数据中的元素可能有不同的类型或含义. 
- 动态: 向量数据可能随着时间或环境变化而变化. 

## vector database 向量数据库
向量数据库是一种专门用于存储和查询向量数据的数据库系统. 

向量数据库可能支持的操作, 如: 
- 向量检索(最核心): 根据给定的向量, 找出数据库中与之最相似的若干向量
- 向量聚类: 根据给定的相似度度量, 将数据库中的向量分类
- 向量降维: 根据给定的目标维度, 将数据库中的高维向量转换成低维向量, 以便于可视化或压缩存储. 

推荐阅读: [AWS-What is vector database](https://aws.amazon.com/what-is/vector-databases/)

## vector database的核心技术/挑战
### 1. 向量索引技术
- 针对问题: 向量数据维度很高, 直接进行全量扫描或者基于树结构的索引会导致效率低下或者内存爆炸. 
- 解决方法: 采用近似搜索算法来加速向量的检索, 通常利用向量之间的距离或者相似度来检索出与查询向量相近的K个向量.
- 距离度量
    - 浮点型向量计算方式
        - 内积(IP)
        - 欧式(L2)
        - 余弦(Cosine)
    - 二值型向量计算方式
        - 汉明距离 (Hamming)
        - 杰卡德距离 (Jaccard)
        - 谷本距离 (Tanimoto)
- 常用近似搜索算法
    - 基于树
        - KD-树(K-Dimensional Tree)
        - Annoy(Approximate Nearest Neighbors Oh Yeah)
    - 基于图
        - NSW(Navigating Small World)
        - HNSW(Hierarchical Navigating Small World)
    - 基于量化
        - SQ(ScalarQuantization)
        - PQ(Product Quantization)
    - 基于哈希
        - LSH(Locality-Sensitive Hashing)

推荐阅读: https://mdnice.com/writing/ffd73929e77a41868bc848fd67995978

### 2. 硬件加速技术
- 针对问题: 向量数据计算密集, 单纯依靠CPU的计算能力难以满足实时性和并发性的要求. 
- 解决方法: 利用专用硬件来加速向量运算, 这些硬件包括GPU, FPGA, AI芯片等, 用于提供更高的浮点运算能力和并行处理能力. 

### 3. 大规模数据, 分布式系统架构
- 针对问题: 向量数据规模庞大, 单机无法满足存储、计算需求. 
- 解决方法: 使用分布式系统, 这面临与其他类型数据库使用分布式架构类似的挑战.

### 其他挑战
参考自[11 known issues of vector-based database used for AI prompting](https://medium.com/@don-lim/known-issues-of-vector-based-database-for-ai-ae44a2b0198c), 谈得比较笼统, 选取其中相对有价值的论点.

1. vector database主要为处理高维vector数据设计进行优化, 不适合非vector format格式的数据, 如categorical variables(枚举类型) or missing values.
2. 相似度搜索的计算开销高
3. 高维数据不便于可视化和交互, 对于依赖vector representation的AI和ML模型, debug 和 fine-tune比较困难.
4. 高维vector的索引维护开销高, 尤其是维度增加时
5. 数据稀疏, vector中大量元素为0导致计算的低效.

## 主流的向量数据库
结合[DB-Engines](https://db-engines.com/en/ranking/vector+dbms)的榜单和[OpenAI docs](https://platform.openai.com/docs/guides/embeddings/how-can-i-retrieve-k-nearest-embedding-vectors-quickly)推荐的产品,
- Chroma, an open-source embeddings store
- Pinecone, a fully managed vector database
- Milvus, a vector database built for scalable similarity search
    - Zilliz, data infrastructure, powered by Milvus
- Weaviate, an open-source vector search engine
- Qdrant, a vector search engine

以上vector database都提供了与OpenAI等LLM提供商的集成能力

此外, [OpenAI cookbook](https://github.com/openai/openai-cookbook/tree/main/examples/vector_databases)中提供了许多vector database的使用案例.

### Chroma
https://www.trychroma.com/

- 开源
- 轻量级, 核心API只有4个函数. 底层存储基于clickhouse和duckdb.
- 支持向量检索与元数据过滤
- 近似搜索算法依赖Hnswlib, 距离度量支持L2, IP, Cosine
- 只有In-memory版本, client/server版本in alpha. 文档, 部署等相对不成熟.
- 数据类型仅支持Embedding和document, 尚不支持image, audio, video等
- Client SDK: Python, JS

```python
import chromadb
# setup Chroma in-memory, for easy prototyping. Can add persistence easily!
client = chromadb.Client()

# Create collection. get_collection, get_or_create_collection, delete_collection also available!
collection = client.create_collection("all-my-documents")

# Add docs to the collection. Can also update and delete. Row-based API coming soon!
collection.add(
    documents=["This is document1", "This is document2"], # we handle tokenization, embedding, and indexing automatically. You can skip that and add your own embeddings as well
    metadatas=[{"source": "notion"}, {"source": "google-docs"}], # filter on these!
    ids=["doc1", "doc2"], # unique for each doc
)

# Query/search 2 most similar results. You can also .get by id
results = collection.query(
    query_texts=["This is a query document"],
    n_results=2,
    # where={"metadata_field": "is_equal_to_this"}, # optional filter
    # where_document={"$contains":"search_string"}  # optional filter
)
```

![chroma架构](https://www.trychroma.com/hrm4.svg)

### Pinecone
https://www.pinecone.io/

AutoGpt使用OpenAI API+Pinecone的组合, 因此Pinecone应该是最流行的vector database, 客户众多.
- 闭源, 云原生分布式架构
- 全托管服务, 开箱即用, 自动扩展, 按需付费, 新手友好. 
- 支持向量检索与元数据过滤
- 专有近似搜索算法和索引优化. 毫秒级查询延迟, 支持十亿级数据. sparse-dense向量支持友好. 实时更新索引
- 数据类型支持完善
- 距离度量支持L2, IP, Cosine
- 监控管理GUI
- Client SDK: Python, JS, RESTful API

![Pinecone架构](https://raw.githubusercontent.com/pinecone-io/img/main/Pinecone%20architecture%20diagram.png)

### Milvus & Zilliz
https://milvus.io/

最早发布的向量数据库, 在开源向量数据库产品中社区影响力较大, 用户众多
- 开源, 云原生分布式架构, 存储计算分离
- Zilliz 是基于Milvus的全托管服务, 类似于Pinecone. 
- 支持向量检索与元数据过滤
- 近似算法包括SQ, PQ, HNSW, ANNOY等以适应不同场景
- 支持十亿级数据.
- 可配置一致性, 用户自定义函数
- 数据类型支持完善
- 距离度量支持L2, IP, Jaccard, Tanimoto, Hamming, Superstructure, Substructure
- 监控管理GUI
- Client SDK: Python, Java, Go, JS等

![Milvus 架构](https://milvus.io/static/7a0dfbdf7722f8e63278244f984d353f/52173/architecture_02.jpg)

### Weaviate
https://weaviate.io/

- 开源, 云原生分布式架构, 同时有全托管版本
- 支持向量检索与元数据过滤, 还支持生成式检索(用LLM改善检索结果)
- 近似算法采用自定义HNSW
- 距离度量支持L2, IP, Cosine
- Client SDK: Python, Java, Go, JS等. 支持GraphQL和RESTful

![weaviate架构](https://weaviate.io/assets/files/weaviate-architecture-overview-54e15328eb9bdfe6695f85443d892f2e.svg)

### Qdrant
https://qdrant.tech/

- 开源, 云原生分布式架构, 同时有全托管版本
- 支持向量检索与元数据过滤. 支持多种数据类型和查询条件, 包括字符串匹配、数值范围、地理位置等.
- 近似算法采用自定义HNSW

![Qdrant 架构](https://raw.githubusercontent.com/ramonpzg/mlops-sydney-2023/main/images/qdrant_overview_high_level.png)

## Benchmark
对于vector database的第三方中立benchmark似乎很少, 也没有涵盖这5款主流的产品, 找到一个[Qdrant做的benchmark](https://qdrant.tech/benchmarks/), 仅供参考.

## 结论
vector database的核心挑战围绕vector数据类型本身所固有的问题————高维、稀疏/稠密、计算密集, 检索的性能是最关键的考量, 除了Chroma直接利用第三方库外, 其他产品都会对现有近似搜索算法进行优化, 来作为一个卖点. 还有提高检索接口的定制化程度, 从基本的向量检索, 到支持各种形式的元数据过滤, 甚至Weaviate加入了LLM改善查询结果. 而在距离度量和数据类型上的支持, 则是越丰富越好. 

从产品形态上看, Chroma与其他主流vector database区别较为明显, 正如OpenAI对它的定义"embeddings store", 很难称得上是一个完备的数据库, 相关文档也比较有限, 但足够轻量级, 适合简单的项目尝试.

全托管类型的数据库开箱即用, 运维简单, 可扩展性, 可用性也有保障, 产品形态都像最火热的Pinecone看齐. Pinecone和Zilliz是影响力较大的两款, 其文档, 生态工具比较完备, 也有不少企业客户选用. weaviate和Qdrant相对就要逊色一些.

考虑私有化部署, 自己维护管理, Milvus看来是不错的选项, 有最活跃的开源社区和最丰富的特性.