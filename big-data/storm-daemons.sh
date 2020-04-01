#! /bin/bash

# Storm Cluster address
hosts=(box0 box1 box2)

# print script infomation
mill=`date "+%N"`
tdate=`date "+%Y-%m-%d %H:%M:%S,${mill:0:3}"`

echo [%tdate] INFO [Storm Cluster] begins to execute the $1 operation.

# execute the distributed start command script
function start()
{
			smill=`date "+%N"`
			stdate=`date "+%Y-%m-%d %H:%M:%S,${smill:0:3}"`
			ssh jinzhongxu@box0 "source /etc/profile;echo [$sdate] INFO [Storm Nimbus box0] begins to execute the startup operation.;/home/jinzhongxu/storm/bin/storm nimbus>/dev/null;" &
			sleep 1
			ssh jinzhongxu@box0 "source /etc/profile;echo [$sdate] INFO [Storm UI box0] begins to execute the startup operation.;/home/jinzhongxu/storm/bin/storm ui>/dev/null;" &
			sleep 1
			ssh jinzhongxu@box1 "source /etc/profile;echo [$sdate] INFO [Storm Supervisor box1] begins to execute the startup operation.;/home/jinzhongxu/storm/bin/storm supervisor>/dev/null;" &
			sleep 1
			ssh jinzhongxu@box2 "source /etc/profile;echo [$sdate] INFO [Storm Supervisor box2] begins to execute the startup operation.;/home/jinzhongxu/storm/bin/storm supervisor>/dev/null;" &
			sleep 1
}

# execute the distributed shutdown command script
function stop()
{
			smill=`date "+%N"`
			stdate=`date "+%Y-%m-Td %H:%M:%S,${smill:0:3}"`
			ssh jinzhongxu@box0 "source /etc/profile;echo [$stdate] INFO [Storm Cluster box0] begins to execute the shutdown operation;kill -9 `ssh jinzhongxu@box0 jps | grep Nimbus |  awk '{print $1}'| head -n 1`" &
			sleep 1
			ssh jinzhongxu@box0 "source /etc/profile;echo [$stdate] INFO [Storm Cluster box0] begins to execute the shutdown operation;kill -9 `ssh jinzhongxu@box0 jps | grep UIServer |  awk '{print $1}'| head -n 1`" &
			sleep 1
			ssh jinzhongxu@box1 "source /etc/profile;echo [$stdate] INFO [Storm Cluster box1] begins to execute the shutdown operation;kill -9 `ssh jinzhongxu@box1 jps | grep Supervisor |  awk '{print $1}'| head -n 1`" &
			sleep 1
			ssh jinzhongxu@box2 "source /etc/profile;echo [$stdate] INFO [Storm Cluster box2] begins to execute the shutdown operation;kill -9 `ssh jinzhongxu@box2 jps | grep Supervisor |  awk '{print $1}'| head -n 1`" &
			sleep 1
}

# check the status of kafka broker
function status()
{
	for i in ${hosts[@]}
		do
			smill=`date "+%N"`
			stdate=`date "+%Y-%m-%d %H:%M:%S,${smill:0:3}"`
			ssh jinzhongxu@$i "source /etc/profile;jps | grep Nimbus;" &
			ssh jinzhongxu@$i "source /etc/profile;jps | grep UIServer;" &
			ssh jinzhongxu@$i "source /etc/profile;jps | grep Supervisor;" &
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
