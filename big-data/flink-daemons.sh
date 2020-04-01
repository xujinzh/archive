#! /bin/bash

# Flink Master address
hosts=(box0)

# print script infomation
mill=`date "+%N"`
tdate=`date "+%Y-%m-%d %H:%M:%S,${mill:0:3}"`

echo [%tdate] INFO [Flink Cluster] begins to execute the $1 operation.

# execute the distributed start command script
function start()
{
	for i in ${hosts[@]}
		do
			smill=`date "+%N"`
			stdate=`date "+%Y-%m-%d %H:%M:%S,${smill:0:3}"`
			ssh jinzhongxu@$i "source /etc/profile;echo [$sdate] INFO [Flink Master $i] begins to execute the startup operation.;/home/jinzhongxu/flink/bin/start-cluster.sh>/dev/null;" &
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
			ssh jinzhongxu@$i "source /etc/profile;echo [$stdate] INFO [Flink Master $i] begins to execute the shutdown operation;/home/jinzhongxu/flink/bin/stop-cluster.sh>/dev/null" &
			sleep 1
		done
}

# check the status of flink master
function status()
{
	for i in ${hosts[@]}
		do
			smill=`date "+%N"`
			stdate=`date "+%Y-%m-%d %H:%M:%S,${smill:0:3}"`
			ssh jinzhongxu@$i "source /etc/profile;echo [$stdate] INFO [Flink Master $i] status message is :;jps | grep StandaloneSessionClusterEntrypoint;" &
			sleep 1
		done
}

# judge the effectiveness of flink command
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
