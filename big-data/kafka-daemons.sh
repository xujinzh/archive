#! /bin/bash

# Kafka broker address
hosts=(box0 box1 box2)

# print script infomation
mill=`date "+%N"`
tdate=`date "+%Y-%m-%d %H:%M:%S,${mill:0:3}"`

echo [%tdate] INFO [Kafka Cluster] begins to execute the $1 operation.

# execute the distributed start command script
function start()
{
	for i in ${hosts[@]}
		do
			smill=`date "+%N"`
			stdate=`date "+%Y-%m-%d %H:%M:%S,${smill:0:3}"`
			ssh jinzhongxu@$i "source /etc/profile;echo [$sdate] INFO [Kafka Broker $i] begins to execute the startup operation.;/home/jinzhongxu/kafka/bin/kafka-server-start.sh /home/jinzhongxu/kakfa/config/server.properties>/dev/null;" &
			sleep 1
		done
}

# execute the distributed shutdown command script
function stop()
{
	for i in ${hosts[@]}
		do 
			smill=`date "+%N"`
			stdate=`date "+%Y-%m-Td %H:%M:%S,${smill:0:3}"`
			ssh jinzhongxu@$i "source /etc/profile;echo [$stdate] INFO [Kafka Broker $i] begins to execute the shutdown operation;/home/jinzhongxu/kafka/bin/kafka-server-stop.sh>/dev/null" &
			sleep 1
		done
}

# check the status of kafka broker
function status()
{
	for i in ${hosts[@]}
		do
			smill=`date "+%N"`
			stdate=`date "+%Y-%m-%d %H:%M:%S,${smill:0:3}"`
			ssh jinzhongxu@$i "source /etc/profile;echo [$stdate] INFO [Kafka Broker $i] status message is :;jps | grep Kafka;" &
			sleep 1
		done
}

# judge the effectiveness of kafka command
case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	status)
		status
		;;
	*)
		echo "Usage: $0 {start|stop|status}"
		RETVAL=1
esac
