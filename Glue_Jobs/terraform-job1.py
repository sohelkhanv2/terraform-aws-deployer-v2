from pyspark.context import SparkContext
from awsglue.context import GlueContext
from pyspark.sql import SparkSession

# Initialize Spark/Glue
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

# Just print something
print("Glue Job 1Started")
print("Hello from Glue 1!")
print("glue job 1 completed Successfully")
print("hello this is testing for glue job 1")