#! /bin/bash

# set Zookeeper address
hosts=(box0 box1 box2)

# pull arguments of Zookeeper command
cmd=$1

# implement distributed administration command
function zookeeper()
{
	for i in ${hosts[@]}
		do
			ssh jinzhongxu@$i "source /etc/profile;/home/jinzhongxu/zookeeper/bin/zkServer.sh $cmd;echo Zookeeper node is $i, run $cmd command. " &
			sleep 1
		done
}

# judge the effectiveness of the inputed Zookeeper commands
case "$1" in
	start)
		zookeeper
		;;
	stop)
		zookeeper
		;;
	status)
		zookeeper
		;;
	start-foreground)
		zookeeper
		;;
	upgrade)
		zookeeper
		;;
	restart)
		zookeeper
		;;
	print-cmd)
		zookeeper
		;;
	*)
		echo "Usage: $0 {start|start-foreground|stop|restart|status|upgrade|print-cmd}"
		RETVAL=1
esac
