# Define and deploy a rack topology script

# **Author:** Linou.Zhang
# **Create Time:** 2017/7/31


### 1. Config core-site.xml
```
<property>
 <name>topology.script.file.name</name>
 <value>/etc/hadoop/conf/rack-topology.sh</value>
 </property>

<property>
 <name>topology.script.number.args</name>
 <value>100</value>
<description>The max number of args that the script configured with net.topology.script.file.name should be run with. Each arg is an IP address. </description>
 </property>
```

### 2. topology script
```
#!/bin/bash
# Adjust Add the property "net.topology.script.file.name"
#to core-site.xml with the "absolute" path the this file. ENSURE the file is "executable".

#Supply appropriate rack prefix
RACK_PREFIX=dc01

#To test, supply a hostname as script input:
if [ $# -gt 0 ]; then
        CTL_FILE=${CTL_FILE:-"rack_topology.data"}
        HADOOP_CONF=${HADOOP_CONF:-"/etc/hadoop/conf"}

        if [ ! -f ${HADOOP_CONF}/${CTL_FILE} ]; then
                echo -n "/$RACK_PREFIX "
                exit 0
        fi
        while [ $# -gt 0 ] ; do
                nodeArg=$1
                exec< ${HADOOP_CONF}/${CTL_FILE}
                result=""
                while read line ; do
                        ar=( $line )
                        if [ ${ar[0]} = $nodeArg ] ; then
                                result=${ar[1]}
                        fi
                done
                shift
                if [ -z "$result" ] ; then
                        echo -n "/$RACK_PREFIX "
                else
                        echo -n "/$RACK_PREFIX_$result "
                fi
        done
else
        echo -n "/$RACK_PREFIX "
fi

```

### 3. rack_toplogy.data
```
192.168.56.10 A1
192.168.56.11 A2
192.168.56.12 A3

```

## Finally
