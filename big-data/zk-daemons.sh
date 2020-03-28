#! /bin/bash
hosts=(box0 box1 box2)
for i in ${hosts[@]}
	do
		ssh jinzhongxu@$i "source /etc/profile;/home/jinzhongxu/zookeeper/bin/zkServer.sh $1" &
	done

# zookeeper distributed active script, you can input "start|stop|restart|status" etc. command.
