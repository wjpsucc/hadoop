# New user want to use hadoop
# 1) add the user to he datanodes without login permission
useradd -g group_name -G group_name user_name

# create a user home
hdfs dfs -mkdir /user/user_name
hdfs dfs -chown user_name:group_name /user/user_name

