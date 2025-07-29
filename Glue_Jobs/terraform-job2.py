import sys
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext

# Setup
args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

# Just print something
print("Glue Job2 Started")
print("Hello from Glue 2!")

# Uncomment to simulate failure
# raise Exception("Simulated failure in glue-job-2")
print("Glue Job 2 Completed Successfully")
print("checking the update from terraform")
print("terraform job 2 completed successfully")
print("Hello from Terraform") 
print("This is a test for Glue Job 2 with Terraform integration") 