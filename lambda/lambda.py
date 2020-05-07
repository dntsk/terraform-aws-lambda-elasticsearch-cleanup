from elasticsearch import Elasticsearch
import datetime
import os

cluster = os.environ['ENDPOINT'].split('/')[-1]
index_prefix = os.environ['INDEX']
keep = os.environ['KEEP']
earliest_to_keep = datetime.date.today() - datetime.timedelta(days=int(keep))


def main():
    es = Elasticsearch([f'https://{cluster}:443'])

    indexes = es.indices.get_alias(f'{index_prefix}-*')
    earliest_to_keep_date = earliest_to_keep.strftime("%Y.%m.%d")

    for i in sorted(indexes):
        index_date = i.split('-')[-1]
        if i.startswith(index_prefix) and index_date < earliest_to_keep_date:
            print(f'Deleting index: {i}')
            es.indices.delete(index=i, ignore=[400, 404])


def handler(event, context):
    main()


if __name__ == "__main__":
    main()
