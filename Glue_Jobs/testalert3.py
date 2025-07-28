import sys
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext

# Setup
args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

print("Hello from Terraform")
# Just print something
print("Glue Job2 Started.")
print("Hello from Glue 2!")

# Uncomment to simulate failure
raise Exception("Simulated failure in glue-job-2")
print("Glue Job 2 Completed Successfully")
