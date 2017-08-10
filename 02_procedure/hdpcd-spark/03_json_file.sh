# define import
from pyspark.sql.types import *
from pyspark.sql import Rows

# define input/output
input = ''
output = ''
ter = '¥t'

# load file from csv file
rdd1 = sc.textFile(input).map(lambda l: l.split(ter))
rdd2 = rdd1.map(lambda m: Row(a=m[0], b=m[1], c=m[2]))

# Create DataFrame
df1 = sqlContext.createDataFrame(rdd2)
df2 = df1.withColumn('g', df1['a'].cast(IntegerType()))

# registerTable
df2.registerTempTable('tbl')

# define sql
sql = 'select a, b, c from tbl where g > 10 order by g'

# result
dfr = sqlContext.sql(sql)

# output
dfr.rdd.map(lambda l: ','.join(str(d) for d in l)).saveAsTextFile(output)

# Confirm
dfc = sc.textFile(output)
for i in dfc.take(10): print i
